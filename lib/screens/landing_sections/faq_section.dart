import 'package:flutter/material.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How long does shipping take?',
      'answer': 'We offer FREE express shipping on all orders. Most orders arrive within 2-3 business days. You\'ll receive a tracking number as soon as your order ships.',
    },
    {
      'question': 'What is your return policy?',
      'answer': 'We offer a 30-day money-back guarantee. If you\'re not completely satisfied, return it for a full refund, no questions asked. We\'ll even cover the return shipping.',
    },
    {
      'question': 'Is this product safe to use?',
      'answer': 'Absolutely! Our product has been rigorously tested and certified by multiple safety organizations. It meets all international safety standards and is approved by leading experts.',
    },
    {
      'question': 'How do I know this will work for me?',
      'answer': 'Over 50,000 customers have already experienced amazing results. Plus, with our 30-day money-back guarantee, you can try it risk-free. If it doesn\'t work for you, you get your money back.',
    },
    {
      'question': 'What makes this different from competitors?',
      'answer': 'We use premium materials, offer longer warranties, provide 24/7 customer support, and back everything with our satisfaction guarantee. Our customers rate us 4.9/5 stars consistently.',
    },
    {
      'question': 'Do you offer bulk or wholesale pricing?',
      'answer': 'Yes! Contact our sales team for bulk orders of 10+ units. We offer special pricing for businesses, resellers, and large organizations.',
    },
    {
      'question': 'How secure is the checkout process?',
      'answer': 'Your security is our priority. We use 256-bit SSL encryption (the same level banks use). We never store your payment information and all transactions are processed securely.',
    },
    {
      'question': 'Can I track my order?',
      'answer': 'Yes! Once your order ships, you\'ll receive a tracking number via email. You can track your package in real-time until it arrives at your doorstep.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFAF5FF),
            Colors.white,
            Color(0xFFF3E8FF),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.help_outline, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'FAQ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              const Text(
                'Frequently Asked Questions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
              
              const SizedBox(height: 30),
              
              Text(
                'Got questions? We\'ve got answers.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // FAQ Items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _faqs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildFAQItem(
                      _faqs[index]['question']!,
                      _faqs[index]['answer']!,
                      index,
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 60),
              
              // Contact CTA
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.support_agent,
                      color: Colors.white,
                      size: 48,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Still Have Questions?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Our support team is available 24/7 to help you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF8B5CF6),
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chat_bubble_outline, size: 20),
                          SizedBox(width: 10),
                          Text(
                            'Contact Support',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, int index) {
    final isExpanded = _expandedIndex == index;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpanded 
              ? const Color(0xFF8B5CF6) 
              : Colors.grey[300]!,
          width: isExpanded ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isExpanded 
                ? const Color(0xFF8B5CF6).withOpacity(0.15) 
                : Colors.black.withOpacity(0.05),
            blurRadius: isExpanded ? 20 : 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: Key(index.toString()),
          initiallyExpanded: isExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _expandedIndex = expanded ? index : null;
            });
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isExpanded 
                  ? const Color(0xFF8B5CF6).withOpacity(0.1) 
                  : Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isExpanded ? Icons.remove : Icons.add,
              color: isExpanded ? const Color(0xFF8B5CF6) : Colors.grey[600],
              size: 20,
            ),
          ),
          title: Text(
            question,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: isExpanded ? const Color(0xFF8B5CF6) : Colors.black87,
            ),
          ),
          children: [
            Text(
              answer,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
