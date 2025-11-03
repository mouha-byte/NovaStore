import 'package:flutter/material.dart';
import '../models/product_model.dart';

// Import all modular sections
import 'landing_sections/navigation_widgets.dart';
import 'landing_sections/hero_section.dart';
import 'landing_sections/problem_solution_sections.dart';
import 'landing_sections/features_section.dart';
import 'landing_sections/videos_section.dart';
import 'landing_sections/how_it_works_section.dart';
import 'landing_sections/experts_section.dart';
import 'landing_sections/lifestyle_section.dart';
import 'landing_sections/testimonials_section.dart';
import 'landing_sections/customer_stories_section.dart';
import 'landing_sections/manufacturing_section.dart';
import 'landing_sections/trust_badges_section.dart';
import 'landing_sections/comparison_section.dart';
import 'landing_sections/before_after_section.dart';
import 'landing_sections/floating_offer_button.dart';
import 'landing_sections/pricing_section.dart';
import 'landing_sections/faq_section.dart';
import 'landing_sections/final_cta_section.dart';
import 'landing_sections/footer_section.dart';

/// Single Product Landing Page - Modular & Optimized
/// Designed to sell ONE product efficiently with modern, clean design
/// All sections have been modularized for better maintainability and performance
class SingleProductLanding extends StatefulWidget {
  final ProductModel product;

  const SingleProductLanding({
    super.key,
    required this.product,
  });

  @override
  State<SingleProductLanding> createState() => _SingleProductLandingState();
}

class _SingleProductLandingState extends State<SingleProductLanding> {
  final _scrollController = ScrollController();
  final _chatController = TextEditingController();
  bool _isScrolled = false;
  bool _showScrollToTop = false;
  
  // Section keys for navigation
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _videosKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();
  
  // Countdown timer state
  late DateTime _offerEndTime;
  Duration _timeRemaining = const Duration();
  
  // AI Chatbot visibility
  bool _showChatbot = false;
  bool _showQuickReplies = true;
  
  // Chat messages
  final List<Map<String, dynamic>> _chatMessages = [
    {
      'text': '👋 Hi! I\'m your AI shopping assistant. How can I help you today?',
      'isBot': true,
    },
  ];
  
  // Quick questions
  final List<String> _quickQuestions = [
    '💰 What\'s the price?',
    '🚚 Shipping info?',
    '⭐ View reviews',
    '❓ FAQ',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    
    // Set offer end time to 24 hours from now
    _offerEndTime = DateTime.now().add(const Duration(hours: 24));
    _updateCountdown();
    
    // Update countdown every second
    _startCountdownTimer();
  }
  
