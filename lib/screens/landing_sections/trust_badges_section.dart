import 'package:flutter/material.dart';

class TrustBadgesSection extends StatelessWidget {
  const TrustBadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                'Shop with Confidence',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              
              const SizedBox(height: 20),
              
              Text(
                'Your satisfaction and security are our top priorities.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ),
              
              const SizedBox(height: 60),
              
              // Trust Badges Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 900 
                      ? 4 
                      : constraints.maxWidth > 600 
                          ? 2 
                          : 1;
                  
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.0,
                    children: [
                      _buildTrustBadge(
                        Icons.lock,
                        'Secure Checkout',
                        '256-bit SSL encryption protects your data',
                        const Color(0xFF10B981),
                      ),
                      _buildTrustBadge(
                        Icons.local_shipping,
                        'Free Shipping',
                        'Fast delivery to your doorstep',
                        const Color(0xFF3B82F6),
                      ),
                      _buildTrustBadge(
                        Icons.currency_exchange,
                        '30-Day Returns',
                        'Full refund if not satisfied',
                        const Color(0xFFF59E0B),
                      ),
                      _buildTrustBadge(
                        Icons.support_agent,
                        '24/7 Support',
                        'Always here to help you',
                        const Color(0xFF8B5CF6),
                      ),
                      _buildTrustBadge(
                        Icons.verified_user,
                        'Authentic Products',
                        '100% genuine guarantee',
                        const Color(0xFFEF4444),
                      ),
                      _buildTrustBadge(
                        Icons.shield,
                        'Warranty Included',
                        '2-year manufacturer warranty',
                        const Color(0xFF06B6D4),
                      ),
                      _buildTrustBadge(
                        Icons.credit_card,
                        'Multiple Payments',
                        'All major cards accepted',
                        const Color(0xFFEC4899),
                      ),
                      _buildTrustBadge(
                        Icons.eco,
                        'Eco-Friendly',
                        'Sustainable materials & packaging',
                        const Color(0xFF22C55E),
                      ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 60),
              
              // Bottom stats
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.3),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 700;
                    return Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: isWide ? 60 : 30,
                      runSpacing: 30,
                      children: [
                        _buildStatItem('50,000+', 'Happy Customers'),
                        _buildStatItem('4.9/5', 'Average Rating'),
                        _buildStatItem('98%', 'Satisfaction Rate'),
                        _buildStatItem('< 24h', 'Response Time'),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustBadge(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
