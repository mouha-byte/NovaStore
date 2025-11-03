import 'package:flutter/material.dart';
import 'landing_constants.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildBadge(),
              const SizedBox(height: 40),
              Text(
                LandingConstants.howItWorksTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                LandingConstants.howItWorksDescription,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 80),
              _buildStepsLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [LandingConstants.blue, Color(0xFF06B6D4)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: Colors.white, size: 20),
          SizedBox(width: 10),
          Text(
            LandingConstants.howItWorksBadge,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        if (isWide) {
          return Row(
            children: [
              for (int i = 0; i < LandingConstants.howItWorksSteps.length; i++) ...[
                Expanded(
                  child: _buildStepCard(LandingConstants.howItWorksSteps[i]),
                ),
                if (i < LandingConstants.howItWorksSteps.length - 1)
                  _buildArrow(),
              ],
            ],
          );
        } else {
          return Column(
            children: [
              for (int i = 0; i < LandingConstants.howItWorksSteps.length; i++) ...[
                _buildStepCard(LandingConstants.howItWorksSteps[i]),
                if (i < LandingConstants.howItWorksSteps.length - 1)
                  _buildVerticalArrow(),
              ],
            ],
          );
        }
      },
    );
  }

  Widget _buildStepCard(HowItWorksStep step) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: step.color.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: step.color.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [step.color, step.color.withOpacity(0.7)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: step.color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${step.number}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: step.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(step.icon, size: 40, color: step.color),
          ),
          const SizedBox(height: 20),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Icon(Icons.arrow_forward, size: 32, color: Colors.grey[400]),
    );
  }

  Widget _buildVerticalArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Icon(Icons.arrow_downward, size: 32, color: Colors.grey[400]),
    );
  }
}

