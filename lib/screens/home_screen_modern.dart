import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/product_model.dart';
import '../utils/app_theme.dart';
import '../widgets/modern_widgets.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/nova_store_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final firestoreService = Provider.of<FirestoreService>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern AppBar
          _buildAppBar(context, authService),
          
          // Content
          SliverToBoxAdapter(
            child: StreamBuilder<List<ProductModel>>(
              stream: firestoreService.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoading();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmpty(context);
                }

                // Get winning product (first one or specific ID)
                final winningProduct = snapshot.data!.first;
                final otherProducts = snapshot.data!.skip(1).take(10).toList();

                return Column(
                  children: [
                    _buildHeroSection(context, winningProduct),
                    _buildFeatures(context),
                    
                    // Other Products Section
                    if (otherProducts.isNotEmpty)
                      _buildOtherProducts(context, otherProducts, winningProduct),
                    
                    _buildReviews(context),
                    _buildFAQ(context),
                    _buildFooter(context),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // APP BAR
  // =========================
  Widget _buildAppBar(BuildContext context, AuthService authService) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          const NovaStoreLogo(size: 40, showText: true),
        ],
      ),
      actions: [
        // Theme Toggle
        const ThemeToggleIconButton(),
        
        if (authService.isLoggedIn()) ...[
          // Wallet
          IconButton(
            icon: const Icon(Icons.account_balance_wallet, color: AppColors.primary),
            onPressed: () => Navigator.pushNamed(context, '/wallet'),
            tooltip: 'My Wallet',
          ),
          // Orders
          IconButton(
            icon: const Icon(Icons.shopping_bag, color: AppColors.primary),
            onPressed: () => Navigator.pushNamed(context, '/orders'),
            tooltip: 'My Orders',
          ),
          // Admin (if admin)
          if (authService.isAdmin())
            IconButton(
              icon: const Icon(Icons.admin_panel_settings, color: AppColors.secondary),
              onPressed: () => Navigator.pushNamed(context, '/admin'),
              tooltip: 'Admin Dashboard',
            ),
          // Logout
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textSecondary),
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
            tooltip: 'Logout',
          ),
        ] else ...[
          // Login button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              icon: const Icon(Icons.login),
              label: const Text('Sign In'),
            ),
          ),
        ],
      ],
    );
  }

  // =========================
  // HERO SECTION
  // =========================
  Widget _buildHeroSection(BuildContext context, ProductModel product) {
    final isMobile = Breakpoints.isMobile(context);

    return ResponsiveContainer(
      padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.xxl),
      child: isMobile
          ? _buildHeroMobile(context, product)
          : _buildHeroDesktop(context, product),
    );
  }

  Widget _buildHeroMobile(BuildContext context, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        _buildProductImage(product),
        const SizedBox(height: AppSpacing.lg),
        // Content
        _buildHeroContent(context, product),
      ],
    );
  }

  Widget _buildHeroDesktop(BuildContext context, ProductModel product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Expanded(
          flex: 5,
          child: _buildProductImage(product),
        ),
        const SizedBox(width: AppSpacing.xxl),
        // Content
        Expanded(
          flex: 4,
          child: _buildHeroContent(context, product),
        ),
      ],
    );
  }

  Widget _buildProductImage(ProductModel product) {
    return ClipRRect(
      borderRadius: AppRadius.circular24,
      child: AspectRatio(
        aspectRatio: 1,
        child: product.images.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: product.images.first,
                fit: BoxFit.cover,
                placeholder: (context, url) => const ShimmerLoading(
                  width: double.infinity,
                  height: double.infinity,
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.border,
                  child: const Icon(Icons.image, size: 64, color: AppColors.textSecondary),
                ),
              )
            : Container(
                color: AppColors.border,
                child: const Icon(Icons.image, size: 64, color: AppColors.textSecondary),
              ),
      ),
    ).animate().fadeIn(duration: 600.ms).scale();
  }

  Widget _buildHeroContent(BuildContext context, ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.1),
            borderRadius: AppRadius.circular8,
            border: Border.all(color: AppColors.secondary),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.stars, color: AppColors.secondary, size: 16),
              const SizedBox(width: 4),
              Text(
                'TRENDING #1',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ).animate().fadeIn().slideX(),
        
        const SizedBox(height: AppSpacing.md),
        
        // Title
        Text(
          product.title,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            height: 1.2,
          ),
        ).animate().fadeIn(delay: 100.ms).slideY(),
        
        const SizedBox(height: AppSpacing.sm),
        
        // Subtitle
        Text(
          AppConstants.tagline,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(),
        
        const SizedBox(height: AppSpacing.lg),
        
        // Price
        PriceTag(
          price: product.price,
          compareAtPrice: product.compareAtPrice,
          discount: product.discountPercentage,
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        // Scarcity
        ScarcityBadge(soldCount: product.soldCount),
        
        const SizedBox(height: AppSpacing.lg),
        
        // Countdown timer
        const CountdownTimer(duration: Duration(hours: 23, minutes: 59)),
        
        const SizedBox(height: AppSpacing.xl),
        
        // CTA Buttons
        Row(
          children: [
            Expanded(
              flex: 2,
              child: GradientButton(
                text: 'Buy Now',
                icon: Icons.shopping_cart,
                onPressed: () {
                  Navigator.pushNamed(context, '/product', arguments: product.id);
                },
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/landing', arguments: product);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border, width: 2),
                borderRadius: AppRadius.circular12,
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite_border, color: AppColors.primary),
                onPressed: () {
                  // TODO: Add to wishlist
                },
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms).scale(),
        
        const SizedBox(height: AppSpacing.xl),
        
        // Trust badges
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _buildTrustBadge(Icons.verified, 'Verified Quality'),
            _buildTrustBadge(Icons.lock, 'Secure Payment'),
            _buildTrustBadge(Icons.local_shipping, 'Free Shipping'),
          ],
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _buildTrustBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: AppRadius.circular8,
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.success),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // FEATURES SECTION
  // =========================
  Widget _buildFeatures(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Text(
              'Why People Love It',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ).animate().fadeIn().slideY(),
            
            const SizedBox(height: AppSpacing.xl),
            
            Breakpoints.isMobile(context)
                ? Column(
                    children: AppConstants.features
                        .map((feature) => Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.md),
                              child: FeatureCard(
                                icon: feature['icon'] as IconData,
                                text: feature['text'] as String,
                              ),
                            ))
                        .toList(),
                  )
                : Row(
                    children: AppConstants.features
                        .map((feature) => Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                                child: FeatureCard(
                                  icon: feature['icon'] as IconData,
                                  text: feature['text'] as String,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
          ],
        ),
      ),
    );
  }

  // =========================
  // OTHER PRODUCTS SECTION
  // =========================
  Widget _buildOtherProducts(BuildContext context, List<ProductModel> products, ProductModel winningProduct) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark 
          ? AppColorsDark.surface 
          : AppColorsLight.divider,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: ResponsiveContainer(
        child: Column(
          children: [
            // Section Header with comparison badge
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.warning.withOpacity(0.1),
                    AppColors.info.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: AppColors.warning.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.warning, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '⭐ #1 Trending Product is the Best Value!',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColors.warning,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Compare with other products - Our winning product offers the best quality and price!',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.2, end: 0),

            const SizedBox(height: AppSpacing.xl),

            // Section Title
            Text(
              'Other Products',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 200.ms).slideY(),

            const SizedBox(height: AppSpacing.sm),

            Text(
              'Browse alternatives (but nothing beats our #1 product!)',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 300.ms),

            const SizedBox(height: AppSpacing.xl),

            // Products Grid
            Breakpoints.isMobile(context)
                ? _buildProductsColumn(context, products, winningProduct)
                : _buildProductsGrid(context, products, winningProduct),
          ],
        ),
      ),
    );
  }

  // Mobile: Column layout (2 columns)
  Widget _buildProductsColumn(BuildContext context, List<ProductModel> products, ProductModel winningProduct) {
    return Column(
      children: [
        for (int i = 0; i < products.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child: _buildSmallProductCard(context, products[i], winningProduct, i),
                ),
                if (i + 1 < products.length) ...[
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _buildSmallProductCard(context, products[i + 1], winningProduct, i + 1),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  // Desktop: Grid layout (5 columns)
  Widget _buildProductsGrid(BuildContext context, List<ProductModel> products, ProductModel winningProduct) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Breakpoints.isDesktop(context) ? 5 : 3,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildSmallProductCard(context, products[index], winningProduct, index);
      },
    );
  }

  // Small Product Card
  Widget _buildSmallProductCard(BuildContext context, ProductModel product, ProductModel winningProduct, int index) {
    final priceDifference = product.price - winningProduct.price;
    final isMoreExpensive = priceDifference > 0;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product', arguments: product.id),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          boxShadow: AppShadows.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadius.md),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: product.images.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: product.images.first,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.border,
                              child: const Center(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.border,
                              child: const Icon(Icons.image_not_supported),
                            ),
                          )
                        : Container(
                            color: AppColors.border,
                            child: const Icon(Icons.image, size: 40),
                          ),
                  ),
                ),

                // Comparison badge
                if (isMoreExpensive)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        '+\$${priceDifference.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text(
                        '-\$${priceDifference.abs().toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const Spacer(),

                    // Price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isMoreExpensive ? AppColors.error : AppColors.success,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Comparison text
                    Text(
                      isMoreExpensive 
                          ? 'More expensive'
                          : 'Lower quality',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate(delay: (index * 50).ms)
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.2, end: 0);
  }

  // =========================
  // REVIEWS SECTION
  // =========================
  Widget _buildReviews(BuildContext context) {
    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: Column(
        children: [
          Text(
            'What Our Customers Say',
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ).animate().fadeIn().slideY(),
          
          const SizedBox(height: AppSpacing.sm),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 24)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '5.0 (1000+ reviews)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms),
          
          const SizedBox(height: AppSpacing.xl),
          
          Breakpoints.isMobile(context)
              ? Column(
                  children: AppConstants.reviews
                      .map((review) => Padding(
                            padding: const EdgeInsets.only(bottom: AppSpacing.md),
                            child: ReviewCard(
                              name: review['name']!,
                              rating: review['rating']!,
                              text: review['text']!,
                            ),
                          ))
                      .toList(),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: AppConstants.reviews
                      .map((review) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                              child: ReviewCard(
                                name: review['name']!,
                                rating: review['rating']!,
                                text: review['text']!,
                              ),
                            ),
                          ))
                      .toList(),
                ),
        ],
      ),
    );
  }

  // =========================
  // FAQ SECTION
  // =========================
  Widget _buildFAQ(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxl),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ).animate().fadeIn().slideY(),
            
            const SizedBox(height: AppSpacing.xl),
            
            ...AppConstants.faq.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: FAQItem(
                    question: item['question']!,
                    answer: item['answer']!,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // =========================
  // FOOTER
  // =========================
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.textPrimary, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            const Icon(Icons.storefront_rounded, color: Colors.white, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.appName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              AppConstants.copyright,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: AppSpacing.lg),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Terms & Conditions', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Return Policy', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Contact Support', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // LOADING STATE
  // =========================
  Widget _buildLoading() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: CircularProgressIndicator(),
      ),
    );
  }

  // =========================
  // EMPTY STATE
  // =========================
  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.inventory_outlined, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: AppSpacing.md),
            const Text('No products available yet'),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/admin'),
              child: const Text('Go to Admin'),
            ),
          ],
        ),
      ),
    );
  }
}
