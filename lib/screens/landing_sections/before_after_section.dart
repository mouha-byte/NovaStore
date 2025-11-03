import 'package:flutter/material.dart';
import 'landing_constants.dart';

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
              _buildBadge(),
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildSubtitle(),
              const SizedBox(height: 80),
              _buildBeforeAfterSlider(),
              const SizedBox(height: 60),
              _buildResultStats(),
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
          colors: [LandingConstants.pinkAccent, LandingConstants.yellowAccent],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.pinkAccent.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.compare, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            LandingConstants.beforeAfterBadge,
            style: const TextStyle(
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

  Widget _buildTitle() {
    return Text(
      LandingConstants.beforeAfterTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -1,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      LandingConstants.beforeAfterSubtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[400],
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildResultStats() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: isWide ? 60 : 30,
          runSpacing: 40,
          children: LandingConstants.resultStats
              .map((stat) => _buildResultStat(stat))
              .toList(),
        );
      },
    );
  }

  Widget _buildBeforeAfterSlider() {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.pinkAccent.withOpacity(0.3),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Before image
            Positioned.fill(
              child: Image.network(
                LandingConstants.beforeImageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[800]);
                },
              ),
            ),
            const Positioned(
              top: 20,
              left: 20,
              child: _BeforeAfterLabel('AVANT', Color(0xFFEF4444)),
            ),
            // After image
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: MediaQuery.of(context).size.width * _sliderValue,
              child: ClipRect(
                child: Image.network(
                  LandingConstants.afterImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[700]);
                  },
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Opacity(
                opacity: _sliderValue > 0.5 ? 1.0 : 0.3,
                child: const _BeforeAfterLabel('APRÈS', Color(0xFF10B981)),
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

  Widget _buildResultStat(ResultStat stat) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [LandingConstants.pinkAccent, LandingConstants.yellowAccent],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: LandingConstants.pinkAccent.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(stat.icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          stat.value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stat.label,
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
