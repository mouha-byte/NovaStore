import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../services/auth_service.dart';
import '../widgets/ai_chatbot_widget.dart';
import 'dart:math' as math;

/// Single Product Landing Page - Conversion Optimized
/// Designed to sell ONE product efficiently with modern, clean design
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
  final _brandScrollController = ScrollController();
  bool _isScrolled = false;
  
  // Countdown timer state
  late DateTime _offerEndTime;
  Duration _timeRemaining = const Duration();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    
    // Set offer end time to 24 hours from now
    _offerEndTime = DateTime.now().add(const Duration(hours: 24));
    _updateCountdown();
    
    // Update countdown every second
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        _updateCountdown();
        return true;
      }
      return false;
    });
    
    // Auto-scroll brands carousel
    _startBrandScroll();
  }
  
  void _startBrandScroll() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted || !_brandScrollController.hasClients) return;
      
      // Smooth auto-scroll
      Future.doWhile(() async {
        if (!mounted || !_brandScrollController.hasClients) return false;
        
        await _brandScrollController.animateTo(
          _brandScrollController.offset + 1,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
        
        // Reset to beginning for infinite loop
        if (_brandScrollController.offset >= _brandScrollController.position.maxScrollExtent - 100) {
          _brandScrollController.jumpTo(0);
        }
        
        await Future.delayed(const Duration(milliseconds: 30));
        return mounted;
      });
    });
  }
  
  void _updateCountdown() {
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
    _brandScrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 40), // Space for top banner (reduced from 60 to 40)
                _buildHeroSection(context),
                _buildProblemSection(context),
                _buildSolutionSection(context),
                _buildFeaturesSection(context),
                _buildVideoGallerySection(context), // NEW: Video demos
                _buildHowItWorksSection(context),
                _buildSponsoredBrandsBanner(context), // NEW: Sponsored brands banner
                _buildExpertEndorsementSection(context), // NEW: Expert endorsements with videos
                _buildLifestyleGallerySection(context), // NEW: Product in use
                _buildTestimonialsSection(context),
                _buildCustomerStoriesSection(context), // Real customer photos & videos
                _buildManufacturingGallerySection(context), // NEW: Behind the scenes
                _buildTrustBadgesSection(context),
                _buildComparisonSection(context), // NEW: Product comparison
                _buildBeforeAfterSection(context), // NEW: Before/After transformations
                _buildLimitedOfferSection(context), // NEW: Limited time offer with urgency
                _buildPricingSection(context),
                _buildFAQSection(context),
                _buildFinalCTASection(context),
                _buildFooter(context),
              ],
            ),
          ),
          
          // Top Navigation Banner - Always visible
          _buildTopNavigationBanner(context),
          
          // Sticky Navigation
          _buildStickyNav(context),
          
          // Floating Buy Button (LEFT SIDE)
          if (_isScrolled) _buildFloatingBuyButton(context),
          
          // AI Chatbot
          const AIChatbotWidget(),
          
          // Back to Top Button (more spacing)
          if (_isScrolled) _buildBackToTopButton(context),
        ],
      ),
    );
  }

  // ==================== STICKY NAVIGATION ====================
  Widget _buildStickyNav(BuildContext context) {
    return Positioned(
      top: 40, // Below the top banner (reduced from 60 to 40)
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: _isScrolled ? 12 : 20,
        ),
        decoration: BoxDecoration(
          color: _isScrolled ? Colors.white : Colors.transparent,
          boxShadow: _isScrolled
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo/Brand
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.shopping_bag, color: Colors.white, size: 24),
                  ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 2000.ms, delay: 1000.ms),
                  const SizedBox(width: 12),
                  Text(
                    'NovaStore',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: _isScrolled ? Colors.black : Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ).animate().fadeIn(duration: 600.ms),
                ],
              ),
              
              // Navigation Links
              Row(
                children: [
                  _buildNavLink('Features', () => _scrollToSection(4), context)
                    .animate().fadeIn(delay: 100.ms).slideY(begin: -0.5, end: 0),
                  const SizedBox(width: 12),
                  _buildNavLink('Videos', () => _scrollToSection(5), context)
                    .animate().fadeIn(delay: 200.ms).slideY(begin: -0.5, end: 0),
                  const SizedBox(width: 12),
                  _buildNavLink('Reviews', () => _scrollToSection(9), context)
                    .animate().fadeIn(delay: 300.ms).slideY(begin: -0.5, end: 0),
                  const SizedBox(width: 12),
                  _buildNavLink('Stories', () => _scrollToSection(10), context)
                    .animate().fadeIn(delay: 400.ms).slideY(begin: -0.5, end: 0),
                  const SizedBox(width: 12),
                  _buildNavLink('Pricing', () => _scrollToSection(14), context)
                    .animate().fadeIn(delay: 500.ms).slideY(begin: -0.5, end: 0),
                  const SizedBox(width: 12),
                  _buildNavLink('FAQ', () => _scrollToSection(15), context)
                    .animate().fadeIn(delay: 600.ms).slideY(begin: -0.5, end: 0),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _handleBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC4899),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Buy Now', style: TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        const Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ).animate().fadeIn(delay: 700.ms).scale(delay: 700.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap, BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: _isScrolled ? Colors.black87 : Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  void _scrollToSection(int section) {
    final positions = [
      60.0,     // 0: Top
      900.0,    // 1: Hero
      1600.0,   // 2: Problem
      2300.0,   // 3: Solution
      3000.0,   // 4: Features
      3800.0,   // 5: Videos
      4500.0,   // 6: How It Works
      5200.0,   // 7: Brands
      5900.0,   // 8: Lifestyle
      6600.0,   // 9: Testimonials
      7300.0,   // 10: Customer Stories
      8000.0,   // 11: Manufacturing
      8700.0,   // 12: Trust Badges
      9400.0,   // 13: Comparison
      10100.0,  // 14: Pricing
      10800.0,  // 15: FAQ
    ];
    if (section < positions.length) {
      _scrollController.animateTo(
        positions[section],
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  // ==================== TOP NAVIGATION BANNER ====================
  Widget _buildTopNavigationBanner(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _buildAutoScrollBanner(),
      ),
    );
  }

  Widget _buildAutoScrollBanner() {
    final items = [
      {'icon': '⭐', 'text': '4.8/5 rating and 20,000 happy customers'},
      {'icon': '�', 'text': 'Afterpay Available'},
      {'icon': '�', 'text': 'Free Shipping Over \$100'},
      {'icon': '✅', 'text': '30-Day Money Back Guarantee'},
      {'icon': '🏆', 'text': 'Award-Winning Quality'},
      {'icon': '💎', 'text': 'Premium Materials'},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 1000, // Infinite scroll effect
      itemBuilder: (context, index) {
        return Row(
          children: items.map((item) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Text(
                        item['icon']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['text']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: Colors.white24,
                ),
              ],
            );
          }).toList(),
        );
      },
    ).animate(onPlay: (controller) => controller.repeat())
      .custom(
        duration: 30000.ms,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(-value * 2000, 0),
            child: child,
          );
        },
      );
  }

  // ==================== SPONSORED BRANDS BANNER ====================
  Widget _buildSponsoredBrandsBanner(BuildContext context) {
    final brands = [
      {'name': 'Apple', 'logo': 'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=100&h=100&fit=crop'},
      {'name': 'Microsoft', 'logo': 'https://images.unsplash.com/photo-1633419461186-7d40a38105ec?w=100&h=100&fit=crop'},
      {'name': 'Google', 'logo': 'https://images.unsplash.com/photo-1573804633927-bfcbcd909acd?w=100&h=100&fit=crop'},
      {'name': 'Amazon', 'logo': 'https://images.unsplash.com/photo-1523474253046-8cd2748b5fd2?w=100&h=100&fit=crop'},
      {'name': 'Samsung', 'logo': 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=100&h=100&fit=crop'},
      {'name': 'Tesla', 'logo': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=100&h=100&fit=crop'},
      {'name': 'Nike', 'logo': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=100&h=100&fit=crop'},
      {'name': 'Adidas', 'logo': 'https://images.unsplash.com/photo-1556906781-9a412961c28c?w=100&h=100&fit=crop'},
      {'name': 'Sony', 'logo': 'https://images.unsplash.com/photo-1585829365295-ab7cd400c167?w=100&h=100&fit=crop'},
      {'name': 'Intel', 'logo': 'https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?w=100&h=100&fit=crop'},
      {'name': 'IBM', 'logo': 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=100&h=100&fit=crop'},
      {'name': 'Dell', 'logo': 'https://images.unsplash.com/photo-1593640408182-31c70c8268f5?w=100&h=100&fit=crop'},
      {'name': 'HP', 'logo': 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=100&h=100&fit=crop'},
      {'name': 'Oracle', 'logo': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=100&h=100&fit=crop'},
      {'name': 'Cisco', 'logo': 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=100&h=100&fit=crop'},
      {'name': 'Adobe', 'logo': 'https://images.unsplash.com/photo-1572044162444-ad60f128bdea?w=100&h=100&fit=crop'},
    ];
    
    // Duplicate brands list for seamless infinite scroll
    final repeatedBrands = [...brands, ...brands, ...brands];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withOpacity(0.1),
                  const Color(0xFFEC4899).withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xFF6366F1).withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified, color: Colors.white, size: 16),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                  .scale(duration: 1500.ms),
                const SizedBox(width: 12),
                const Text(
                  'TRUSTED BY LEADING BRANDS',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6366F1),
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.5, end: 0),
          
          const SizedBox(height: 30),
          
          const Text(
            'Join the World\'s Most Innovative Companies',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              height: 1.2,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 16),
          
          Text(
            'Used and trusted by industry leaders worldwide',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 600.ms),
          
          const SizedBox(height: 50),
          
          // Auto-scrolling brands carousel
          SizedBox(
            height: 140,
            child: ListView.builder(
              controller: _brandScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: repeatedBrands.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final brand = repeatedBrands[index];
                return Container(
                  width: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF6366F1).withOpacity(0.2),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF6366F1).withOpacity(0.1),
                              const Color(0xFFEC4899).withOpacity(0.1),
                            ],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            brand['logo']!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  brand['name']![0],
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        brand['name']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Color(0xFFFBBF24),
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 50),
          
          // Footer with stats
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withOpacity(0.05),
                  const Color(0xFFEC4899).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBrandStat('50K+', 'Global Partners', Icons.business),
                Container(
                  width: 3,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF6366F1).withOpacity(0.3),
                        const Color(0xFFEC4899).withOpacity(0.3),
                        const Color(0xFF6366F1).withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                _buildBrandStat('100+', 'Countries', Icons.public),
                Container(
                  width: 3,
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF6366F1).withOpacity(0.3),
                        const Color(0xFFEC4899).withOpacity(0.3),
                        const Color(0xFF6366F1).withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                _buildBrandStat('99.9%', 'Satisfaction', Icons.sentiment_very_satisfied),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms).scale(delay: 800.ms),
        ],
      ),
    );
  }
  
  Widget _buildBrandStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ).animate(onPlay: (controller) => controller.repeat(reverse: true))
          .scale(duration: 2000.ms, begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
        const SizedBox(height: 12),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
          ).createShader(bounds),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
            .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.5)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.grey[700],
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  // ==================== EXPERT ENDORSEMENT SECTION ====================
  Widget _buildExpertEndorsementSection(BuildContext context) {
    final experts = [
      {
        'name': 'Dr. Sarah Johnson',
        'title': 'Product Innovation Expert',
        'company': 'Tech Institute',
        'image': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=300&h=300&fit=crop',
        'videoThumbnail': 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&h=400&fit=crop',
        'quote': 'This product represents the future of innovation. After 15 years in the industry, I can confidently say it\'s revolutionary.',
        'rating': 5,
      },
      {
        'name': 'Michael Chen',
        'title': 'Industry Analyst',
        'company': 'Global Research Firm',
        'image': 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop',
        'videoThumbnail': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&h=400&fit=crop',
        'quote': 'Unmatched quality and performance. We\'ve analyzed hundreds of products, and this stands out as the best.',
        'rating': 5,
      },
      {
        'name': 'Emma Rodriguez',
        'title': 'Quality Assurance Director',
        'company': 'Premium Standards Lab',
        'image': 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=300&h=300&fit=crop',
        'videoThumbnail': 'https://images.unsplash.com/photo-1504805572947-34fad45aed93?w=600&h=400&fit=crop',
        'quote': 'Exceeded every quality benchmark we have. It\'s rare to find products that meet such high standards.',
        'rating': 5,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF8FAFC),
            Colors.white,
            const Color(0xFFF1F5F9),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF8B5CF6).withOpacity(0.15),
                      const Color(0xFFEC4899).withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6).withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.workspace_premium, color: Colors.white, size: 18),
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .scale(duration: 1500.ms, begin: const Offset(1, 1), end: const Offset(1.15, 1.15)),
                    const SizedBox(width: 14),
                    const Text(
                      'TRUSTED BY EXPERTS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF8B5CF6),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).scale(),
              
              const SizedBox(height: 30),
              
              const Text(
                'What Industry Leaders Say',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1.5,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
              
              Text(
                'Don\'t just take our word for it—hear from the experts who\'ve tested and approved',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 70),
              
              // Experts Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isWide ? 3 : (constraints.maxWidth > 600 ? 2 : 1),
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.85,
                    children: List.generate(experts.length, (index) {
                      final expert = experts[index];
                      return _buildExpertCard(
                        expert['name'] as String,
                        expert['title'] as String,
                        expert['company'] as String,
                        expert['image'] as String,
                        expert['videoThumbnail'] as String,
                        expert['quote'] as String,
                        expert['rating'] as int,
                        index * 200,
                      );
                    }),
                  );
                },
              ),
              
              const SizedBox(height: 60),
              
              // CTA to watch all videos
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.play_circle_outline,
                      size: 64,
                      color: Colors.white,
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .scale(duration: 1500.ms, begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
                    const SizedBox(height: 20),
                    const Text(
                      'Watch All Expert Testimonials',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'See why industry leaders trust and recommend our product',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Open video gallery modal
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF8B5CF6),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View All Videos',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 800.ms).scale(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildExpertCard(String name, String title, String company, String imageUrl, String videoThumbnail, String quote, int rating, int delay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF8B5CF6).withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 12),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video thumbnail with play button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                child: Image.network(
                  videoThumbnail,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF8B5CF6).withOpacity(0.3),
                            const Color(0xFFEC4899).withOpacity(0.3),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      size: 36,
                      color: Color(0xFF8B5CF6),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(duration: 1500.ms, begin: const Offset(1, 1), end: const Offset(1.15, 1.15)),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: 8),
                      SizedBox(width: 6),
                      Text(
                        'WATCH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expert info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(imageUrl),
                        backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.1),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              company,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 14),
                  
                  // Rating
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: const Color(0xFFFBBF24),
                        size: 18,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 14),
                  
                  // Quote
                  Expanded(
                    child: Text(
                      '"$quote"',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.grey[700],
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Verified badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF10B981).withOpacity(0.1),
                          const Color(0xFF34D399).withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Color(0xFF10B981), size: 14),
                        SizedBox(width: 6),
                        Text(
                          'Verified Expert',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale(delay: Duration(milliseconds: delay));
  }



  // ==================== HERO SECTION ====================
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 750,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF8B5CF6),
            const Color(0xFFEC4899),
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  
                  return isWide
                      ? Row(
                          children: [
                            Expanded(flex: 5, child: _buildHeroText(context)),
                            const SizedBox(width: 60),
                            Expanded(flex: 5, child: _buildHeroImage(context)),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildHeroText(context),
                            const SizedBox(height: 40),
                            _buildHeroImage(context),
                          ],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms);
  }

  Widget _buildHeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.4)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: 16),
              SizedBox(width: 6),
              Text(
                '🔥 #1 Best Seller This Month',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(),
        
        const SizedBox(height: 30),
        
        // Main Headline
        Text(
          widget.product.title,
          style: const TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.1,
            letterSpacing: -2,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(),
        
        const SizedBox(height: 20),
        
        // Subheadline
        Text(
          'Transform Your Life with Premium Quality That Actually Delivers Results',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white.withOpacity(0.95),
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(delay: 600.ms).slideY(),
        
        const SizedBox(height: 40),
        
        // Trust Indicators
        Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _buildMiniTrustBadge(Icons.verified_user, '30-Day Guarantee'),
            _buildMiniTrustBadge(Icons.local_shipping, 'Free Shipping'),
            _buildMiniTrustBadge(Icons.star, '4.9/5 (1,200+ Reviews)'),
          ],
        ).animate().fadeIn(delay: 800.ms),
        
        const SizedBox(height: 50),
        
        // CTA Buttons
        Row(
          children: [
            // Primary CTA
            Expanded(
              child: ElevatedButton(
                onPressed: _handleBuyNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF6366F1),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Get It Now - \$${widget.product.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 1000.ms).scale(),
        
        const SizedBox(height: 16),
        
        // Secondary Info
        Text(
          '✓ No credit card required  ✓ Cancel anytime',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ).animate().fadeIn(delay: 1200.ms),
      ],
    );
  }

  Widget _buildMiniTrustBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 550, maxWidth: 550),
      child: Stack(
        children: [
          // Glow Effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.3),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              widget.product.images.isNotEmpty 
                  ? widget.product.images.first 
                  : 'https://via.placeholder.com/600',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Icon(Icons.shopping_bag, size: 120, color: Colors.white),
                  ),
                );
              },
            ),
          ),
          
          // Floating Stats
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '10,000+',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                  const Text(
                    'Happy Customers',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 1400.ms).scale(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).scale();
  }

  // ==================== PROBLEM SECTION ====================
  Widget _buildProblemSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFEF2F2),
            Colors.white,
            const Color(0xFFFEE2E2),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              // Animated Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFFEF4444).withOpacity(0.1),
                      const Color(0xFFF87171).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFFEF4444).withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.warning_rounded, color: Colors.white, size: 16),
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                      .shake(duration: 1000.ms, hz: 2),
                    const SizedBox(width: 12),
                    const Text(
                      'THE PROBLEM',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEF4444),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).scale(),
              
              const SizedBox(height: 40),
              
              const Text(
                'Tired of Products That Promise Everything But Deliver Nothing?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  color: Colors.black,
                  letterSpacing: -1,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 30),
              
              Text(
                'You\'ve tried countless products. Spent money on things that broke after a week. Dealt with poor customer service. Watched your hard-earned money disappear on low-quality items that didn\'t solve your problem.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey[700],
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 60),
              
              // Pain Points Grid with images
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1),
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.2,
                    children: [
                      _buildPainPointCard(
                        '❌',
                        'Poor Quality',
                        'Low-grade materials that fall apart',
                        'https://images.unsplash.com/photo-1615840287214-7ff58936c4cf?w=400&h=300&fit=crop',
                        0,
                      ),
                      _buildPainPointCard(
                        '😞',
                        'No Support',
                        'Left alone with no help when needed',
                        'https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=400&h=300&fit=crop',
                        200,
                      ),
                      _buildPainPointCard(
                        '💸',
                        'Hidden Costs',
                        'Surprise fees that drain your wallet',
                        'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=400&h=300&fit=crop',
                        400,
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
  
  Widget _buildPainPointCard(String emoji, String title, String description, String imageUrl, int delay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Background image with overlay
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFEF4444).withOpacity(0.1),
                          const Color(0xFFF87171).withOpacity(0.2),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    emoji,
                    style: const TextStyle(fontSize: 48),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .shake(duration: 1000.ms, hz: 1),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale(delay: Duration(milliseconds: delay));
  }



  // ==================== SOLUTION SECTION ====================
  Widget _buildSolutionSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF0FDF4),
            Colors.white,
            const Color(0xFFD1FAE5),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              // Animated Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF10B981).withOpacity(0.1),
                      const Color(0xFF34D399).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF34D399)],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle, color: Colors.white, size: 16),
                    ).animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 2000.ms, color: Colors.white),
                    const SizedBox(width: 12),
                    const Text(
                      'THE SOLUTION',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF10B981),
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).scale(),
              
              const SizedBox(height: 40),
              
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Introducing ${widget.product.title}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                        color: Colors.black,
                        letterSpacing: -1.5,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3, end: 0),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              const Text(
                'The ONLY product you\'ll ever need. Built with premium materials, backed by a 30-day guarantee, and trusted by over 10,000 happy customers worldwide.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.3, end: 0),
              
              const SizedBox(height: 70),
              
              // Benefits Grid with luxury design
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1),
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1.1,
                    children: [
                      _buildLuxuryBenefitCard(
                        Icons.diamond,
                        'Premium Quality',
                        'Hand-crafted with finest materials',
                        const Color(0xFF10B981),
                        'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400&h=300&fit=crop',
                        0,
                      ),
                      _buildLuxuryBenefitCard(
                        Icons.support_agent,
                        '24/7 Support',
                        'Expert team always ready to help',
                        const Color(0xFF6366F1),
                        'https://images.unsplash.com/photo-1556740758-90de374c12ad?w=400&h=300&fit=crop',
                        200,
                      ),
                      _buildLuxuryBenefitCard(
                        Icons.verified_user,
                        'Guaranteed',
                        '30-day money-back promise',
                        const Color(0xFFEC4899),
                        'https://images.unsplash.com/photo-1450101499163-c8848c66ca85?w=400&h=300&fit=crop',
                        400,
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
  
  Widget _buildLuxuryBenefitCard(IconData icon, String title, String description, Color color, String imageUrl, int delay) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(27),
        child: Stack(
          children: [
            // Full background image with gradient overlay
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [color.withOpacity(0.3), color.withOpacity(0.6)],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Gradient overlay for readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withOpacity(0.6),
                      color.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),
            // Shimmer effect overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.3)),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 42, color: color),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(duration: 1500.ms, begin: const Offset(1, 1), end: const Offset(1.15, 1.15)),
                  const SizedBox(height: 24),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 1),
                          blurRadius: 3,
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
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale(delay: Duration(milliseconds: delay));
  }



  // ==================== FEATURES SECTION ====================
  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6366F1).withOpacity(0.1),
                      const Color(0xFFEC4899).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: const Text(
                  'POWERFUL FEATURES',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF6366F1),
                    letterSpacing: 2,
                  ),
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 30),
              
              const Text(
                'Everything You Need, Nothing You Don\'t',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 20),
              
              Text(
                'Packed with cutting-edge features designed to transform your experience',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 70),
              
              // Features Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  final crossAxisCount = isWide ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                  
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.95,
                    children: [
                      _buildFeatureCard(
                        Icons.flash_on,
                        'Lightning Fast',
                        'Experience blazing-fast performance',
                        const Color(0xFFFBBF24),
                        'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=400&h=400&fit=crop',
                        0,
                      ),
                      _buildFeatureCard(
                        Icons.security,
                        'Ultra Secure',
                        'Military-grade security protection',
                        const Color(0xFF10B981),
                        'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=400&h=400&fit=crop',
                        100,
                      ),
                      _buildFeatureCard(
                        Icons.eco,
                        'Eco-Friendly',
                        'Sustainable materials for the planet',
                        const Color(0xFF22C55E),
                        'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400&h=400&fit=crop',
                        200,
                      ),
                      _buildFeatureCard(
                        Icons.auto_awesome,
                        'AI-Powered',
                        'Smart technology that adapts',
                        const Color(0xFF6366F1),
                        'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=400&h=400&fit=crop',
                        300,
                      ),
                      _buildFeatureCard(
                        Icons.phone_android,
                        'Works Everywhere',
                        'Seamless across all devices',
                        const Color(0xFFEC4899),
                        'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400&h=400&fit=crop',
                        400,
                      ),
                      _buildFeatureCard(
                        Icons.support_agent,
                        '24/7 Support',
                        'Expert help always available',
                        const Color(0xFF8B5CF6),
                        'https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?w=400&h=400&fit=crop',
                        500,
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

  Widget _buildFeatureCard(IconData icon, String title, String description, Color color, String imageUrl, int delayMs) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 25,
            offset: const Offset(0, 12),
            spreadRadius: 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withOpacity(0.3), color.withOpacity(0.6)],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      color.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 38, color: color),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(duration: 1800.ms, begin: const Offset(1, 1), end: const Offset(1.12, 1.12)),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 1),
                          blurRadius: 3,
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
    ).animate().fadeIn(delay: Duration(milliseconds: delayMs)).scale(delay: Duration(milliseconds: delayMs));
  }

  // ==================== HOW IT WORKS ====================
  Widget _buildHowItWorksSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: const Color(0xFFF9FAFB),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const Text(
                'HOW IT WORKS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6366F1),
                  letterSpacing: 2,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 20),
              
              const Text(
                'Get Started in 3 Simple Steps',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 70),
              
              Column(
                children: [
                  _buildStep(1, 'Order Now', 'Click the button and complete your order in seconds'),
                  const SizedBox(height: 40),
                  _buildStep(2, 'We Ship Fast', 'Get your product delivered to your door in 3-5 days'),
                  const SizedBox(height: 40),
                  _buildStep(3, 'Enjoy Results', 'Start using and see the transformation immediately'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int number, String title, String description) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: Duration(milliseconds: number * 200)).slideX();
  }

  // ==================== TESTIMONIALS ====================
  Widget _buildTestimonialsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text(
                'CUSTOMER REVIEWS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6366F1),
                  letterSpacing: 2,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 20),
              
              const Text(
                'Loved by 10,000+ Happy Customers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 16),
              
              // Star Rating
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(5, (index) => const Icon(Icons.star, color: Color(0xFFFBBF24), size: 32)),
                  const SizedBox(width: 12),
                  const Text(
                    '4.9 out of 5',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 70),
              
              // Testimonials Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  
                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildTestimonial('Sarah Johnson', 'Marketing Manager', 'This product completely changed my workflow! I can\'t imagine going back to how things were before. The quality is outstanding and customer service is top-notch.', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150', 0)),
                            const SizedBox(width: 30),
                            Expanded(child: _buildTestimonial('Michael Chen', 'Software Engineer', 'Best purchase I\'ve made this year. Worth every penny. The attention to detail is incredible and it works flawlessly. Highly recommend!', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150', 200)),
                            const SizedBox(width: 30),
                            Expanded(child: _buildTestimonial('Emma Williams', 'Entrepreneur', 'I was skeptical at first, but this exceeded all my expectations. The quality, the performance, the support - everything is perfect. 5 stars!', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150', 400)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildTestimonial('Sarah Johnson', 'Marketing Manager', 'This product completely changed my workflow! I can\'t imagine going back to how things were before.', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150', 0),
                            const SizedBox(height: 30),
                            _buildTestimonial('Michael Chen', 'Software Engineer', 'Best purchase I\'ve made this year. Worth every penny. The attention to detail is incredible.', 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150', 200),
                            const SizedBox(height: 30),
                            _buildTestimonial('Emma Williams', 'Entrepreneur', 'I was skeptical at first, but this exceeded all my expectations. Everything is perfect!', 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150', 400),
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

  Widget _buildTestimonial(String name, String role, String text, String imageUrl, int delayMs) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: List.generate(
              5,
              (index) => const Icon(Icons.star, color: Color(0xFFFBBF24), size: 20),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '"$text"',
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified, size: 16, color: Color(0xFF10B981)),
                SizedBox(width: 6),
                Text(
                  'Verified Purchase',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF10B981),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delayMs)).slideY();
  }

  // ==================== CUSTOMER STORIES ====================
  Widget _buildCustomerStoriesSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFF9FAFB),
            const Color(0xFFFFFFFF),
            const Color(0xFFF3E8FF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Section Header
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEC4899).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '❤️ REAL PEOPLE, REAL RESULTS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFEC4899),
                    letterSpacing: 1.5,
                  ),
                ),
              ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
              
              const SizedBox(height: 20),
              
              Text(
                'See How It Changed Lives',
                style: TextStyle(
                  fontSize: isMobile ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1F2937),
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(),
              
              const SizedBox(height: 16),
              
              Text(
                'Join thousands of satisfied customers who transformed their lives',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 20,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
            ],
          ),
          
          SizedBox(height: isMobile ? 40 : 60),
          
          // Stories Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = isMobile ? 1 : (constraints.maxWidth > 900 ? 3 : 2);
              
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: isMobile ? 0.75 : 0.85,
                children: [
                  _buildCustomerStory(
                    name: 'Sarah Johnson',
                    location: 'Los Angeles, CA',
                    story: 'This product completely changed my daily routine. I can\'t imagine life without it anymore!',
                    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400',
                    rating: 5,
                    verified: true,
                    isVideo: false,
                    delay: 0,
                  ),
                  _buildCustomerStory(
                    name: 'Michael Chen',
                    location: 'San Francisco, CA',
                    story: 'Worth every penny! The quality exceeded my expectations. Highly recommend to everyone.',
                    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
                    rating: 5,
                    verified: true,
                    isVideo: true,
                    videoViews: '2.3K',
                    delay: 200,
                  ),
                  _buildCustomerStory(
                    name: 'Emma Davis',
                    location: 'New York, NY',
                    story: 'I was skeptical at first, but after 2 weeks of use, I\'m absolutely blown away by the results!',
                    imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=400',
                    rating: 5,
                    verified: true,
                    isVideo: false,
                    delay: 400,
                  ),
                  _buildCustomerStory(
                    name: 'David Martinez',
                    location: 'Chicago, IL',
                    story: 'Best purchase I\'ve made this year. The customer service is exceptional too!',
                    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
                    rating: 5,
                    verified: true,
                    isVideo: true,
                    videoViews: '5.1K',
                    delay: 600,
                  ),
                  _buildCustomerStory(
                    name: 'Lisa Anderson',
                    location: 'Miami, FL',
                    story: 'My friends keep asking me what my secret is. Now they all want one too!',
                    imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
                    rating: 5,
                    verified: true,
                    isVideo: false,
                    delay: 800,
                  ),
                  _buildCustomerStory(
                    name: 'James Wilson',
                    location: 'Seattle, WA',
                    story: 'Revolutionary product! It solved a problem I\'ve had for years. Thank you!',
                    imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
                    rating: 5,
                    verified: true,
                    isVideo: true,
                    videoViews: '8.7K',
                    delay: 1000,
                  ),
                ],
              );
            },
          ),
          
          SizedBox(height: isMobile ? 40 : 60),
          
          // View More Stories Button
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Navigate to full stories page
            },
            icon: const Icon(Icons.play_circle_outline, size: 24),
            label: const Text(
              'Watch More Success Stories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEC4899),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 32 : 48,
                vertical: isMobile ? 16 : 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFEC4899).withOpacity(0.5),
            ),
          ).animate().fadeIn(delay: 1200.ms).scale(),
          
          const SizedBox(height: 20),
          
          // Social Proof Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialProofStat('50K+', 'Happy Customers'),
              const SizedBox(width: 40),
              _buildSocialProofStat('4.9/5', 'Average Rating'),
              const SizedBox(width: 40),
              _buildSocialProofStat('15K+', 'Video Reviews'),
            ],
          ).animate().fadeIn(delay: 1400.ms).slideY(),
        ],
      ),
    );
  }

  Widget _buildCustomerStory({
    required String name,
    required String location,
    required String story,
    required String imageUrl,
    required int rating,
    required bool verified,
    required bool isVideo,
    String? videoViews,
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image/Video with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF6366F1).withOpacity(0.3),
                          const Color(0xFFEC4899).withOpacity(0.3),
                        ],
                      ),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.person, size: 80, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ),
              ),
              
              // Video Play Button Overlay
              if (isVideo)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: Color(0xFFEC4899),
                        ),
                      ),
                    ),
                  ),
                ),
              
              // Video Views Badge
              if (isVideo && videoViews != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.play_circle_filled, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '$videoViews views',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              // Verified Badge
              if (verified)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating Stars
                  Row(
                    children: List.generate(
                      rating,
                      (index) => const Icon(
                        Icons.star,
                        color: Color(0xFFFBBF24),
                        size: 16,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 0),
                  
                  // Story Text
                  Expanded(
                    child: Text(
                      '"$story"',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4B5563),
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  const SizedBox(width: 50),
                  
                  // Customer Info
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideY();
  }

  Widget _buildSocialProofStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFFEC4899),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6B7280),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ==================== TRUST BADGES ====================
  Widget _buildTrustBadgesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFF9FAFB),
      child: Center(
        child: Wrap(
          spacing: 60,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            _buildTrustBadge(Icons.verified_user, '30-Day\nMoney Back', const Color(0xFF10B981)),
            _buildTrustBadge(Icons.local_shipping, 'Free\nShipping', const Color(0xFF6366F1)),
            _buildTrustBadge(Icons.security, 'Secure\nCheckout', const Color(0xFFFBBF24)),
            _buildTrustBadge(Icons.workspace_premium, '2-Year\nWarranty', const Color(0xFFEC4899)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String text, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 48, color: color),
        ),
        const SizedBox(height: 16),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ],
    ).animate().fadeIn().scale();
  }

  // ==================== PRICING SECTION ====================
  Widget _buildPricingSection(BuildContext context) {
    final originalPrice = widget.product.price * 1.5;
    final discount = ((originalPrice - widget.product.price) / originalPrice * 100).toInt();
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            const Color(0xFFF0FDF4),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFF10B981), width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withOpacity(0.2),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '🔥 SPECIAL LAUNCH OFFER - Save $discount%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$${originalPrice.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Only',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF10B981),
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              const Text(
                'What\'s Included:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              
              const SizedBox(height: 20),
              
              _buildIncludedItem('✓ Premium Product'),
              _buildIncludedItem('✓ Free Shipping Worldwide'),
              _buildIncludedItem('✓ 30-Day Money-Back Guarantee'),
              _buildIncludedItem('✓ 2-Year Warranty'),
              _buildIncludedItem('✓ 24/7 Customer Support'),
              _buildIncludedItem('✓ Lifetime Updates'),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleBuyNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get It Now',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(Icons.arrow_forward, size: 24),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              Text(
                '⏰ Limited time offer! Don\'t miss out',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).scale(),
      ),
    );
  }

  Widget _buildIncludedItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== FAQ ====================
  Widget _buildFAQSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Text(
                'FREQUENTLY ASKED QUESTIONS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6366F1),
                  letterSpacing: 2,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 20),
              
              const Text(
                'Got Questions? We\'ve Got Answers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 60),
              
              _buildFAQItem('How long does shipping take?', 'We offer free shipping worldwide. Most orders arrive within 3-5 business days. You\'ll receive a tracking number as soon as your order ships.'),
              _buildFAQItem('What\'s your return policy?', 'We offer a 30-day money-back guarantee. If you\'re not completely satisfied, simply return it for a full refund. No questions asked.'),
              _buildFAQItem('Is it really worth the price?', 'Absolutely! Our product is built with premium materials and backed by thousands of 5-star reviews. Plus, with our money-back guarantee, there\'s zero risk.'),
              _buildFAQItem('How do I contact support?', 'Our 24/7 support team is always here to help. Email us at support@novastore.com or use the chat button on this page.'),
              _buildFAQItem('Do you offer bulk discounts?', 'Yes! Contact our sales team for special pricing on bulk orders. The more you buy, the more you save.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 9, 6, 6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideY();
  }

  // ==================== FINAL CTA ====================
  // ==================== FINAL CTA SECTION ====================
  Widget _buildFinalCTASection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 60,
            offset: const Offset(0, 30),
            spreadRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Stack(
          children: [
            // Background image with overlay
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1557804506-669a67965ba0?w=1200&h=800&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF6366F1).withOpacity(0.95),
                      const Color(0xFF8B5CF6).withOpacity(0.92),
                      const Color(0xFFEC4899).withOpacity(0.95),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(80),
              child: Column(
                children: [
                  // Animated icon
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.rocket_launch,
                      size: 70,
                      color: Colors.white,
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(duration: 2000.ms, begin: const Offset(1, 1), end: const Offset(1.15, 1.15))
                    .then()
                    .shimmer(duration: 1500.ms, color: Colors.white.withOpacity(0.5)),
                  
                  const SizedBox(height: 40),
                  
                  const Text(
                    'Ready to Transform Your Life?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.1,
                      letterSpacing: -1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  const Text(
                    'Join 10,000+ happy customers who transformed their lives',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 50),
                  
                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCTAStat('10K+', 'Happy Customers'),
                      Container(
                        width: 2,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildCTAStat('4.9★', 'Average Rating'),
                      Container(
                        width: 2,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildCTAStat('99%', 'Satisfaction'),
                    ],
                  ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 60),
                  
                  // Main CTA button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _handleBuyNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 28),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Get Started Now - \$${widget.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_forward, color: Colors.white, size: 24),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms).scale(delay: 800.ms, duration: 600.ms),
                  
                  const SizedBox(height: 40),
                  
                  // Trust badges
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 30,
                    runSpacing: 16,
                    children: [
                      _buildCTATrustBadge(Icons.verified_user, '30-Day Guarantee'),
                      _buildCTATrustBadge(Icons.local_shipping, 'Free Shipping'),
                      _buildCTATrustBadge(Icons.support_agent, '24/7 Support'),
                      _buildCTATrustBadge(Icons.lock, 'Secure Checkout'),
                    ],
                  ).animate().fadeIn(delay: 1000.ms),
                  
                  const SizedBox(height: 30),
                  
                  // Urgency message
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text(
                          '⚡ Limited Stock - Only 47 Units Left!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCTAStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
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
  
  Widget _buildCTATrustBadge(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // ==================== BEFORE/AFTER SECTION ====================
  Widget _buildBeforeAfterSection(BuildContext context) {
    final transformations = [
      {
        'before': 'https://images.unsplash.com/photo-1504198266287-1659872e6590?w=400&h=300&fit=crop',
        'after': 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400&h=300&fit=crop',
        'name': 'Sarah M.',
        'result': 'Increased productivity by 300%',
      },
      {
        'before': 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=400&h=300&fit=crop',
        'after': 'https://images.unsplash.com/photo-1542744173-8e7e53415bb0?w=400&h=300&fit=crop',
        'name': 'Michael T.',
        'result': 'Saved 20 hours per week',
      },
      {
        'before': 'https://images.unsplash.com/photo-1497493292307-31c376b6e479?w=400&h=300&fit=crop',
        'after': 'https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=400&h=300&fit=crop',
        'name': 'Emily R.',
        'result': 'Doubled her results in 30 days',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[50]!,
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF10B981).withOpacity(0.15),
                      const Color(0xFF34D399).withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: const Text(
                  'REAL TRANSFORMATIONS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF10B981),
                    letterSpacing: 2,
                  ),
                ),
              ).animate().fadeIn().scale(),
              
              const SizedBox(height: 30),
              
              const Text(
                'See the Dramatic Results',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1.5,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 20),
              
              Text(
                'Real people, real results. These are just a few of the thousands who transformed their lives.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 70),
              
              // Transformations Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1),
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 0.9,
                    children: List.generate(transformations.length, (index) {
                      final transformation = transformations[index];
                      return _buildBeforeAfterCard(
                        transformation['before'] as String,
                        transformation['after'] as String,
                        transformation['name'] as String,
                        transformation['result'] as String,
                        index * 200,
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBeforeAfterCard(String beforeUrl, String afterUrl, String name, String result, int delay) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF10B981).withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10B981).withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Before/After Images
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(
                        beforeUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                          );
                        },
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'BEFORE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 2, height: 200, color: Colors.white),
                Expanded(
                  child: Stack(
                    children: [
                      Image.network(
                        afterUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[300],
                          );
                        },
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'AFTER',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Color(0xFF10B981), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF10B981).withOpacity(0.1),
                        const Color(0xFF34D399).withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up, color: Color(0xFF10B981), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          result,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF10B981),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(Icons.star, color: Color(0xFFFBBF24), size: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale(delay: Duration(milliseconds: delay));
  }

  // ==================== LIMITED OFFER SECTION ====================
  Widget _buildLimitedOfferSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEF4444),
            Color(0xFFDC2626),
            Color(0xFFF97316),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEF4444).withOpacity(0.4),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          // Urgency badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_fire_department, color: Colors.white, size: 24),
                SizedBox(width: 10),
                Text(
                  '🔥 LIMITED TIME OFFER',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ).animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1500.ms, color: Colors.white.withOpacity(0.5)),
          
          const SizedBox(height: 40),
          
          const Text(
            'Last Chance: Special Discount Ends Soon!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 30),
          
          // Countdown timer (LIVE)
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimerUnit(
                  _timeRemaining.inHours.toString().padLeft(2, '0'),
                  'HOURS',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(':', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                _buildTimerUnit(
                  (_timeRemaining.inMinutes % 60).toString().padLeft(2, '0'),
                  'MINUTES',
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(':', style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                _buildTimerUnit(
                  (_timeRemaining.inSeconds % 60).toString().padLeft(2, '0'),
                  'SECONDS',
                ),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).scale(),
          
          const SizedBox(height: 40),
          
          // Offer details
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    'Regular Price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${(widget.product.price * 1.5).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 40),
              const SizedBox(width: 40),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'SAVE 33%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ).animate().fadeIn(delay: 600.ms),
          
          const SizedBox(height: 50),
          
          // CTA
          ElevatedButton(
            onPressed: _handleBuyNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFEF4444),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 12,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.bolt, size: 28),
                SizedBox(width: 12),
                Text(
                  'Claim Your Discount Now',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.arrow_forward, size: 24),
              ],
            ),
          ).animate().fadeIn(delay: 800.ms).scale(delay: 800.ms),
          
          const SizedBox(height: 30),
          
          // Stock indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ).animate(onPlay: (controller) => controller.repeat())
                .fadeOut(duration: 800.ms)
                .then()
                .fadeIn(duration: 800.ms),
              const SizedBox(width: 12),
              const Text(
                'Only 47 units left at this price!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTimerUnit(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  // ==================== FOOTER ====================
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: const Color(0xFF1F2937),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.shopping_bag, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              const Text(
                'NovaStoreAi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          Text(
            'AI-Powered Shopping Experience',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          
          const SizedBox(height: 40),
          
          Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _buildFooterLink('Privacy Policy'),
              _buildFooterLink('Terms of Service'),
              _buildFooterLink('Shipping Info'),
              _buildFooterLink('Returns'),
              _buildFooterLink('Contact Us'),
            ],
          ),
          
          const SizedBox(height: 40),
          
          Divider(color: Colors.white.withOpacity(0.2)),
          
          const SizedBox(height: 20),
          
          Text(
            '© 2025 NovaStoreAi. All rights reserved.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  // ==================== FLOATING BUY BUTTON ====================
  Widget _buildFloatingBuyButton(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20, // LEFT side
      child: FloatingActionButton.extended(
        onPressed: _handleBuyNow,
        backgroundColor: const Color(0xFFEC4899),
        icon: const Icon(Icons.shopping_cart, size: 20),
        label: Text(
          'Buy Now - \$${widget.product.price.toStringAsFixed(0)}',
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
        ),
        elevation: 8,
      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .fadeIn(delay: 200.ms)
        .slideX(begin: -1, end: 0, duration: 600.ms, curve: Curves.easeOutBack)
        .then()
        .shimmer(duration: 1500.ms, delay: 500.ms)
        .then()
        .shake(duration: 600.ms, delay: 3000.ms, hz: 2),
    );
  }

  Widget _buildBackToTopButton(BuildContext context) {
    return Positioned(
      bottom: 180, // More spacing from chatbot
      right: 20,
      child: Material(
        elevation: 8,
        shape: const CircleBorder(),
        color: const Color(0xFF6366F1),
        child: InkWell(
          onTap: () {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
            );
          },
          customBorder: const CircleBorder(),
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_upward,
              color: Colors.white,
              size: 24,
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
              .moveY(begin: 0, end: -4, duration: 1000.ms),
          ),
        ),
      ).animate()
        .fadeIn(delay: 200.ms, duration: 400.ms)
        .scale(delay: 200.ms, duration: 400.ms, begin: const Offset(0, 0), end: const Offset(1, 1))
        .then()
        .shimmer(duration: 1500.ms, delay: 1000.ms),
    );
  }

  // ==================== VIDEO GALLERY SECTION ====================
  Widget _buildVideoGallerySection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    final videos = [
      {
        'title': 'Product Unboxing & First Look',
        'thumbnail': 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?w=800',
        'duration': '3:24',
        'views': '125K',
      },
      {
        'title': 'Complete Setup Tutorial',
        'thumbnail': 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=800',
        'duration': '8:15',
        'views': '98K',
      },
      {
        'title': 'Advanced Features Guide',
        'thumbnail': 'https://images.unsplash.com/photo-1556656793-08538906a9f8?w=800',
        'duration': '5:47',
        'views': '76K',
      },
      {
        'title': 'Customer Reviews Compilation',
        'thumbnail': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800',
        'duration': '4:32',
        'views': '145K',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Colors.white,
      child: Column(
        children: [
          // Section Header
          Text(
            '🎥 Watch It In Action',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(),
          
          const SizedBox(height: 16),
          
          Text(
            'See real demonstrations and learn how to get the most from your purchase',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          
          SizedBox(height: isMobile ? 40 : 60),
          
          // Video Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 1.6,
            ),
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return _buildVideoCard(
                thumbnail: video['thumbnail']!,
                title: video['title']!,
                duration: video['duration']!,
                views: video['views']!,
                delay: index * 200,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard({
    required String thumbnail,
    required String title,
    required String duration,
    required String views,
    required int delay,
  }) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          // TODO: Open video player
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  thumbnail,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.play_circle_outline, size: 64),
                  ),
                ),
              ),
              
              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
              
              // Play Button
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 48,
                    color: Color(0xFF6366F1),
                  ),
                ),
              ),
              
              // Duration Badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              
              // Video Info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.visibility, color: Colors.white70, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            '$views views',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale();
  }

  // ==================== LIFESTYLE GALLERY SECTION ====================
  Widget _buildLifestyleGallerySection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    final lifestylePhotos = [
      {
        'image': 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=800',
        'title': 'At Home',
        'description': 'Perfect for your living space',
      },
      {
        'image': 'https://images.unsplash.com/photo-1497215842964-222b430dc094?w=800',
        'title': 'In the Office',
        'description': 'Boost your productivity',
      },
      {
        'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
        'title': 'On the Go',
        'description': 'Take it anywhere',
      },
      {
        'image': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
        'title': 'At the Gym',
        'description': 'Workout companion',
      },
      {
        'image': 'https://images.unsplash.com/photo-1464746133101-a2c3f88e0dd9?w=800',
        'title': 'Outdoors',
        'description': 'Adventure ready',
      },
      {
        'image': 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?w=800',
        'title': 'With Friends',
        'description': 'Share the experience',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color(0xFFF9FAFB)],
        ),
      ),
      child: Column(
        children: [
          // Section Header
          Text(
            '📸 See It In Real Life',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(),
          
          const SizedBox(height: 16),
          
          Text(
            'Real people, real situations, real results',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          
          SizedBox(height: isMobile ? 40 : 60),
          
          // Photo Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: lifestylePhotos.length,
            itemBuilder: (context, index) {
              final photo = lifestylePhotos[index];
              return _buildLifestyleCard(
                imageUrl: photo['image']!,
                title: photo['title']!,
                description: photo['description']!,
                delay: index * 150,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleCard({
    required String imageUrl,
    required String title,
    required String description,
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 48),
              ),
            ),
            
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            
            // Text
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale();
  }

  // ==================== MANUFACTURING GALLERY SECTION ====================
  Widget _buildManufacturingGallerySection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    final manufacturingPhotos = [
      {
        'image': 'https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?w=800',
        'title': 'Quality Control',
        'description': 'Every product inspected',
      },
      {
        'image': 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?w=800',
        'title': 'Skilled Craftsmen',
        'description': 'Expert hands at work',
      },
      {
        'image': 'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=800',
        'title': 'Modern Facility',
        'description': 'State-of-the-art production',
      },
      {
        'image': 'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=800',
        'title': 'Premium Materials',
        'description': 'Only the best components',
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      color: const Color(0xFF1F2937),
      child: Column(
        children: [
          // Section Header
          Text(
            '🏭 Behind The Scenes',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(),
          
          const SizedBox(height: 16),
          
          Text(
            'See how we craft perfection with care and precision',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          
          SizedBox(height: isMobile ? 40 : 60),
          
          // Photo Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.2 : 1.5,
            ),
            itemCount: manufacturingPhotos.length,
            itemBuilder: (context, index) {
              final photo = manufacturingPhotos[index];
              return _buildManufacturingCard(
                imageUrl: photo['image']!,
                title: photo['title']!,
                description: photo['description']!,
                delay: index * 200,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildManufacturingCard({
    required String imageUrl,
    required String title,
    required String description,
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[800],
                child: const Icon(Icons.factory, size: 64, color: Colors.white24),
              ),
            ),
            
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            
            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Premium Quality',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale();
  }

  // ==================== COMPARISON SECTION ====================
  Widget _buildComparisonSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 20 : 40,
      ),
      color: Colors.white,
      child: Column(
        children: [
          // Section Header
          Text(
            '⚖️ Why Choose Us?',
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1F2937),
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms).slideY(),
          
          const SizedBox(height: 16),
          
          Text(
            'See how we stack up against the competition',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
          
          SizedBox(height: isMobile ? 40 : 60),
          
          // Comparison Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(const Color(0xFF6366F1).withOpacity(0.1)),
                columns: const [
                  DataColumn(label: Text('Feature', style: TextStyle(fontWeight: FontWeight.w700))),
                  DataColumn(label: Text('Our Product', style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF6366F1)))),
                  DataColumn(label: Text('Competitor A', style: TextStyle(fontWeight: FontWeight.w700))),
                  DataColumn(label: Text('Competitor B', style: TextStyle(fontWeight: FontWeight.w700))),
                ],
                rows: [
                  _buildComparisonRow('Premium Quality', true, false, true),
                  _buildComparisonRow('2-Year Warranty', true, false, false),
                  _buildComparisonRow('Free Shipping', true, false, false),
                  _buildComparisonRow('24/7 Support', true, false, true),
                  _buildComparisonRow('30-Day Returns', true, true, false),
                  _buildComparisonRow('Eco-Friendly', true, false, false),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(),
        ],
      ),
    );
  }

  DataRow _buildComparisonRow(String feature, bool us, bool competitorA, bool competitorB) {
    Widget buildIcon(bool hasFeature) {
      return Icon(
        hasFeature ? Icons.check_circle : Icons.cancel,
        color: hasFeature ? const Color(0xFF10B981) : Colors.grey[300],
        size: 24,
      );
    }

    return DataRow(
      cells: [
        DataCell(Text(feature, style: const TextStyle(fontWeight: FontWeight.w600))),
        DataCell(buildIcon(us)),
        DataCell(buildIcon(competitorA)),
        DataCell(buildIcon(competitorB)),
      ],
    );
  }

  // ==================== HANDLERS ====================
  void _handleBuyNow() {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    if (!authService.isLoggedIn()) {
      // Show login dialog or navigate to login
      Navigator.pushNamed(context, '/login');
      return;
    }
    
    Navigator.pushNamed(
      context,
      '/checkout',
      arguments: {
        'product': widget.product,
        'variant': null,
      },
    );
  }
}

// ==================== CUSTOM PAINTER ====================
class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (var i = 0; i < 30; i++) {
      final y = (size.height / 30) * i;
      final path = Path();
      path.moveTo(0, y);
      
      for (var x = 0.0; x < size.width; x += 40) {
        final wave = math.sin((x / size.width) * math.pi * 4) * 15;
        path.lineTo(x, y + wave);
      }
      
      canvas.drawPath(path, paint);
    }

    // Draw circles
    for (var i = 0; i < 10; i++) {
      final x = (size.width / 10) * i;
      final y = (size.height / 10) * (i % 3);
      canvas.drawCircle(
        Offset(x, y),
        20 + (i % 4) * 10,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
