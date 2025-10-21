import 'package:flutter/material.dart';

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
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF06B6D4)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'HOW IT WORKS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              const Text(
                'Simple Steps, Powerful Results',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
              
              const SizedBox(height: 30),
              
              Text(
                'Getting started is easy. Follow these simple steps.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Steps
              _buildStepsLayout(),
            ],
          ),
        ),
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
              Expanded(child: _buildStepCard(1, 'Order', 'Click the button and complete your secure checkout', Icons.shopping_cart, const Color(0xFF3B82F6))),
              _buildArrow(),
              Expanded(child: _buildStepCard(2, 'Receive', 'Get your product delivered to your door in 2-3 days', Icons.local_shipping, const Color(0xFF10B981))),
              _buildArrow(),
              Expanded(child: _buildStepCard(3, 'Enjoy', 'Start experiencing the amazing results immediately', Icons.celebration, const Color(0xFFF59E0B))),
            ],
          );
        } else {
          return Column(
            children: [
              _buildStepCard(1, 'Order', 'Click the button and complete your secure checkout', Icons.shopping_cart, const Color(0xFF3B82F6)),
              _buildVerticalArrow(),
              _buildStepCard(2, 'Receive', 'Get your product delivered to your door in 2-3 days', Icons.local_shipping, const Color(0xFF10B981)),
              _buildVerticalArrow(),
              _buildStepCard(3, 'Enjoy', 'Start experiencing the amazing results immediately', Icons.celebration, const Color(0xFFF59E0B)),
            ],
          );
        }
      },
    );
  }

  Widget _buildStepCard(int number, String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Number badge
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40, color: color),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Text(
            description,
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
      child: Icon(
        Icons.arrow_forward,
        size: 32,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildVerticalArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Icon(
        Icons.arrow_downward,
        size: 32,
        color: Colors.grey[400],
      ),
    );
  }
}
