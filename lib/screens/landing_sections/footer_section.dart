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
  static const _kBackgroundColor = Color(0xFF0F172A);
  static const _kPrimaryColor = Color(0xFF8B5CF6);
  static const _kPinkColor = Color(0xFFEC4899);
  static const _kBrandName = 'Nova Ai Market';
  static const _kDescription = 'Premium products that make a difference.\nTrusted by thousands worldwide.';
  static const _kEmailSupport = 'support@novaaimarket.com';
  static const _kSocialUrls = {
    'facebook': 'https://facebook.com/novaaimarket',
    'instagram': 'https://instagram.com/novaaimarket',
    'twitter': 'https://twitter.com/novaaimarket',
    'youtube': 'https://youtube.com/@novaaimarket',
    'blog': 'https://blog.novaaimarket.com',
  };

  final _emailController = TextEditingController();

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
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  void _handleLinkClick(String category, String link) {
    final linkLower = link.toLowerCase();
    if (linkLower == 'products') Navigator.pushNamed(context, '/home');
    else if (linkLower == 'contact') _launchURL('mailto:$_kEmailSupport?subject=Support Request');
    else if (linkLower == 'blog') _launchURL(_kSocialUrls['blog']!);
    else if (['privacy', 'terms', 'cookies', 'security'].contains(linkLower)) {
      Navigator.pushNamed(context, '/$linkLower');
    } else {
      _showSnackBar('Opening $link...', null);
    }
  }

  void _handleSocialClick(String platform) => _launchURL(_kSocialUrls[platform]!);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _kBackgroundColor,
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
                            Expanded(child: _buildLinkColumn('Shop', ['Products', 'Pricing', 'Deals', 'Gift Cards'])),
                            Expanded(child: _buildLinkColumn('Support', ['FAQ', 'Contact', 'Shipping', 'Returns'])),
                            Expanded(child: _buildLinkColumn('Company', ['About', 'Blog', 'Careers', 'Press'])),
                            Expanded(child: _buildLinkColumn('Legal', ['Privacy', 'Terms', 'Cookies', 'Security'])),
                          ],
                        )
                      : Column(
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
                },
              ),
              const SizedBox(height: 60),
              Divider(color: Colors.white.withOpacity(0.1), thickness: 1),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) => constraints.maxWidth > 700
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_buildCopyright(), _buildSocialLinks()],
                      )
                    : Column(children: [_buildSocialLinks(), const SizedBox(height: 20), _buildCopyright()]),
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
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [_kPrimaryColor, _kPinkColor]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const NovaStoreLogo(size: 60, showText: false, color: Colors.white),
            ),
            const SizedBox(width: 12),
            const Text(_kBrandName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white)),
          ],
        ),
        const SizedBox(height: 20),
        Text(_kDescription, style: TextStyle(fontSize: 14, color: Colors.grey[400], height: 1.6)),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                  backgroundColor: _kPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('Subscribe', style: TextStyle(fontWeight: FontWeight.w700)),
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
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
        const SizedBox(height: 20),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: () => _handleLinkClick(title, link),
                child: Text(link, style: TextStyle(fontSize: 14, color: Colors.grey[400], fontWeight: FontWeight.w500)),
              ),
            )),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© ${DateTime.now().year} $_kBrandName. All rights reserved.',
      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(Icons.facebook_rounded, 'facebook'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.camera_alt_rounded, 'instagram'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.close_rounded, 'twitter'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.play_circle_fill_rounded, 'youtube'),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform) {
    return InkWell(
      onTap: () => _handleSocialClick(platform),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.grey[400], size: 20),
      ),
    );
  }
}
