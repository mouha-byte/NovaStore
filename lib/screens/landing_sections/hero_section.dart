import 'package:flutter/material.dart';
import '../../models/product_model.dart';

class HeroSection extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onBuyNow;

  const HeroSection({
    super.key,
    required this.product,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    
    return Container(
      height: isMobile ? 900 : (isTablet ? 800 : 750),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1),
            Color(0xFF8B5CF6),
            Color(0xFFEC4899),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated Background Pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _BackgroundPatternPainter(),
            ),
          ),
          
          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : (isTablet ? 30 : 40), 
                vertical: isMobile ? 40 : (isTablet ? 60 : 80)
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  
                  return isWide
                      ? Row(
                          children: [
                            Expanded(child: _buildHeroText(context)),
                            const SizedBox(width: 60),
                            Expanded(child: _buildHeroImage(context)),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildHeroText(context),
                            SizedBox(height: isMobile ? 30 : 40),
                            _buildHeroImage(context),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16, 
            vertical: isMobile ? 6 : 8
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: isMobile ? 14 : 16),
              SizedBox(width: isMobile ? 4 : 6),
              Text(
                '🔥 #1 Best Seller This Month',
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.w600, 
                  fontSize: isMobile ? 11 : 13
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: isMobile ? 20 : 30),
        
        // Main Headline
        Text(
          product.title,
          style: TextStyle(
            fontSize: isMobile ? 32 : (isTablet ? 44 : 58),
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.1,
            letterSpacing: isMobile ? -1 : -2,
          ),
        ),
        
        SizedBox(height: isMobile ? 16 : 20),
        
        // Subheadline
        Text(
          'Transform Your Life with Premium Quality That Actually Delivers Results',
          style: TextStyle(
            fontSize: isMobile ? 16 : (isTablet ? 18 : 22),
            color: Colors.white.withOpacity(0.95),
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        
        SizedBox(height: isMobile ? 24 : 40),
        
        // Trust Indicators
        Wrap(
          spacing: isMobile ? 12 : 24,
          runSpacing: isMobile ? 8 : 12,
          children: [
            _buildMiniTrustBadge(Icons.verified_user, '30-Day Guarantee', isMobile),
            _buildMiniTrustBadge(Icons.local_shipping, 'Free Shipping', isMobile),
            _buildMiniTrustBadge(Icons.star, '4.9/5 (1,200+ Reviews)', isMobile),
          ],
        ),
        
        SizedBox(height: isMobile ? 32 : 50),
        
        // CTA Buttons
        isMobile 
          ? Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Get Started Now',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onBuyNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6366F1),
                  padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get Started Now',
                      style: TextStyle(fontSize: isTablet ? 16 : 18, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: isTablet ? 8 : 10),
                    Icon(Icons.arrow_forward, size: isTablet ? 18 : 20),
                  ],
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Secondary Info
        Text(
          '✓ No credit card required  ✓ Cancel anytime',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniTrustBadge(IconData icon, String text, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: isMobile ? 16 : 18),
        SizedBox(width: isMobile ? 4 : 6),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 12 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;
    
    // Calculate responsive sizes
    final maxHeight = isMobile ? 300.0 : (isTablet ? 400.0 : 550.0);
    final maxWidth = isMobile ? 300.0 : (isTablet ? 400.0 : 550.0);
    final borderRadius = isMobile ? 20.0 : (isTablet ? 25.0 : 30.0);
    
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
      child: Stack(
        children: [
          // Glow Effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(isMobile ? 0.2 : 0.3),
                    blurRadius: isMobile ? 40 : (isTablet ? 60 : 80),
                    spreadRadius: isMobile ? 25 : (isTablet ? 35 : 50),
                  ),
                ],
              ),
            ),
          ),
          
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.network(
              product.images.isNotEmpty 
                  ? product.images.first 
                  : 'https://via.placeholder.com/600',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image, 
                      size: isMobile ? 60 : (isTablet ? 80 : 100), 
                      color: Colors.white
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Floating Stats
          if (!isMobile)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(isTablet ? 12 : 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Text(
                    '4.9',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
                      Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
                      Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
                      Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
                      Icon(Icons.star, color: Color(0xFFFBBF24), size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Background Pattern Painter
class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < 10; i++) {
      canvas.drawCircle(
        Offset(size.width * 0.2, size.height * (i / 10)),
        50 + (i * 20),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
