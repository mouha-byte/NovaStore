import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import '../models/product_model.dart';
import '../utils/app_theme.dart';
import '../widgets/modern_widgets.dart';

class ProductScreen extends StatefulWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductVariant? selectedVariant;
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final authService = Provider.of<AuthService>(context);

    return FutureBuilder<ProductModel?>(
      future: firestoreService.getProduct(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Product Not Found')),
            body: const Center(child: Text('Product not found')),
          );
        }

        final product = snapshot.data!;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildAppBar(context, product),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildProductGallery(product),
                    _buildProductInfo(context, product, authService),
                    _buildDescription(product),
                    _buildShippingInfo(product),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomBar(context, product, authService),
        );
      },
    );
  }

  // =========================
  // APP BAR
  // =========================
  Widget _buildAppBar(BuildContext context, ProductModel product) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: AppShadows.sm,
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: AppShadows.sm,
            ),
            child: const Icon(Icons.share, color: AppColors.primary),
          ),
          onPressed: () {
            // TODO: Share product
          },
        ),
        const SizedBox(width: AppSpacing.sm),
      ],
    );
  }

  // =========================
  // PRODUCT GALLERY
  // =========================
  Widget _buildProductGallery(ProductModel product) {
    return Container(
      height: 400,
      color: AppColors.background,
      child: Stack(
        children: [
          // Images PageView
          PageView.builder(
            itemCount: product.images.length,
            onPageChanged: (index) {
              setState(() => _currentImageIndex = index);
            },
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: product.images[index],
                fit: BoxFit.contain,
                placeholder: (context, url) => const ShimmerLoading(
                  width: double.infinity,
                  height: double.infinity,
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.border,
                  child: const Icon(Icons.image, size: 64),
                ),
              );
            },
          ),
          
          // Dots indicator
          if (product.images.length > 1)
            Positioned(
              bottom: AppSpacing.md,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  product.images.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentImageIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentImageIndex == index
                          ? AppColors.primary
                          : AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate(target: _currentImageIndex == index ? 1 : 0)
                      .scaleX(duration: 300.ms),
                ),
              ),
            ),
          
          // Discount badge
          if (product.discountPercentage > 0)
            Positioned(
              top: AppSpacing.md,
              right: AppSpacing.md,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: AppRadius.circular12,
                  boxShadow: AppShadows.md,
                ),
                child: Text(
                  '-${product.discountPercentage}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ).animate().fadeIn().scale(),
            ),
        ],
      ),
    );
  }

  // =========================
  // PRODUCT INFO
  // =========================
  Widget _buildProductInfo(BuildContext context, ProductModel product, AuthService authService) {
    return ResponsiveContainer(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ).animate().fadeIn().slideX(),
          
          const SizedBox(height: AppSpacing.sm),
          
          // Subtitle
          Text(
            product.subtitle,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(),
          
          const SizedBox(height: AppSpacing.md),
          
          // Rating & Sold count
          Row(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return const Icon(Icons.star, color: Colors.amber, size: 20);
                }),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                '5.0',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 1,
                height: 16,
                color: AppColors.border,
              ),
              const SizedBox(width: AppSpacing.md),
              ScarcityBadge(soldCount: product.soldCount),
            ],
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Price
          PriceTag(
            price: selectedVariant?.price ?? product.price,
            compareAtPrice: product.compareAtPrice,
            discount: product.discountPercentage,
            fontSize: 36,
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Countdown
          const CountdownTimer(duration: Duration(hours: 23, minutes: 59)),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Variants
          if (product.variants.isNotEmpty) ...[
            const Text(
              'Select Variant',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: product.variants.map((variant) {
                final isSelected = selectedVariant?.variantId == variant.variantId;
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedVariant = variant);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppColors.primaryGradient : null,
                      color: isSelected ? null : Colors.white,
                      borderRadius: AppRadius.circular12,
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppColors.border,
                        width: 2,
                      ),
                      boxShadow: isSelected ? AppShadows.md : null,
                    ),
                    child: Column(
                      children: [
                        Text(
                          variant.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        if (variant.price != null && variant.price != product.price)
                          Text(
                            '\$${variant.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white70 : AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ).animate(target: isSelected ? 1 : 0).scale(),
                );
              }).toList(),
            ).animate().fadeIn(delay: 300.ms),
            const SizedBox(height: AppSpacing.xl),
          ],
        ],
      ),
    );
  }

  // =========================
  // DESCRIPTION
  // =========================
  Widget _buildDescription(ProductModel product) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: ResponsiveContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Product Description',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 400.ms);
  }

  // =========================
  // SHIPPING INFO
  // =========================
  Widget _buildShippingInfo(ProductModel product) {
    return ResponsiveContainer(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          _buildInfoCard(
            Icons.local_shipping,
            'Shipping',
            product.shippingETA,
            AppColors.info,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInfoCard(
            Icons.autorenew,
            'Return Policy',
            product.returnPolicy,
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.circular12,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: AppRadius.circular8,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideX();
  }

  // =========================
  // BOTTOM BAR
  // =========================
  Widget _buildBottomBar(BuildContext context, ProductModel product, AuthService authService) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: ResponsiveContainer(
          child: Row(
            children: [
              // Wallet balance (if logged in)
              if (authService.isLoggedIn() && authService.currentUser != null) ...[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Balance',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        '\$${authService.currentUser!.walletBalance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              
              // Buy button
              Expanded(
                flex: 2,
                child: GradientButton(
                  text: 'Buy Now',
                  icon: Icons.shopping_cart,
                  onPressed: () {
                    if (!authService.isLoggedIn()) {
                      // Redirect to login
                      Navigator.pushNamed(context, '/login');
                      return;
                    }
                    
                    Navigator.pushNamed(
                      context,
                      '/checkout',
                      arguments: {
                        'product': product,
                        'variant': selectedVariant,
                      },
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
}
