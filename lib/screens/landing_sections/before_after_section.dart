import 'package:flutter/material.dart';

class BeforeAfterSection extends StatefulWidget {
  const BeforeAfterSection({super.key});

  @override
  State<BeforeAfterSection> createState() => _BeforeAfterSectionState();
}

class _BeforeAfterSectionState extends State<BeforeAfterSection> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      color: Colors.black,
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
                    colors: [Color(0xFFEC4899), Color(0xFFF59E0B)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEC4899).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.compare, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'TRANSFORMATION',
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
                'See The Difference',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 30),
              
              Text(
                'Real results from real customers. Slide to compare.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[400],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Interactive Before/After Slider
              _buildBeforeAfterSlider(),
              
              const SizedBox(height: 60),
              
              // Results Stats
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isWide ? 60 : 30,
                    runSpacing: 40,
                    children: [
                      _buildResultStat('87%', 'Improvement', Icons.trending_up),
                      _buildResultStat('30 Days', 'Average Time', Icons.schedule),
                      _buildResultStat('10K+', 'Success Stories', Icons.people),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeforeAfterSlider() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC4899).withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Before image (full width)
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=1200&h=800&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[800]);
                },
              ),
            ),
            
            // Before label
            const Positioned(
              top: 20,
              left: 20,
              child: _BeforeAfterLabel('BEFORE', Color(0xFFEF4444)),
            ),
            
            // After image (clipped by slider)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * _sliderValue,
                child: ClipRect(
                child: Image.network(
                  'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=1200&h=800&fit=crop',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[700]);
                  },
                ),
              ),
            ),
            
            // After label
            Positioned(
              top: 20,
              right: 20,
              child: Opacity(
                opacity: _sliderValue > 0.5 ? 1.0 : 0.3,
                child: const _BeforeAfterLabel('AFTER', Color(0xFF10B981)),
              ),
            ),
            
            // Slider line
            Positioned(
              left: MediaQuery.of(context).size.width * _sliderValue - 2,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.compare_arrows,
                      color: Colors.black87,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            
            // Gesture detector
            Positioned.fill(
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _sliderValue = (details.localPosition.dx / context.size!.width).clamp(0.0, 1.0);
                  });
                },
                onTapDown: (details) {
                  setState(() {
                    _sliderValue = (details.localPosition.dx / context.size!.width).clamp(0.0, 1.0);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEC4899), Color(0xFFF59E0B)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEC4899).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}

class _BeforeAfterLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _BeforeAfterLabel(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
