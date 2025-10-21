import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart';
import '../widgets/nova_store_logo.dart';

class LandingPageScreen extends StatefulWidget {
  final ProductModel product;

  const LandingPageScreen({
    super.key,
    required this.product,
  });

  @override
  State<LandingPageScreen> createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  final _scrollController = ScrollController();
  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_showAppBar) {
      setState(() => _showAppBar = true);
    } else if (_scrollController.offset <= 100 && _showAppBar) {
      setState(() => _showAppBar = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(),
            _buildProblemSolutionSection(),
            _buildFeaturesSection(),
            _buildTrustBadgesSection(),
            _buildTestimonialsSection(),
            _buildGuaranteeSection(),
            _buildFinalCTASection(),
            _buildFooter(),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingCTA(),
    );
  }

  // =========================
  // APP BAR (Sticky Navigation)
  // =========================
  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _showAppBar
              ? Colors.white.withOpacity(0.95)
              : Colors.transparent,
          boxShadow: _showAppBar
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  )
                ]
              : [],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 768;
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const NovaStoreLogo(size: 40, showText: true),
                    if (isMobile)
                      IconButton(
                        onPressed: () => _showMobileMenuDialog(),
                        icon: Icon(
                          Icons.menu,
                          size: 28,
                          color: _showAppBar ? AppColors.textPrimary : Colors.white,
                        ),
                      )
                    else
                      Row(
                        children: [
                          _buildNavButton('Features', () => _scrollToSection(1)),
                          const SizedBox(width: 16),
                          _buildNavButton('Reviews', () => _scrollToSection(4)),
                          const SizedBox(width: 16),
                          _buildBuyButton(compact: true),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: _showAppBar ? AppColors.textPrimary : Colors.white,
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _scrollToSection(int section) {
    final positions = [0.0, 800.0, 1400.0, 2000.0, 2600.0];
    if (section < positions.length) {
      _scrollController.animateTo(
        positions[section],
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showMobileMenuDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              _buildMobileMenuItem(
                icon: Icons.star,
                title: 'Features',
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(1);
                },
              ),
              _buildMobileMenuItem(
                icon: Icons.rate_review,
                title: 'Reviews',
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(4);
                },
              ),
              _buildMobileMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(2);
                },
              ),
              const Divider(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _handleBuyNow();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  // =========================
  // HERO SECTION (Full-width with Product Image/Video)
  // =========================
  Widget _buildHeroSection() {
    return Container(
      height: 700,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.secondary,
            AppColors.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _HeroPatternPainter(),
            ),
          ),
          
          // Content
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 900;
                    
                    if (isDesktop) {
                      return Row(
                        children: [
                          Expanded(child: _buildHeroContent()),
                          const SizedBox(width: 60),
                          Expanded(child: _buildHeroImage()),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeroContent(),
                          const SizedBox(height: 40),
                          _buildHeroImage(),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildHeroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.white, size: 16),
              SizedBox(width: 6),
              Text(
                '#1 Best Seller',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(),
        
        const SizedBox(height: 24),
        
        // Main Headline
        Text(
          widget.product.title,
          style: const TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.1,
            letterSpacing: -1,
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(),
        
        const SizedBox(height: 20),
        
        // Subheadline (Problem-Solution)
        Text(
          'Transform Your Life. Premium Quality That Delivers Results.',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.95),
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ).animate().fadeIn(delay: 600.ms).slideY(),
        
        const SizedBox(height: 40),
        
        // Price & CTA
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Only',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _buildBuyButton(compact: false),
            ),
          ],
        ).animate().fadeIn(delay: 800.ms).scale(),
        
        const SizedBox(height: 20),
        
        // Trust Indicators
        Row(
          children: [
            _buildTrustIndicator(Icons.local_shipping, 'Free Shipping'),
            const SizedBox(width: 20),
            _buildTrustIndicator(Icons.verified_user, '30-Day Guarantee'),
            const SizedBox(width: 20),
            _buildTrustIndicator(Icons.star, '4.9/5 Rating'),
          ],
        ).animate().fadeIn(delay: 1000.ms),
      ],
    );
  }

  Widget _buildTrustIndicator(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          widget.product.images.first,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white.withOpacity(0.2),
              child: const Center(
                child: Icon(Icons.image, size: 80, color: Colors.white),
              ),
            );
          },
        ),
      ),
    ).animate().fadeIn(delay: 600.ms).scale();
  }

  Widget _buildBuyButton({required bool compact}) {
    return ElevatedButton(
      onPressed: _handleBuyNow,
      style: ElevatedButton.styleFrom(
        backgroundColor: compact ? AppColors.primary : Colors.white,
        foregroundColor: compact ? Colors.white : AppColors.primary,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 24 : 40,
          vertical: compact ? 12 : 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(compact ? 25 : 30),
        ),
        elevation: compact ? 2 : 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Buy Now',
            style: TextStyle(
              fontSize: compact ? 16 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.arrow_forward,
            size: compact ? 18 : 24,
          ),
        ],
      ),
    );
  }

  // =========================
  // PROBLEM-SOLUTION SECTION
  // =========================
  Widget _buildProblemSolutionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Text(
                'The Problem',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                  letterSpacing: 2,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 16),
              
              Text(
                'Tired of Low-Quality Products That Don\'t Deliver?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 24),
              
              Text(
                'You deserve better. Our premium solution combines cutting-edge technology with exceptional craftsmanship to give you the results you\'ve been searching for.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(),
              
              const SizedBox(height: 50),
              
              _buildComparisonCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComparisonCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 700;
        
        return Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: [
            _buildComparisonCard(
              icon: Icons.close,
              title: 'Other Products',
              features: [
                'Poor quality materials',
                'No warranty',
                'Complicated setup',
                'Limited support',
              ],
              isNegative: true,
            ),
            _buildComparisonCard(
              icon: Icons.check_circle,
              title: widget.product.title,
              features: [
                'Premium materials',
                '30-day money-back',
                'Easy to use',
                '24/7 support',
              ],
              isNegative: false,
            ),
          ].map((card) {
            return SizedBox(
              width: isDesktop ? 320 : double.infinity,
              child: card,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildComparisonCard({
    required IconData icon,
    required String title,
    required List<String> features,
    required bool isNegative,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isNegative ? Colors.grey[50] : AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isNegative ? Colors.grey[300]! : AppColors.primary,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 50,
            color: isNegative ? Colors.grey : AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isNegative ? Colors.grey[700] : AppColors.primary,
            ),
          ),
          const SizedBox(height: 24),
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(
                    isNegative ? Icons.close : Icons.check,
                    size: 20,
                    color: isNegative ? Colors.grey : AppColors.success,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      feature,
                      style: TextStyle(
                        fontSize: 16,
                        color: isNegative ? Colors.grey[600] : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).scale();
  }

  // =========================
  // FEATURES SECTION
  // =========================
  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'FEATURES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 3,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 16),
              
              const Text(
                'Everything You Need, Nothing You Don\'t',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 60),
              
              _buildFeaturesGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      {
        'icon': Icons.speed,
        'title': 'Lightning Fast',
        'description': 'Experience unmatched performance that saves you time',
      },
      {
        'icon': Icons.security,
        'title': 'Ultra Secure',
        'description': 'Your data is protected with enterprise-grade security',
      },
      {
        'icon': Icons.eco,
        'title': 'Eco-Friendly',
        'description': 'Sustainable materials that protect our planet',
      },
      {
        'icon': Icons.auto_awesome,
        'title': 'AI-Powered',
        'description': 'Smart features that adapt to your needs',
      },
      {
        'icon': Icons.phone_android,
        'title': 'Mobile-Ready',
        'description': 'Works seamlessly on all your devices',
      },
      {
        'icon': Icons.support_agent,
        'title': '24/7 Support',
        'description': 'Expert help whenever you need it',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900 ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: 1.1,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return _buildFeatureCard(
              icon: feature['icon'] as IconData,
              title: feature['title'] as String,
              description: feature['description'] as String,
              delay: (index * 100).toDouble(),
            );
          },
        );
      },
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required double delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay.toInt())).scale();
  }

  // =========================
  // TRUST BADGES SECTION
  // =========================
  Widget _buildTrustBadgesSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Wrap(
            spacing: 60,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _buildTrustBadge(
                icon: Icons.verified_user,
                title: '30-Day',
                subtitle: 'Money Back',
              ),
              _buildTrustBadge(
                icon: Icons.local_shipping,
                title: 'Free',
                subtitle: 'Shipping',
              ),
              _buildTrustBadge(
                icon: Icons.security,
                title: 'Secure',
                subtitle: 'Checkout',
              ),
              _buildTrustBadge(
                icon: Icons.workspace_premium,
                title: '2-Year',
                subtitle: 'Warranty',
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildTrustBadge({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 40, color: AppColors.success),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // =========================
  // TESTIMONIALS SECTION
  // =========================
  Widget _buildTestimonialsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.05),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Text(
                'TESTIMONIALS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: 3,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 16),
              
              const Text(
                'Loved by Thousands of Customers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 60),
              
              _buildTestimonialsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialsGrid() {
    final testimonials = [
      {
        'name': 'Sarah Johnson',
        'role': 'Verified Buyer',
        'rating': 5,
        'text': 'This product completely exceeded my expectations! The quality is outstanding and it arrived faster than promised. Highly recommend!',
        'image': 'https://i.pravatar.cc/150?img=1',
      },
      {
        'name': 'Michael Chen',
        'role': 'Verified Buyer',
        'rating': 5,
        'text': 'Best purchase I\'ve made this year. The customer service was exceptional and the product works flawlessly. Worth every penny!',
        'image': 'https://i.pravatar.cc/150?img=13',
      },
      {
        'name': 'Emma Williams',
        'role': 'Verified Buyer',
        'rating': 5,
        'text': 'I was skeptical at first, but this product has transformed my daily routine. The quality is premium and it feels built to last.',
        'image': 'https://i.pravatar.cc/150?img=5',
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900 ? 3 : 1;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: crossAxisCount == 1 ? 2 : 0.85,
          ),
          itemCount: testimonials.length,
          itemBuilder: (context, index) {
            final testimonial = testimonials[index];
            return _buildTestimonialCard(
              name: testimonial['name'] as String,
              role: testimonial['role'] as String,
              rating: testimonial['rating'] as int,
              text: testimonial['text'] as String,
              image: testimonial['image'] as String,
              delay: (index * 150).toDouble(),
            );
          },
        );
      },
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required int rating,
    required String text,
    required String image,
    required double delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
                radius: 30,
                backgroundImage: NetworkImage(image),
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
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(
              rating,
              (index) => const Icon(
                Icons.star,
                color: Colors.amber,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 16,
                  color: AppColors.success,
                ),
                const SizedBox(width: 6),
                Text(
                  'Verified Purchase',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay.toInt())).slideY();
  }

  // =========================
  // GUARANTEE SECTION
  // =========================
  Widget _buildGuaranteeSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success, AppColors.success.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.workspace_premium,
            size: 80,
            color: Colors.white,
          ).animate().scale(delay: 200.ms),
          
          const SizedBox(height: 24),
          
          const Text(
            '30-Day Money-Back Guarantee',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.2,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(),
          
          const SizedBox(height: 20),
          
          Text(
            'Try it risk-free! If you\'re not 100% satisfied, we\'ll refund every penny. No questions asked.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.95),
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 600.ms).slideY(),
          
          const SizedBox(height: 40),
          
          ElevatedButton(
            onPressed: _handleBuyNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.success,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
            ),
            child: const Text(
              'Try It Risk-Free Now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ).animate().fadeIn(delay: 800.ms).scale(),
        ],
      ),
    );
  }

  // =========================
  // FINAL CTA SECTION
  // =========================
  Widget _buildFinalCTASection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Text(
                'Ready to Transform Your Life?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ).animate().fadeIn().slideY(),
              
              const SizedBox(height: 24),
              
              Text(
                'Join thousands of satisfied customers who have already made the switch.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(),
              
              const SizedBox(height: 40),
              
              _buildPriceCard(),
              
              const SizedBox(height: 40),
              
              Text(
                '✓ Free Shipping  ✓ 30-Day Guarantee  ✓ 24/7 Support',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Special Launch Price',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${(widget.product.price * 1.5).toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Save ${((1 - widget.product.price / (widget.product.price * 1.5)) * 100).toInt()}% - Limited Time Only!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleBuyNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Get It Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward, size: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).scale();
  }

  // =========================
  // FOOTER
  // =========================
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      color: AppColors.textPrimary,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const NovaStoreLogo(
                size: 50,
                showText: true,
                color: Colors.white,
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'AI-Powered Shopping Experience',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              
              const SizedBox(height: 32),
              
              Wrap(
                spacing: 40,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildFooterLink('Privacy Policy'),
                  _buildFooterLink('Terms of Service'),
                  _buildFooterLink('Shipping Info'),
                  _buildFooterLink('Contact Us'),
                ],
              ),
              
              const SizedBox(height: 32),
              
              Text(
                '© 2025 NovaStoreAi. All rights reserved.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
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

  // =========================
  // FLOATING CTA
  // =========================
  Widget _buildFloatingCTA() {
    return _showAppBar
        ? FloatingActionButton.extended(
            onPressed: _handleBuyNow,
            backgroundColor: AppColors.primary,
            icon: const Icon(Icons.shopping_cart),
            label: Text(
              'Buy Now - \$${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ).animate().fadeIn().slideY()
        : const SizedBox.shrink();
  }

  // =========================
  // HANDLERS
  // =========================
  void _handleBuyNow() {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    if (!authService.isLoggedIn()) {
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

// =========================
// CUSTOM PAINTERS
// =========================
class _HeroPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < 20; i++) {
      final path = Path();
      final startY = (size.height / 20) * i;
      
      path.moveTo(0, startY);
      
      for (var x = 0.0; x < size.width; x += 50) {
        path.lineTo(x, startY + (i % 2 == 0 ? 20 : -20));
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
