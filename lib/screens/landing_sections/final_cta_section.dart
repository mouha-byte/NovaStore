import 'package:flutter/material.dart';
import 'landing_constants.dart';

class FinalCTASection extends StatelessWidget {
  final VoidCallback onBuyNow;

  const FinalCTASection({
    super.key,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF0F172A),
            Color(0xFF020617),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              _buildIcon(),
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildSubtitle(),
              const SizedBox(height: 60),
              _buildCTAButton(),
              const SizedBox(height: 24),
              _buildTrustBadges(),
              const SizedBox(height: 60),
              _buildBenefitsGrid(),
              const SizedBox(height: 60),
              _buildSocialProof(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [LandingConstants.secondaryColor, LandingConstants.pinkAccent],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: LandingConstants.secondaryColor.withOpacity(0.5),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: const Icon(
        Icons.rocket_launch,
        color: Colors.white,
        size: 48,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      LandingConstants.finalCTATitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        height: 1.1,
        letterSpacing: -1,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      LandingConstants.finalCTASubtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[400],
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildCTAButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onBuyNow,
        style: ElevatedButton.styleFrom(
          backgroundColor: LandingConstants.pinkAccent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 28),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 12,
          shadowColor: LandingConstants.pinkAccent.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LandingConstants.finalCTAButton,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.arrow_forward, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Text(
          LandingConstants.finalCTASecureCheckout,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 20),
        const Icon(Icons.verified_user, color: Colors.white70, size: 16),
        const SizedBox(width: 8),
        Text(
          LandingConstants.finalCTAGuarantee,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: isWide ? 40 : 20,
          runSpacing: 30,
          children: LandingConstants.finalCTABenefits
              .map((benefit) => _buildBenefitItem(benefit.icon, benefit.label))
              .toList(),
        );
      },
    );
  }

  Widget _buildSocialProof() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: LandingConstants.yellowAccent,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            LandingConstants.finalCTARating,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            LandingConstants.finalCTAReviewCount,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: LandingConstants.pinkAccent,
            size: 32,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
