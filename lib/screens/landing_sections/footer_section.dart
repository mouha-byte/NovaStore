import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

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
              child: const Icon(Icons.star, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              'NovaStore',
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
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
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
          child: InkWell(
            onTap: () {},
            child: Text(
              link,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© ${DateTime.now().year} NovaStore. All rights reserved.',
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
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.camera_alt), // Instagram
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.close), // Twitter/X
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.play_arrow), // YouTube
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
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
    );
  }
}
