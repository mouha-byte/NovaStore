import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class NovaStoreLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final Color? color;

  const NovaStoreLogo({
    super.key,
    this.size = 40,
    this.showText = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = color ?? (isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Icon with gradient
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                isDark ? AppColorsDark.primary : AppColorsLight.primary,
                isDark ? AppColorsDark.secondary : AppColorsLight.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(size * 0.2),
            boxShadow: [
              BoxShadow(
                color: (isDark ? AppColorsDark.primary : AppColorsLight.primary).withOpacity(0.3),
                blurRadius: size * 0.3,
                offset: Offset(0, size * 0.1),
              ),
            ],
          ),
          child: Stack(
            children: [
              // AI Circuit pattern
              CustomPaint(
                size: Size(size, size),
                painter: _CircuitPainter(color: Colors.white.withOpacity(0.2)),
              ),
              
              // Nova Star
              Center(
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: size * 0.5,
                ),
              ),
            ],
          ),
        ),
        
        if (showText) ...[
          SizedBox(width: size * 0.2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nova',
                style: TextStyle(
                  fontSize: size * 0.5,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  height: 1,
                  letterSpacing: -0.5,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Store',
                    style: TextStyle(
                      fontSize: size * 0.35,
                      fontWeight: FontWeight.w600,
                      color: textColor.withOpacity(0.8),
                      height: 1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size * 0.1),
                    padding: EdgeInsets.symmetric(
                      horizontal: size * 0.1,
                      vertical: size * 0.05,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          isDark ? AppColorsDark.secondary : AppColorsLight.secondary,
                          isDark ? AppColorsDark.primary : AppColorsLight.primary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(size * 0.1),
                    ),
                    child: Text(
                      'AI',
                      style: TextStyle(
                        fontSize: size * 0.25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// Logo Icon Only (for AppBar, etc)
class NovaStoreIcon extends StatelessWidget {
  final double size;
  
  const NovaStoreIcon({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return NovaStoreLogo(size: size, showText: false);
  }
}

// Custom painter for circuit pattern
class _CircuitPainter extends CustomPainter {
  final Color color;

  _CircuitPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    
    // Create circuit-like pattern
    final w = size.width;
    final h = size.height;
    
    // Horizontal lines
    path.moveTo(w * 0.2, h * 0.3);
    path.lineTo(w * 0.8, h * 0.3);
    
    path.moveTo(w * 0.2, h * 0.7);
    path.lineTo(w * 0.8, h * 0.7);
    
    // Vertical lines
    path.moveTo(w * 0.3, h * 0.2);
    path.lineTo(w * 0.3, h * 0.8);
    
    path.moveTo(w * 0.7, h * 0.2);
    path.lineTo(w * 0.7, h * 0.8);
    
    // Dots at intersections
    canvas.drawCircle(Offset(w * 0.3, h * 0.3), 2, Paint()..color = color..style = PaintingStyle.fill);
    canvas.drawCircle(Offset(w * 0.7, h * 0.3), 2, Paint()..color = color..style = PaintingStyle.fill);
    canvas.drawCircle(Offset(w * 0.3, h * 0.7), 2, Paint()..color = color..style = PaintingStyle.fill);
    canvas.drawCircle(Offset(w * 0.7, h * 0.7), 2, Paint()..color = color..style = PaintingStyle.fill);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Large logo for splash screen
class NovaStoreLogoLarge extends StatelessWidget {
  const NovaStoreLogoLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NovaStoreLogo(size: 120, showText: false),
        const SizedBox(height: 24),
        const NovaStoreLogo(size: 60, showText: true),
        const SizedBox(height: 8),
        Text(
          AppConstants.tagline,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
