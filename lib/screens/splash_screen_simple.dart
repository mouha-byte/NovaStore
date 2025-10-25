import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../services/firestore_service.dart';
import '../widgets/nova_store_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  int _currentStatIndex = 0;

  final List<Map<String, dynamic>> _floatingStats = [
    {'icon': Icons.people, 'text': '50K+ Happy Customers', 'color': Color(0xFF10B981)},
    {'icon': Icons.star, 'text': '4.9★ Average Rating', 'color': Color(0xFFFBBF24)},
    {'icon': Icons.local_shipping, 'text': 'Free Worldwide Shipping', 'color': Color(0xFF3B82F6)},
    {'icon': Icons.verified, 'text': '30-Day Money Back', 'color': Color(0xFF8B5CF6)},
    {'icon': Icons.flash_on, 'text': 'Lightning Fast Delivery', 'color': Color(0xFFEF4444)},
  ];

  final List<String> _customerComments = [
    '💬 "Best purchase ever!"',
    '💬 "Amazing quality!"',
    '💬 "Fast delivery!"',
    '💬 "Highly recommend!"',
    '💬 "Worth every penny!"',
    '💬 "Exceeded expectations!"',
  ];

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    
    _cycleStats();
    _initializeApp();
  }

  void _cycleStats() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        setState(() {
          _currentStatIndex = (_currentStatIndex + 1) % _floatingStats.length;
        });
        return true;
      }
      return false;
    });
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 5));
    
    if (!mounted) return;
    
    // Check if we're still on the splash screen (route is '/')
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != '/' && currentRoute != null) {
      // User has already navigated away, don't redirect
      return;
    }
    
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    
    try {
      final products = await firestoreService.getProducts().first;
      
      if (products.isNotEmpty && mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/landing',
          arguments: products.first,
        );
      } else if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF667eea),
              Color(0xFF764ba2),
              Color(0xFFf093fb),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _SimplePatternPainter(),
              ),
            ),
            
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_pulseController.value * 0.1),
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.3),
                                Colors.white.withOpacity(0.1),
                                Colors.transparent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.4 + _pulseController.value * 0.3),
                                blurRadius: 50 + (_pulseController.value * 40),
                                spreadRadius: 15 + (_pulseController.value * 15),
                              ),
                            ],
                          ),
                          child: const NovaStoreLogo(
                            size: 100,
                            showText: false,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ).animate()
                    .fadeIn(duration: 600.ms)
                    .scale(delay: 200.ms, duration: 800.ms),
                  
                  const SizedBox(height: 40),
                  
                  Text(
                    'NovaStoreAi',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ).animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(delay: 400.ms, begin: 0.3, end: 0),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    'AI-Powered Shopping Experience',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 1.2,
                    ),
                  ).animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms),
                  
                  const SizedBox(height: 40),
                  
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.3),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: ValueKey<int>(_currentStatIndex),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: _floatingStats[_currentStatIndex]['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: _floatingStats[_currentStatIndex]['color'].withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _floatingStats[_currentStatIndex]['color'].withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _floatingStats[_currentStatIndex]['icon'],
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _floatingStats[_currentStatIndex]['text'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms),
                  
                  const SizedBox(height: 40),
                  
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: AnimatedBuilder(
                      animation: _rotateController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotateController.value * 2 * math.pi,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            backgroundColor: Colors.white.withOpacity(0.3),
                          ),
                        );
                      },
                    ),
                  ).animate()
                    .fadeIn(delay: 1000.ms, duration: 600.ms)
                    .scale(delay: 1000.ms),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    'Loading your experience...',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(duration: 1000.ms)
                    .then()
                    .fadeOut(duration: 1000.ms),
                ],
              ),
            ),
            
            // ...List.generate(
            //   6,
            //   (index) => _buildFloatingComment(
            //     index,
            //     MediaQuery.of(context).size,
            //   ),
            // ),
            
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTrustBadge(Icons.verified_user, 'Secure'),
                  const SizedBox(width: 20),
                  _buildTrustBadge(Icons.local_shipping, 'Free Ship'),
                  const SizedBox(width: 20),
                  _buildTrustBadge(Icons.stars, '4.9★'),
                ],
              ),
            ).animate()
              .fadeIn(delay: 1200.ms, duration: 600.ms)
              .slideY(delay: 1200.ms, begin: 0.5, end: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingComment(int index, Size size) {
    final random = math.Random(index + 100);
    final isLeft = index % 2 == 0;
    final startX = isLeft 
        ? random.nextDouble() * size.width * 0.2 
        : size.width * 0.75 + random.nextDouble() * size.width * 0.25;
    final startY = 100.0 + random.nextDouble() * (size.height - 300);
    final duration = 4000 + random.nextInt(2000);
    final comment = _customerComments[index % _customerComments.length];
    
    return Positioned(
      left: startX,
      top: startY,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          comment,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat())
        .fadeIn(duration: 800.ms)
        .moveY(
          begin: 0,
          end: isLeft ? -60 : 60,
          duration: Duration(milliseconds: duration),
          curve: Curves.easeInOut,
        )
        .then()
        .fadeOut(duration: 800.ms),
    );
  }
}

class _SimplePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (var i = 0; i < 10; i++) {
      final path = Path();
      final startY = (size.height / 10) * i;
      
      path.moveTo(0, startY);
      
      for (var x = 0.0; x < size.width; x += 50) {
        path.lineTo(x, startY + (i % 2 == 0 ? 20 : -20));
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
