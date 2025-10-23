import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// AI Chatbot Widget with Local FAQ Database
/// Provides instant answers to common customer questions
class AIChatbotWidget extends StatefulWidget {
  const AIChatbotWidget({super.key});

  @override
  State<AIChatbotWidget> createState() => _AIChatbotWidgetState();
}

class _AIChatbotWidgetState extends State<AIChatbotWidget> with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _isTyping = false;
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late AnimationController _pulseController;

  // Local FAQ Database
  final List<FAQItem> _faqDatabase = [
    FAQItem(
      keywords: ['shipping', 'delivery', 'ship', 'deliver', 'how long'],
      question: 'How long does shipping take?',
      answer: '🚚 We offer FREE shipping on all orders!\n\n• Standard: 5-7 business days\n• Express: 2-3 business days\n• Overnight: Next business day\n\nAll orders are processed within 24 hours!',
    ),
    FAQItem(
      keywords: ['return', 'refund', 'money back', 'satisfaction'],
      question: 'What is your return policy?',
      answer: '💯 We offer a 30-day money-back guarantee!\n\nIf you\'re not completely satisfied, simply return the product within 30 days for a full refund. No questions asked!\n\nTo start a return, contact our support team.',
    ),
    FAQItem(
      keywords: ['warranty', 'guarantee', 'coverage', 'protection'],
      question: 'Do you offer a warranty?',
      answer: '🛡️ Yes! All products include:\n\n• 2-year manufacturer warranty\n• Free repairs or replacement\n• 24/7 customer support\n• Extended warranty available\n\nYour satisfaction is our priority!',
    ),
    FAQItem(
      keywords: ['payment', 'pay', 'credit card', 'paypal', 'secure'],
      question: 'What payment methods do you accept?',
      answer: '💳 We accept all major payment methods:\n\n• Visa, Mastercard, Amex\n• PayPal & Apple Pay\n• Google Pay\n• Bank transfers\n\n🔒 All transactions are 256-bit encrypted and secure!',
    ),
    FAQItem(
      keywords: ['track', 'tracking', 'order status', 'where is my order'],
      question: 'How can I track my order?',
      answer: '📦 Tracking is easy!\n\nOnce your order ships, you\'ll receive:\n\n1. Email with tracking number\n2. Real-time updates\n3. Delivery notifications\n\nYou can also check your order status in the "Orders" section of your account.',
    ),
    FAQItem(
      keywords: ['size', 'sizing', 'fit', 'dimensions', 'measurements'],
      question: 'What size should I order?',
      answer: '📏 Use our interactive size guide!\n\n• Detailed measurements\n• Fit recommendations\n• Customer reviews on sizing\n• Free exchanges available\n\nStill unsure? Our support team can help!',
    ),
    FAQItem(
      keywords: ['discount', 'coupon', 'promo', 'sale', 'deal'],
      question: 'Do you have any discounts?',
      answer: '🎉 Special offer just for you!\n\n• First-time customers: 15% OFF\n• Subscribe for exclusive deals\n• Bulk order discounts available\n• Seasonal sales\n\nUse code: WELCOME15 at checkout!',
    ),
    FAQItem(
      keywords: ['customer service', 'support', 'help', 'contact', 'phone'],
      question: 'How can I contact support?',
      answer: '👋 We\'re here to help 24/7!\n\n📧 Email: support@novaaimarket.com\n📱 Phone: 1-800-NOVA-MARKET\n💬 Live Chat: Right here!\n🕐 Response time: Under 1 hour\n\nOur team is ready to assist you!',
    ),
    FAQItem(
      keywords: ['quality', 'material', 'made of', 'durable'],
      question: 'What is the product made of?',
      answer: '⭐ Premium Quality Materials:\n\n• High-grade components\n• Eco-friendly materials\n• Rigorously tested\n• Built to last\n\nEvery product meets our strict quality standards!',
    ),
    FAQItem(
      keywords: ['stock', 'available', 'in stock', 'out of stock'],
      question: 'Is this item in stock?',
      answer: '✅ Yes, currently in stock!\n\n• Ready to ship today\n• Limited quantities available\n• High demand item\n• Order now to secure yours!\n\nStock updates in real-time on the product page.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    
    // Welcome message
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _addBotMessage('👋 Hi! I\'m your AI shopping assistant. How can I help you today?\n\nTry asking about:\n• Shipping & delivery\n• Returns & refunds\n• Product details\n• Discounts');
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleChat() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _addBotMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _addUserMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleMessage(String message) {
    if (message.trim().isEmpty) return;

    _addUserMessage(message);
    _messageController.clear();

    // Show typing indicator
    setState(() {
      _isTyping = true;
    });

    // Simulate AI thinking time
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isTyping = false;
      });

      // Find matching FAQ
      final response = _findBestAnswer(message.toLowerCase());
      _addBotMessage(response);
    });
  }

  String _findBestAnswer(String userMessage) {
    int bestScore = 0;
    FAQItem? bestMatch;

    for (var faq in _faqDatabase) {
      int score = 0;
      for (var keyword in faq.keywords) {
        if (userMessage.contains(keyword.toLowerCase())) {
          score += 10;
        }
      }

      if (score > bestScore) {
        bestScore = score;
        bestMatch = faq;
      }
    }

    if (bestScore > 0 && bestMatch != null) {
      return bestMatch.answer;
    }

    // Default response
    return '🤔 I\'m not sure about that, but I can help with:\n\n• Shipping information\n• Return policy\n• Payment methods\n• Product details\n• Order tracking\n\nOr contact our live support team for personalized assistance!';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Chat Window
        if (_isOpen)
          Positioned(
            right: 20,
            bottom: 90,
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(20),
              shadowColor: const Color(0xFF6366F1).withOpacity(0.5),
              child: Container(
                width: 380,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.smart_toy,
                              color: Color(0xFF6366F1),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nova AI Assistant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Color(0xFF10B981),
                                      size: 10,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Online • Ready to help',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: _toggleChat,
                          ),
                        ],
                      ),
                    ),

                    // Messages
                    Expanded(
                      child: Container(
                        color: const Color(0xFFF9FAFB),
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length + (_isTyping ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_isTyping && index == _messages.length) {
                              return _buildTypingIndicator();
                            }
                            return _buildMessageBubble(_messages[index]);
                          },
                        ),
                      ),
                    ),

                    // Quick Actions
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildQuickAction('🚚 Shipping', 'Tell me about shipping'),
                            _buildQuickAction('💯 Returns', 'What is the return policy?'),
                            _buildQuickAction('💳 Payment', 'What payment methods?'),
                            _buildQuickAction('📦 Track Order', 'How to track my order?'),
                          ],
                        ),
                      ),
                    ),

                    // Input Field
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: 'Type your question...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF6366F1),
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.emoji_emotions_outlined),
                                  onPressed: () {},
                                  color: Colors.grey[600],
                                ),
                              ),
                              onSubmitted: _handleMessage,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6366F1).withOpacity(0.4),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.send_rounded, color: Colors.white),
                              onPressed: () => _handleMessage(_messageController.text),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 300.ms).scale(delay: 100.ms),
          ),

        // Floating Button
        Positioned(
          right: 20,
          bottom: 20,
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (_pulseController.value * 0.1),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.4 + _pulseController.value * 0.2),
                        blurRadius: 20 + (_pulseController.value * 10),
                        spreadRadius: 5 + (_pulseController.value * 5),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleChat,
                      borderRadius: BorderRadius.circular(35),
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(16),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                _isOpen ? Icons.close : Icons.chat_bubble,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            if (!_isOpen && _messages.isEmpty)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEF4444),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser ? const Color(0xFF6366F1) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(message.isUser ? 16 : 4),
                  bottomRight: Radius.circular(message.isUser ? 4 : 16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : const Color(0xFF1F2937),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.grey, size: 20),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: message.isUser ? 0.2 : -0.2);
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.only(left: index > 0 ? 4 : 0),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6366F1),
                    shape: BoxShape.circle,
                  ),
                ).animate(onPlay: (controller) => controller.repeat())
                  .fadeOut(delay: Duration(milliseconds: index * 200), duration: 600.ms)
                  .then()
                  .fadeIn(duration: 600.ms);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String label, String message) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            _messageController.text = message;
            _handleMessage(message);
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6366F1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class FAQItem {
  final List<String> keywords;
  final String question;
  final String answer;

  FAQItem({
    required this.keywords,
    required this.question,
    required this.answer,
  });
}