  void _startCountdownTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      _updateCountdown();
      _startCountdownTimer();
    });
  }
  
  void _updateCountdown() {
    if (!mounted) return;
    setState(() {
      _timeRemaining = _offerEndTime.difference(DateTime.now());
      if (_timeRemaining.isNegative) {
        // Reset to 24 hours when timer expires
        _offerEndTime = DateTime.now().add(const Duration(hours: 24));
        _timeRemaining = _offerEndTime.difference(DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final offset = _scrollController.offset;
    final newScrolled = offset > 100;
    final showScrollTop = offset > 500;
    
    if (newScrolled != _isScrolled || showScrollTop != _showScrollToTop) {
      setState(() {
        _isScrolled = newScrolled;
        _showScrollToTop = showScrollTop;
      });
    }
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  void _handleBuyNow() {
    // Navigate to cart with the product added
    Navigator.pushNamed(
      context,
      '/checkout',
      arguments: {
        'product': widget.product,
        'variant': null,
      },
    );
  }

  void _handleChatbot() {
    setState(() {
      _showChatbot = !_showChatbot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Space for navigation
                const SizedBox(height: 120),
                
                // Hero Section
                HeroSection(
                  product: widget.product,
                  onBuyNow: _handleBuyNow,
                ),
                
                // Problem & Solution Sections
                const ProblemSolutionSections(),
                
                // Features Section
                Container(
                  key: _featuresKey,
                  child: const FeaturesSection(),
                ),
                
                // Videos Section
                Container(
                  key: _videosKey,
                  child: const VideosSection(),
                ),
                
                // How It Works Section
                const HowItWorksSection(),
                
                // Experts Section
                const ExpertsSection(),
                
                // Lifestyle Section
                const LifestyleSection(),
                
                // Testimonials Section
                Container(
                  key: _testimonialsKey,
                  child: const TestimonialsSection(),
                ),
                
                // Customer Stories Section
                const CustomerStoriesSection(),
                
                // Manufacturing Section
                const ManufacturingSection(),
                
                // Trust Badges Section
                const TrustBadgesSection(),
                
                // Comparison Section
                const ComparisonSection(),
                
                // Before/After Section
                const BeforeAfterSection(),
                
                // Limited Offer Section
                
                // Pricing Section
                Container(
                  key: _pricingKey,
                  child: PricingSection(
                    onBuyNow: _handleBuyNow,
                  ),
                ),
                
                // FAQ Section
                Container(
                  key: _faqKey,
                  child: const FAQSection(),
                ),
                
                // Final CTA Section
                FinalCTASection(
                  onBuyNow: _handleBuyNow,
                ),
                
                // Footer Section
                const FooterSection(),
              ],
            ),
          ),
          
          // Fixed Navigation at Top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavigationWidgets(
              isScrolled: _isScrolled,
              onBuyNow: _handleBuyNow,
              onFeaturesClick: () => _scrollToSection(_featuresKey),
              onVideosClick: () => _scrollToSection(_videosKey),
              onReviewsClick: () => _scrollToSection(_testimonialsKey),
              onPricingClick: () => _scrollToSection(_pricingKey),
              onFaqClick: () => _scrollToSection(_faqKey),
            ),
          ),
          
          // Scroll to Top Button
          if (_showScrollToTop)
            Positioned(
              right: 20,
              bottom: 90,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF8B5CF6),
                heroTag: 'scroll_to_top',
                child: const Icon(Icons.arrow_upward),
              ),
            ),
          
          // Floating Offer Button (Bottom Left)
          FloatingOfferButton(
            timeRemaining: _timeRemaining,
            onTap: _handleBuyNow,
          ),
          
          // Floating Action Buttons
          FloatingActionButtons(
            onBuyNow: _handleBuyNow,
            onChat: _handleChatbot,
          ),
          
          // AI Chatbot Overlay
            if (_showChatbot)
            Positioned(
              right: 20,
              bottom: 200,
              child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MediaQuery.of(context).size.width > 600 ? 350 : MediaQuery.of(context).size.width - 40,
                height: 500,
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                children: [
                  Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                    ),
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'AI Shopping Assistant',
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        ),
                      ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => setState(() => _showChatbot = false),
                    ),
                    ],
                  ),
                  ),
                  Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _chatMessages.length,
                    itemBuilder: (context, index) {
                    final message = _chatMessages[index];
                    final isBot = message['isBot'] as bool;
                    return Align(
                      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                      child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: isBot ? Colors.grey[100] : const Color(0xFF8B5CF6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message['text'] as String,
                        style: TextStyle(
                        fontSize: 14,
                        color: isBot ? Colors.black87 : Colors.white,
                        height: 1.4,
                        ),
                      ),
                      ),
                    );
                    },
                  ),
                  ),
                  Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border(top: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    if (_showQuickReplies) ...[
                      const Text(
                      'Quick Questions:',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: _quickQuestions.map((question) {
                        return InkWell(
                        onTap: () => _handleQuickQuestion(question),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF8B5CF6)),
                          ),
                          child: Text(
                          question,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8B5CF6),
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                        ),
                        );
                      }).toList(),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      children: [
                      Expanded(
                        child: TextField(
                        controller: _chatController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFF8B5CF6)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        ),
                        shape: BoxShape.circle,
                        ),
                        child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 20),
                        onPressed: _sendMessage,
                        ),
                      ),
                      ],
                    ),
                    ],
                  ),
                  ),
                ],
                ),
              ),
              ),
            ),],
      ),
    );
  }

  void _sendMessage() {
    final text = _chatController.text.trim();
    if (text.isEmpty) return;
    
    setState(() {
      // Add user message
      _chatMessages.add({
        'text': text,
        'isBot': false,
      });
      
      // Hide quick replies after first message
      _showQuickReplies = false;
      
      // Simulate bot response
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _chatMessages.add({
              'text': _getBotResponse(text),
              'isBot': true,
            });
          });
        }
      });
    });
    
    _chatController.clear();
  }

  void _handleQuickQuestion(String question) {
    setState(() {
      // Add user question
      _chatMessages.add({
        'text': question,
        'isBot': false,
      });
      
      // Hide quick replies
      _showQuickReplies = false;
      
      // Add bot response based on question
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            String response;
            if (question.contains('price')) {
              response = '💰 Our current price is ${widget.product.price}. Plus, you get 50% OFF for a limited time!';
              // Scroll to pricing
              _scrollToSection(_pricingKey);
            } else if (question.contains('Shipping')) {
              response = '🚚 We offer FREE express shipping on all orders! Delivery typically takes 3-5 business days.';
            } else if (question.contains('reviews')) {
              response = '⭐ We have a 4.9/5 rating from over 50,000+ happy customers! Let me show you some reviews.';
              // Scroll to testimonials
              _scrollToSection(_testimonialsKey);
            } else if (question.contains('FAQ')) {
              response = '❓ I can help with common questions. Let me take you to our FAQ section.';
              // Scroll to FAQ
              _scrollToSection(_faqKey);
            } else {
              response = 'Thanks for your question! How else can I assist you today?';
            }
            
            _chatMessages.add({
              'text': response,
              'isBot': true,
            });
          });
        }
      });
    });
  }

  String _getBotResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('price') || message.contains('cost') || message.contains('how much')) {
      return '💰 Our current price is ${widget.product.price}. Plus, you get 50% OFF for a limited time! Would you like to see more details?';
    } else if (message.contains('shipping') || message.contains('delivery')) {
      return '🚚 We offer FREE express shipping on all orders! Delivery typically takes 3-5 business days. Orders are processed within 24 hours.';
    } else if (message.contains('review') || message.contains('rating')) {
      return '⭐ We have a 4.9/5 rating from over 50,000+ happy customers! You can read their reviews in the testimonials section.';
    } else if (message.contains('guarantee') || message.contains('return')) {
      return '✅ We offer a 30-day money-back guarantee! If you\'re not satisfied, we\'ll refund you, no questions asked.';
    } else if (message.contains('buy') || message.contains('purchase') || message.contains('order')) {
      return '🛒 Great! Click the "Buy Now" button to proceed to checkout. You\'ll get 50% OFF today!';
    } else if (message.contains('feature') || message.contains('what does')) {
      return '✨ Our product has amazing features! Check out the Features section above to learn more about what makes it special.';
    } else {
      return 'Thanks for your message! I\'m here to help. You can ask me about pricing, shipping, reviews, or anything else! 😊';
    }
  }

  Widget _buildQuickAction(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
