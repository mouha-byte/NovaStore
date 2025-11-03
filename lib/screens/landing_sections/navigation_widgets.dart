import 'package:flutter/material.dart';
import 'package:store_app2025/widgets/nova_store_logo.dart';
import 'landing_constants.dart';

class NavigationWidgets extends StatefulWidget {
  final bool isScrolled;
  final VoidCallback onBuyNow;
  final VoidCallback onFeaturesClick;
  final VoidCallback onVideosClick;
  final VoidCallback onReviewsClick;
  final VoidCallback onPricingClick;
  final VoidCallback onFaqClick;

  const NavigationWidgets({
    super.key,
    required this.isScrolled,
    required this.onBuyNow,
    required this.onFeaturesClick,
    required this.onVideosClick,
    required this.onReviewsClick,
    required this.onPricingClick,
    required this.onFaqClick,
  });

  @override
  State<NavigationWidgets> createState() => _NavigationWidgetsState();
}

class _NavigationWidgetsState extends State<NavigationWidgets> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    
    _controller.addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = maxScroll * _controller.value;
        _scrollController.jumpTo(currentScroll);
      }
    });
    
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBanner(),
        _buildStickyNav(context),
      ],
    );
  }

  // ==================== TOP BANNER ====================
  Widget _buildTopBanner() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: LandingConstants.brandsList.length * 3,
        itemBuilder: (context, index) {
          final brand = LandingConstants.brandsList[index % LandingConstants.brandsList.length];
          return _buildBrandBadge(brand.logo, brand.name);
        },
      ),
    );
  }

  Widget _buildBrandBadge(String emoji, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF374151),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== STICKY NAVIGATION ====================
  Widget _buildStickyNav(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: widget.isScrolled ? Colors.white : Colors.white.withOpacity(0.95),
        boxShadow: widget.isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ]
            : [],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
            child: Row(
              children: [
                // Logo
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: NovaStoreLogo(
                  size: (isMobile ? 50 : 50),
                  showText: false,
                  color: Colors.white,
                ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Nova Ai Market',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Mobile: Hamburger Menu
                if (isMobile) ...[
                  IconButton(
                    onPressed: () => _showMobileMenu(context),
                    icon: const Icon(
                      Icons.menu,
                      size: 28,
                      color: Colors.black87,
                    ),
                  ),
                ]
                // Desktop: Navigation Links + CTA Button
                else ...[
                  _buildNavLink('Features', widget.onFeaturesClick),
                  const SizedBox(width: 30),
                  _buildNavLink('Videos', widget.onVideosClick),
                  const SizedBox(width: 30),
                  _buildNavLink('Reviews', widget.onReviewsClick),
                  const SizedBox(width: 30),
                  _buildNavLink('Pricing', widget.onPricingClick),
                  const SizedBox(width: 30),
                  _buildNavLink('FAQ', widget.onFaqClick),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: widget.onBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.shopping_cart, size: 18),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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
              // Drag Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              // Menu Items
              _buildMobileMenuItem(
                context,
                icon: Icons.star,
                title: 'Features',
                onTap: () {
                  Navigator.pop(context);
                  widget.onFeaturesClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.play_circle,
                title: 'Videos',
                onTap: () {
                  Navigator.pop(context);
                  widget.onVideosClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.rate_review,
                title: 'Reviews',
                onTap: () {
                  Navigator.pop(context);
                  widget.onReviewsClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.shopping_bag,
                title: 'Pricing',
                onTap: () {
                  Navigator.pop(context);
                  widget.onPricingClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.help_outline,
                title: 'FAQ',
                onTap: () {
                  Navigator.pop(context);
                  widget.onFaqClick();
                },
              ),

              const Divider(height: 32),

              // Buy Now Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onBuyNow();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_fire_department, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Buy Now - 50% OFF',
                          style: TextStyle(
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

  Widget _buildMobileMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildNavLink(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }
}

// ==================== FLOATING ACTION BUTTONS ====================
class FloatingActionButtons extends StatelessWidget {
  final VoidCallback onBuyNow;
  final VoidCallback onChat;

  const FloatingActionButtons({
    super.key,
    required this.onBuyNow,
    required this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Chat Button
        Positioned(
          right: 20,
          bottom: 20,
          child: FloatingActionButton(
            onPressed: onChat,
            backgroundColor: const Color(0xFF8B5CF6),
            heroTag: 'chat',
            child: const Icon(Icons.chat_bubble, color: Colors.white),
          ),
        ),

        // Buy Now Button (Mobile) - Sticky at bottom
        if (MediaQuery.of(context).size.width < 600)
          Positioned(
            left: 80, // Reduced left margin
            right: 80, // Reduced right margin
            bottom: 20, // Positioned above the chat button
            child: ElevatedButton(
              onPressed: onBuyNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: const Color(0xFFEF4444).withOpacity(0.5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_fire_department, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'BUY NOW - 50% OFF',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
      ],
    );
  }
}
