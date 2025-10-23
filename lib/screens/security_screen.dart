import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Security Information',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: ${DateTime.now().year}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // Content
            _buildSection(
              'Our Commitment to Security',
              'At Nova Ai Market, we take the security of your personal information seriously. We implement industry-standard security measures to protect your data.',
            ),
            _buildSection(
              'Secure Transactions',
              'All payment transactions are processed through secure, encrypted connections. We use SSL/TLS encryption to protect your payment information.',
            ),
            _buildSection(
              'Data Protection',
              'Your personal data is stored on secure servers with restricted access. We regularly update our security systems to protect against unauthorized access.',
            ),
            _buildSection(
              'Account Security',
              'We recommend using strong, unique passwords for your account. Never share your password with anyone.',
            ),
            _buildSection(
              'Reporting Security Issues',
              'If you discover a security vulnerability, please report it immediately to security@novaaimarket.com. We take all reports seriously.',
            ),
            _buildSection(
              'Contact Us',
              'For security-related questions, contact us at support@novaaimarket.com or call 1-800-NOVA-MARKET.',
            ),

            const SizedBox(height: 40),

            // Continue Button
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
