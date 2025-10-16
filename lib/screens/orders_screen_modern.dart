import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../utils/app_theme.dart';
import '../widgets/modern_widgets.dart';

class OrdersScreenModern extends StatefulWidget {
  const OrdersScreenModern({super.key});

  @override
  State<OrdersScreenModern> createState() => _OrdersScreenModernState();
}

class _OrdersScreenModernState extends State<OrdersScreenModern> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final firestoreService = Provider.of<FirestoreService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return Scaffold(
        body: _buildEmptyState(
          context,
          icon: Icons.login_rounded,
          title: 'Connexion requise',
          message: 'Veuillez vous connecter pour voir vos commandes',
          actionLabel: 'Se connecter',
          onAction: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern AppBar with gradient
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Mes Commandes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 60,
                          color: Colors.white,
                        ),
                      ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Tabs for filtering orders
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverTabBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Tout'),
                  Tab(text: 'En cours'),
                  Tab(text: 'Expédiés'),
                  Tab(text: 'Livrés'),
                ],
              ),
            ),
          ),

          // Orders list
          StreamBuilder<List<OrderModel>>(
            stream: firestoreService.getUserOrders(user.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverFillRemaining(
                  child: _buildLoadingState(),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SliverFillRemaining(
                  child: _buildEmptyState(
                    context,
                    icon: Icons.receipt_long_outlined,
                    title: 'Aucune commande',
                    message: 'Vous n\'avez pas encore passé de commande',
                    actionLabel: 'Commencer à acheter',
                    onAction: () => Navigator.pushReplacementNamed(context, '/home'),
                  ),
                );
              }

              final allOrders = snapshot.data!;
              
              return SliverToBoxAdapter(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrdersList(context, allOrders, null, firestoreService),
                    _buildOrdersList(context, allOrders, 'pending', firestoreService),
                    _buildOrdersList(context, allOrders, 'shipped', firestoreService),
                    _buildOrdersList(context, allOrders, 'delivered', firestoreService),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(
    BuildContext context,
    List<OrderModel> orders,
    String? statusFilter,
    FirestoreService firestoreService,
  ) {
    final filteredOrders = statusFilter == null
        ? orders
        : orders.where((o) => o.status == statusFilter).toList();

    if (filteredOrders.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: _buildEmptyState(
          context,
          icon: Icons.inbox_outlined,
          title: 'Aucune commande',
          message: 'Pas de commande avec ce statut',
          actionLabel: null,
          onAction: null,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return _buildModernOrderCard(context, order, firestoreService)
            .animate()
            .fadeIn(delay: (index * 100).ms, duration: 400.ms)
            .slideX(begin: 0.2, end: 0);
      },
    );
  }

  Widget _buildModernOrderCard(
    BuildContext context,
    OrderModel order,
    FirestoreService firestoreService,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: AppShadows.md,
      ),
      child: FutureBuilder<ProductModel?>(
        future: firestoreService.getProduct(order.productId),
        builder: (context, productSnapshot) {
          final product = productSnapshot.data;
          
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/order-confirmation',
                  arguments: order.id,
                );
              },
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [AppColors.primary, AppColors.secondary],
                                ),
                                borderRadius: BorderRadius.circular(AppRadius.sm),
                              ),
                              child: const Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Commande #${order.id.substring(0, 8).toUpperCase()}',
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMM yyyy • HH:mm').format(order.createdAt),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _buildStatusBadge(order.status),
                      ],
                    ),

                    const Divider(height: 24),

                    // Product info
                    if (product != null)
                      Row(
                        children: [
                          // Product image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                            child: CachedNetworkImage(
                              imageUrl: product.images.isNotEmpty
                                  ? product.images.first
                                  : 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                width: 80,
                                height: 80,
                                color: AppColors.surface,
                                child: const Center(
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 80,
                                height: 80,
                                color: AppColors.surface,
                                child: const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Product details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                if (order.variantId != null)
                                  Text(
                                    'Variante: ${order.variantId}',
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  formatter.format(order.totalPrice),
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    const Divider(height: 24),

                    // Shipping address
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${order.shippingAddress['address']}, ${order.shippingAddress['city']} ${order.shippingAddress['zipCode']}',
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Action button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/order-confirmation',
                            arguments: order.id,
                          );
                        },
                        icon: const Icon(Icons.visibility_outlined, size: 18),
                        label: const Text('Voir les détails'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    IconData icon;
    String label;
    
    switch (status) {
      case 'delivered':
        color = AppColors.success;
        icon = Icons.check_circle;
        label = 'Livré';
        break;
      case 'shipped':
        color = Colors.blue;
        icon = Icons.local_shipping;
        label = 'Expédié';
        break;
      case 'pending':
      case 'purchased':
        color = AppColors.warning;
        icon = Icons.schedule;
        label = 'En cours';
        break;
      default:
        color = AppColors.textSecondary;
        icon = Icons.info_outline;
        label = 'Inconnu';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
        .shimmer(duration: 2000.ms, color: color.withOpacity(0.3));
  }

  Widget _buildEmptyState(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.1),
                    AppColors.secondary.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80,
                color: AppColors.primary,
              ),
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            
            const SizedBox(height: 24),
            
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 8),
            
            Text(
              message,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 300.ms),
            
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              GradientButton(
                text: actionLabel,
                onPressed: onAction,
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.md,
          ),
          child: ShimmerLoading(
            width: double.infinity,
            height: 200,
          ),
        );
      },
    );
  }
}

// Custom SliverPersistentHeaderDelegate for TabBar
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
