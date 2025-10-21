import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  final VoidCallback onBuyNow;

  const PricingSection({
    super.key,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 && MediaQuery.of(context).size.width < 900;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 120, 
        horizontal: isMobile ? 20 : 40
      ),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24, 
                  vertical: isMobile ? 8 : 12
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_offer, color: Colors.white, size: isMobile ? 16 : 20),
                    SizedBox(width: isMobile ? 6 : 10),
                    Text(
                      'PRICING',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: isMobile ? 24 : 40),
              
              Text(
                'Choose Your Package',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 28 : (isTablet ? 36 : 46),
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
              
              SizedBox(height: isMobile ? 16 : 30),
              
              Text(
                'All packages come with our 30-day money-back guarantee.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 14 : (isTablet ? 16 : 20),
                  color: Colors.grey[600],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              SizedBox(height: isMobile ? 40 : 80),
              
              // Pricing Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 900 
                      ? 3 
                      : 1;
                  
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: crossAxisCount == 1 ? 1.2 : 0.75,
                    children: [
                      _buildPricingCard(
                        'Starter',
                        '\$99',
                        '\$199',
                        'Perfect for trying it out',
                        [
                          '1 Product',
                          '30-Day Guarantee',
                          'Basic Accessories',
                        ],
                        const Color(0xFF3B82F6),
                        false,
                      ),
                      _buildPricingCard(
                        'Pro',
                        '\$149',
                        '\$299',
                        'Most Popular Choice',
                        [
                          '2 Products',
                          // 'FREE Express Shipping',
              
                          'Premium Accessories',
                          // 'Bonus Package (\$79 value)',
                        ],
                        const Color(0xFF10B981),
                        true,
                      ),
                      _buildPricingCard(
                        'Ultimate',
                        '\$249',
                        '\$499',
                        'Best Value & Savings',
                        [
                          '4 Products',
                          // 'FREE Express Shipping',
                          // 'VIP Support 24/7',
                          '60-Day Guarantee',
                          'Deluxe Accessories',
                          // 'Exclusive Bonus (\$149 value)',
                          // 'Lifetime Updates',
                        ],
                        const Color(0xFF8B5CF6),
                        false,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard(
    String title,
    String price,
    String originalPrice,
    String subtitle,
    List<String> features,
    Color color,
    bool isPopular,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 500;
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(isMobile ? 20 : 24),
            border: Border.all(
              color: isPopular ? color : color.withOpacity(0.2),
              width: isPopular ? 4 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(isPopular ? 0.3 : 0.15),
                blurRadius: isPopular ? 40 : 30,
                offset: Offset(0, isPopular ? 15 : 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 12 : 15, 
                  horizontal: isMobile ? 16 : 24
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMobile ? 18 : 22),
                    topRight: Radius.circular(isMobile ? 18 : 22),
                  ),
                ),
                child: Column(
                  children: [
                    if (isPopular)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 16, 
                          vertical: isMobile ? 4 : 6
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBBF24),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '⭐ MOST POPULAR',
                          style: TextStyle(
                            fontSize: isMobile ? 10 : 12,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    if (isPopular) SizedBox(height: isMobile ? 4 : 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: isMobile ? 2 : 8),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Price
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 20 : 30, 
                  horizontal: isMobile ? 16 : 24
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$',
                          style: TextStyle(
                            fontSize: isMobile ? 20 : 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          price.replaceAll('\$', ''),
                          style: TextStyle(
                            fontSize: isMobile ? 48 : 56,
                            fontWeight: FontWeight.w900,
                            color: color,
                            height: 0.9,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[400],
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2,
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16, 
                        vertical: isMobile ? 4 : 6
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Save ${((1 - double.parse(price.replaceAll('\$', '')) / double.parse(originalPrice.replaceAll('\$', ''))) * 100).round()}%',
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Features
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
                  child: Column(
                    children: features.map((feature) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle, color: color, size: isMobile ? 18 : 20),
                            SizedBox(width: isMobile ? 8 : 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: isMobile ? 13 : 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              
              // Button
              Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: isMobile ? 14 : 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
                      ),
                      elevation: 0,
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Get $title',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
