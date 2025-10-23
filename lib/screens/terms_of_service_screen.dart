import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
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
              'Terms of Service',
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
              'Acceptance of Terms',
              'By accessing and using Nova Ai Market, you accept and agree to be bound by these Terms of Service.',
            ),
            _buildSection(
              'Use of Service',
              'You agree to use our service only for lawful purposes and in accordance with these Terms.',
            ),
            _buildSection(
              'Product Information',
              'We strive to provide accurate product descriptions and pricing. However, we do not warrant that product descriptions are error-free.',
            ),
            _buildSection(
              'Orders and Payment',
              'All orders are subject to acceptance and availability. We reserve the right to refuse any order.',
            ),
            _buildSection(
              'Returns and Refunds',
              'We offer a 30-day money-back guarantee on all products. Contact us for return instructions.',
            ),
            _buildSection(
              'Limitation of Liability',
              'Nova Ai Market shall not be liable for any indirect, incidental, or consequential damages arising from your use of our service.',
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
