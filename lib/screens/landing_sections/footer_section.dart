import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_app2025/widgets/nova_store_logo.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  static const _kMaxWidth = 1400.0;
  static const _kPadding = EdgeInsets.symmetric(vertical: 80, horizontal: 40);
  static const _kBackgroundColor = Color(0xFF0A0E1A);
  static const _kPrimaryColor = Color(0xFF8B5CF6);
  static const _kPinkColor = Color(0xFFEC4899);
  static const _kCyanColor = Color(0xFF06B6D4);
  static const _kBrandName = 'Nova Ai Market';
  static const _kDescription =
      'Premium products that make a difference.\nTrusted by thousands worldwide.';
  static const _kEmailSupport = 'support@novaaimarket.com';
  static const _kSocialUrls = {
    'facebook': 'https://facebook.com/novaaimarkett',
    'instagram': 'https://www.instagram.com/novaaimarkett/',
    'website': 'https://novaaimarket.com',
    'tiktok': 'https://www.tiktok.com/@nova.store2026?lang=en',
  };

  final _emailController = TextEditingController();
  final Map<String, bool> _hoverStates = {};

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }

  void _subscribeNewsletter() {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      _showSnackBar('Please enter a valid email address', Colors.orange);
      return;
    }
    _emailController.clear();
    _showSnackBar('✓ Successfully subscribed! Check your email.', Colors.green);
  }

  void _showSnackBar(String message, Color? backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _handleLinkClick(String category, String link) {
    final linkLower = link.toLowerCase();
    if (linkLower == 'products') {
      Navigator.pushNamed(context, '/home');
    } else if (linkLower == 'contact') {
      _launchURL('mailto:$_kEmailSupport?subject=Support Request');
    } else if (['privacy', 'terms', 'cookies', 'security'].contains(linkLower)) {
      Navigator.pushNamed(context, '/$linkLower');
    } else {
      _showSnackBar('Opening $link...', null);
    }
  }

  void _handleSocialClick(String platform) {
    if (_kSocialUrls.containsKey(platform)) {
      _launchURL(_kSocialUrls[platform]!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kBackgroundColor,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _kBackgroundColor,
            _kBackgroundColor.withOpacity(0.95),
            const Color(0xFF0D1321),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative background elements
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _kPrimaryColor.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _kPinkColor.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main content
          Padding(
            padding: _kPadding,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _kMaxWidth),
                child: Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth > 900;
                        return isWide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 2, child: _buildBrandColumn()),
                                  const SizedBox(width: 60),
                                  Expanded(
                                      child: _buildLinkColumn('Shop',
                                          ['Products', 'Pricing', 'Deals', 'Gift Cards'])),
                                  Expanded(
                                      child: _buildLinkColumn('Support',
                                          ['FAQ', 'Contact', 'Shipping', 'Returns'])),
                                  Expanded(
                                      child: _buildLinkColumn('Company',
                                          ['About', 'Blog', 'Careers', 'Press'])),
                                  Expanded(
                                      child: _buildLinkColumn('Legal',
                                          ['Privacy', 'Terms', 'Cookies', 'Security'])),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildBrandColumn(),
                                  const SizedBox(height: 48),
                                  Wrap(
                                    spacing: 40,
                                    runSpacing: 32,
                                    children: [
                                      _buildLinkColumn('Shop',
                                          ['Products', 'Pricing', 'Deals', 'Gift Cards']),
                                      _buildLinkColumn('Support',
                                          ['FAQ', 'Contact', 'Shipping', 'Returns']),
                                      _buildLinkColumn(
                                          'Company', ['About', 'Blog', 'Careers', 'Press']),
                                      _buildLinkColumn('Legal',
                                          ['Privacy', 'Terms', 'Cookies', 'Security']),
                                    ],
                                  ),
                                ],
                              );
                      },
                    ),
                    const SizedBox(height: 60),
                    _buildDivider(),
                    const SizedBox(height: 40),
                    LayoutBuilder(
                      builder: (context, constraints) => constraints.maxWidth > 700
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [_buildCopyright(), _buildSocialLinks()],
                            )
                          : Column(
                              children: [
                                _buildSocialLinks(),
                                const SizedBox(height: 24),
                                _buildCopyright(),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            _kPrimaryColor.withOpacity(0.3),
            _kPinkColor.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kPrimaryColor, _kPinkColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _kPrimaryColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const NovaStoreLogo(size: 32, showText: false, color: Colors.white),
            ),
            const SizedBox(width: 16),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.white, Color(0xFFE2E8F0)],
              ).createShader(bounds),
              child: const Text(
                _kBrandName,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          _kDescription,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey[400],
            height: 1.7,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 32),
        _buildNewsletterInput(),
      ],
    );
  }

  Widget _buildNewsletterInput() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white, fontSize: 15),
              decoration: InputDecoration(
                hintText: 'Enter your email for updates',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                prefixIcon: Icon(Icons.mail_outline_rounded, color: Colors.grey[500], size: 20),
              ),
              onSubmitted: (_) => _subscribeNewsletter(),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_kPrimaryColor, _kPinkColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _kPrimaryColor.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _subscribeNewsletter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Subscribe', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_kPrimaryColor, _kPinkColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ...links.map((link) => _buildLinkItem(title, link)),
      ],
    );
  }

  Widget _buildLinkItem(String category, String link) {
    final key = '$category-$link';
    final isHovered = _hoverStates[key] ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hoverStates[key] = true),
        onExit: (_) => setState(() => _hoverStates[key] = false),
        child: GestureDetector(
          onTap: () => _handleLinkClick(category, link),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isHovered ? 12 : 0,
                  child: isHovered
                      ? const Icon(Icons.arrow_forward_ios_rounded,
                          size: 10, color: _kPrimaryColor)
                      : null,
                ),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 14,
                    color: isHovered ? Colors.white : Colors.grey[400],
                    fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                  child: Text(link),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCopyright() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite_rounded, color: _kPinkColor, size: 14),
              const SizedBox(width: 6),
              Text(
                'Made with love',
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '© ${DateTime.now().year} $_kBrandName',
          style: TextStyle(fontSize: 14, color: Colors.grey[500], fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(Icons.facebook_rounded, 'facebook', const Color(0xFF1877F2)),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.camera_alt_rounded, 'instagram', const Color(0xFFE4405F)),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.close_rounded, 'tiktok', Colors.black),
        // const SizedBox(width: 12),
        // _buildSocialIcon(Icons.close_rounded, 'website', Colors.black),
       ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform, Color brandColor) {
    final isHovered = _hoverStates[platform] ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => _hoverStates[platform] = true),
      onExit: (_) => setState(() => _hoverStates[platform] = false),
      child: GestureDetector(
        onTap: () => _handleSocialClick(platform),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHovered ? brandColor.withOpacity(0.15) : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? brandColor.withOpacity(0.5) : Colors.white.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: brandColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          transform: isHovered ? (Matrix4.identity()..translate(0.0, -3.0)) : Matrix4.identity(),
          child: Icon(
            icon,
            color: isHovered ? brandColor : Colors.grey[400],
            size: 22,
          ),
        ),
      ),
    );
  }
}
