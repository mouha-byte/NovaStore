import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import 'landing_constants.dart';
import 'dart:async';

class HeroSection extends StatefulWidget {
  final ProductModel product;
  final VoidCallback onBuyNow;

  const HeroSection({super.key, required this.product, required this.onBuyNow});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < LandingConstants.heroCarouselImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < LandingConstants.mobileBreakpoint;
    final isTablet = screenWidth >= LandingConstants.mobileBreakpoint && 
                     screenWidth < LandingConstants.tabletBreakpoint;
    
    return Container(
      height: isMobile ? 900 : (isTablet ? 800 : 750),
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : (isTablet ? 30 : 40),
            vertical: isMobile ? 40 : (isTablet ? 60 : 80),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => 
                constraints.maxWidth > LandingConstants.tabletBreakpoint
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
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < LandingConstants.mobileBreakpoint;
    final isTablet = screenWidth >= LandingConstants.mobileBreakpoint && 
                     screenWidth < LandingConstants.tabletBreakpoint;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: isMobile ? 6 : 8,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              LandingConstants.primaryColor,
              LandingConstants.secondaryColor,
            ]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up, 
                   color: Colors.white, 
                   size: isMobile ? 14 : 16),
              SizedBox(width: isMobile ? 4 : 6),
              Text(
                LandingConstants.heroTrendingBadge,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 11 : 13,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 20 : 30),
        Text(
          widget.product.title,
          style: TextStyle(
            fontSize: isMobile ? 32 : (isTablet ? 44 : 58),
            fontWeight: FontWeight.w900,
            color: LandingConstants.darkGray,
            height: 1.1,
            letterSpacing: isMobile ? -1 : -2,
          ),
        ),
        SizedBox(height: isMobile ? 16 : 20),
        Text(
          LandingConstants.heroSubtitle,
          style: TextStyle(
            fontSize: isMobile ? 16 : (isTablet ? 18 : 22),
            color: LandingConstants.mediumGray,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: isMobile ? 24 : 40),
        Wrap(
          spacing: isMobile ? 12 : 24,
          runSpacing: isMobile ? 8 : 12,
          children: LandingConstants.heroBadges
              .map((badge) => _buildBadge(badge.icon, badge.text, isMobile))
              .toList(),
        ),
        SizedBox(height: isMobile ? 32 : 50),
        SizedBox(
          width: isMobile ? double.infinity : null,
          child: ElevatedButton(
            onPressed: widget.onBuyNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: LandingConstants.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 16 : (isTablet ? 16 : 20),
                horizontal: isMobile ? 0 : 40,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
            ),
            child: Row(
              mainAxisSize: isMobile ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LandingConstants.heroCTA,
                  style: TextStyle(
                    fontSize: isTablet ? 16 : 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: isTablet ? 8 : 10),
                Icon(Icons.arrow_forward, size: isTablet ? 18 : 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          LandingConstants.heroFinePrint,
          style: TextStyle(
            color: LandingConstants.mediumGray,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String text, bool isMobile) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: LandingConstants.primaryColor, 
           size: isMobile ? 16 : 18),
      SizedBox(width: isMobile ? 4 : 6),
      Text(
        text,
        style: TextStyle(
          color: LandingConstants.lightGray,
          fontSize: isMobile ? 12 : 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );

  Widget _buildHeroImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < LandingConstants.mobileBreakpoint;
    final isTablet = screenWidth >= LandingConstants.mobileBreakpoint && 
                     screenWidth < LandingConstants.tabletBreakpoint;
    final size = isMobile ? 300.0 : (isTablet ? 400.0 : 550.0);
    final radius = isMobile ? 20.0 : (isTablet ? 25.0 : 30.0);
    
    return Container(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: Stack(
        children: [
          // Gradient background
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    LandingConstants.primaryColor.withOpacity(0.15),
                    LandingConstants.secondaryColor.withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Carousel with 5 images
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: LandingConstants.primaryColor.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: LandingConstants.heroCarouselImages.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    LandingConstants.heroCarouselImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFFF3F4F6),
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image,
                          size: isMobile ? 60 : (isTablet ? 80 : 100),
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Page indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                LandingConstants.heroCarouselImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? LandingConstants.primaryColor
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          // Rating badge
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
                child: Column(
                  children: [
                    Text(
                      '4.9',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: LandingConstants.primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        5,
                        (_) => Icon(
                          Icons.star,
                          color: LandingConstants.yellow,
                          size: 16,
                        ),
                      ),
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

