import 'package:flutter/material.dart';

class NavigationWidgets extends StatelessWidget {
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
      height: 40,
      color: const Color(0xFFEF4444),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              '50% OFF - Limited Time Only!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== STICKY NAVIGATION ====================
  Widget _buildStickyNav(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: isScrolled ? Colors.white : Colors.white.withOpacity(0.95),
        boxShadow: isScrolled
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
                      child: const Icon(Icons.star, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'NovaStore',
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
                  _buildNavLink('Features', onFeaturesClick),
                  const SizedBox(width: 30),
                  _buildNavLink('Videos', onVideosClick),
                  const SizedBox(width: 30),
                  _buildNavLink('Reviews', onReviewsClick),
                  const SizedBox(width: 30),
                  _buildNavLink('Pricing', onPricingClick),
                  const SizedBox(width: 30),
                  _buildNavLink('FAQ', onFaqClick),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: onBuyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
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
                  onFeaturesClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.play_circle,
                title: 'Videos',
                onTap: () {
                  Navigator.pop(context);
                  onVideosClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.rate_review,
                title: 'Reviews',
                onTap: () {
                  Navigator.pop(context);
                  onReviewsClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.shopping_bag,
                title: 'Pricing',
                onTap: () {
                  Navigator.pop(context);
                  onPricingClick();
                },
              ),
              _buildMobileMenuItem(
                context,
                icon: Icons.help_outline,
                title: 'FAQ',
                onTap: () {
                  Navigator.pop(context);
                  onFaqClick();
                },
              ),
              
              const Divider(height: 32),
              
              // Buy Now Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onBuyNow();
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
            left: 80,  // Reduced left margin
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
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
