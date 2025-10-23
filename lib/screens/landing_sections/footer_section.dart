import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_app2025/widgets/nova_store_logo.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Launch URL helper
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  // Handle newsletter subscription
  void _subscribeNewsletter() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Simulate subscription (you can connect to Firebase or backend here)
    _emailController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('✓ Successfully subscribed! Check your email.'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  // Handle footer link clicks
  void _handleLinkClick(String category, String link) {
    switch (link.toLowerCase()) {
      // Shop links
      case 'products':
        Navigator.pushNamed(context, '/home');
        break;
      case 'pricing':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Pricing...')),
        );
        break;
      case 'deals':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Special Deals...')),
        );
        break;
      case 'gift cards':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Gift Cards...')),
        );
        break;

      // Support links
      case 'faq':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening FAQ...')),
        );
        break;
      case 'contact':
        _launchURL('mailto:support@novaaimarket.com?subject=Support Request');
        break;
      case 'shipping':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Shipping Info...')),
        );
        break;
      case 'returns':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Returns Policy...')),
        );
        break;

      // Company links
      case 'about':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening About Us...')),
        );
        break;
      case 'blog':
        _launchURL('https://blog.novaaimarket.com');
        break;
      case 'careers':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Careers...')),
        );
        break;
      case 'press':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opening Press Kit...')),
        );
        break;

      // Legal links
      case 'privacy':
        Navigator.pushNamed(context, '/privacy');
        break;
      case 'terms':
        Navigator.pushNamed(context, '/terms');
        break;
      case 'cookies':
        Navigator.pushNamed(context, '/cookies');
        break;
      case 'security':
        Navigator.pushNamed(context, '/security');
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Opening $link...')),
        );
    }
  }

  // Handle social media clicks
  void _handleSocialClick(String platform) {
    switch (platform) {
      case 'facebook':
        _launchURL('https://facebook.com/novaaimarket');
        break;
      case 'instagram':
        _launchURL('https://instagram.com/novaaimarket');
        break;
      case 'twitter':
        _launchURL('https://twitter.com/novaaimarket');
        break;
      case 'youtube':
        _launchURL('https://youtube.com/@novaaimarket');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // Main Footer Content
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 900;
                  
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 2, child: _buildBrandColumn()),
                        const SizedBox(width: 60),
                        Expanded(child: _buildLinkColumn('Shop', ['Products', 'Pricing', 'Deals', 'Gift Cards'])),
                        Expanded(child: _buildLinkColumn('Support', ['FAQ', 'Contact', 'Shipping', 'Returns'])),
                        Expanded(child: _buildLinkColumn('Company', ['About', 'Blog', 'Careers', 'Press'])),
                        Expanded(child: _buildLinkColumn('Legal', ['Privacy', 'Terms', 'Cookies', 'Security'])),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBrandColumn(),
                        const SizedBox(height: 40),
                        _buildLinkColumn('Shop', ['Products', 'Pricing', 'Deals', 'Gift Cards']),
                        const SizedBox(height: 30),
                        _buildLinkColumn('Support', ['FAQ', 'Contact', 'Shipping', 'Returns']),
                        const SizedBox(height: 30),
                        _buildLinkColumn('Company', ['About', 'Blog', 'Careers', 'Press']),
                        const SizedBox(height: 30),
                        _buildLinkColumn('Legal', ['Privacy', 'Terms', 'Cookies', 'Security']),
                      ],
                    );
                  }
                },
              ),
              
              const SizedBox(height: 60),
              
              // Divider
              Divider(color: Colors.white.withOpacity(0.1), thickness: 1),
              
              const SizedBox(height: 40),
              
              // Bottom Bar
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;
                  
                  if (isWide) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCopyright(),
                        _buildSocialLinks(),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildSocialLinks(),
                        const SizedBox(height: 20),
                        _buildCopyright(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
child: NovaStoreLogo(
                              size: 60,
                              showText: false,
                              color: Colors.white,
                            ),            ),
            const SizedBox(width: 12),
            const Text(
              'Nova Ai Market',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
        
        Text(
          'Premium products that make a difference.\nTrusted by thousands worldwide.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
            height: 1.6,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Newsletter
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  onSubmitted: (_) => _subscribeNewsletter(),
                ),
              ),
              ElevatedButton(
                onPressed: _subscribeNewsletter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Subscribe',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkColumn(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
              onTap: () => _handleLinkClick(title, link),
              hoverColor: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  link,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© ${DateTime.now().year} Nova Ai Market. All rights reserved.',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[500],
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(Icons.facebook_rounded, 'facebook', const Color(0xFF1877F2)),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.camera_alt_rounded, 'instagram', const Color(0xFFE4405F)), // Instagram
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.close_rounded, 'twitter', const Color(0xFF1DA1F2)), // Twitter/X
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.play_circle_fill_rounded, 'youtube', const Color(0xFFFF0000)), // YouTube
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform, Color brandColor) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => _handleSocialClick(platform),
        borderRadius: BorderRadius.circular(10),
        onHover: (isHovering) {
          // Visual feedback on hover
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.grey[400],
            size: 20,
          ),
        ),
      ),
    );
  }
}
