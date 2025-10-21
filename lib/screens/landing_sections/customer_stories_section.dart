import 'package:flutter/material.dart';

class CustomerStoriesSection extends StatelessWidget {
  const CustomerStoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF06B6D4).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_stories, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'SUCCESS STORIES',
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
                'Real Stories, Real Results',
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
                'See how our product has changed lives for the better.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Stories
              Column(
                children: [
                  _buildStoryCard(
                    'From Struggling to Thriving',
                    'Rachel\'s Journey',
                    '"I was at my lowest point when I found this product. Within 30 days, everything changed. '
                    'I went from barely getting by to feeling confident and capable. This isn\'t just a product—it\'s '
                    'a life-changer. I\'m now recommending it to everyone I know because I genuinely want others to '
                    'experience the same transformation I did."',
                    'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=800&h=500&fit=crop',
                    const Color(0xFF3B82F6),
                    true,
                  ),
                  const SizedBox(height: 40),
                  _buildStoryCard(
                    'The Professional Breakthrough',
                    'Marcus\'s Success',
                    '"As a busy professional, I needed something that actually worked without taking up all my time. '
                    'This product delivered exactly that. My productivity has skyrocketed, and I finally have time for '
                    'what matters. My colleagues keep asking what changed—and I tell them about this product every single time."',
                    'https://images.unsplash.com/photo-1556761175-b413da4baf72?w=800&h=500&fit=crop',
                    const Color(0xFF10B981),
                    false,
                  ),
                  const SizedBox(height: 40),
                  _buildStoryCard(
                    'A Family\'s Transformation',
                    'The Anderson Family',
                    '"We were skeptical about trying yet another product, but this one proved us wrong. It\'s now an '
                    'essential part of our daily routine. Our kids love it, we love it, and even our grandparents are using it. '
                    'It brought our family together and made our lives so much easier. We can\'t imagine life without it now."',
                    'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=800&h=500&fit=crop',
                    const Color(0xFF8B5CF6),
                    true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryCard(
    String title,
    String subtitle,
    String story,
    String imageUrl,
    Color accentColor,
    bool imageOnLeft,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accentColor.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          
          if (isWide) {
            final imageWidget = Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: imageOnLeft 
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                child: Image.network(
                  imageUrl,
                  height: 350,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 350,
                      color: Colors.grey[300],
                    );
                  },
                ),
              ),
            );
            
            final contentWidget = Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      story,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            );
            
            return Row(
              children: imageOnLeft 
                  ? [imageWidget, contentWidget]
                  : [contentWidget, imageWidget],
            );
          } else {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[300],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        story,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
