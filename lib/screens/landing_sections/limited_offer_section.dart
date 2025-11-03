import 'package:flutter/material.dart';
import 'landing_constants.dart';

class LimitedOfferSection extends StatelessWidget {
  final Duration timeRemaining;
  final VoidCallback onBuyNow;

  const LimitedOfferSection({
    super.key,
    required this.timeRemaining,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LandingConstants.redProblem,
            const Color(0xFFDC2626),
            const Color(0xFFB91C1C),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              _buildBadge(),
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 20),
              _buildSubtitle(),
              const SizedBox(height: 50),
              _buildCountdownTimer(),
              const SizedBox(height: 50),
              _buildOfferDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.flash_on, color: LandingConstants.redProblem, size: 20),
          const SizedBox(width: 8),
          Text(
            LandingConstants.offerBadge,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: LandingConstants.redProblem,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      LandingConstants.offerTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        height: 1.1,
        letterSpacing: -1,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black26,
            blurRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      LandingConstants.offerSubtitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildOfferDetails() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LandingConstants.offerCurrency,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                LandingConstants.offerPrice,
                style: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w900,
                  color: LandingConstants.redProblem,
                  height: 0.9,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    '${LandingConstants.offerCurrency}${LandingConstants.offerOriginalPrice}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: LandingConstants.greenSolution,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      LandingConstants.offerSavePercent,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          ...LandingConstants.offerBonusItems
              .map((item) => _buildBonusItem(item, true))
              .toList(),
          const SizedBox(height: 30),
          _buildCTAButton(),
          const SizedBox(height: 16),
          Text(
            LandingConstants.offerSecureText,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTAButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onBuyNow,
        style: ElevatedButton.styleFrom(
          backgroundColor: LandingConstants.redProblem,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          shadowColor: LandingConstants.redProblem.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LandingConstants.offerButtonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownTimer() {
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes.remainder(60);
    final seconds = timeRemaining.inSeconds.remainder(60);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBox(hours.toString().padLeft(2, '0'), LandingConstants.offerTimerHours),
        const SizedBox(width: 12),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        _buildTimeBox(minutes.toString().padLeft(2, '0'), LandingConstants.offerTimerMinutes),
        const SizedBox(width: 12),
        const Text(
          ':',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        _buildTimeBox(seconds.toString().padLeft(2, '0'), LandingConstants.offerTimerSeconds),
      ],
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: LandingConstants.redProblem,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBonusItem(String text, bool included) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle : Icons.cancel,
            color: included ? LandingConstants.greenSolution : LandingConstants.redProblem,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
