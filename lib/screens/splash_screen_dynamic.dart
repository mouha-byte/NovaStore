import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../widgets/nova_store_logo.dart';
import '../services/firestore_service.dart';
import 'dart:math' as math;

/// Ultra Modern Splash Screen with Product Showcase & Social Proof
/// Features product photos, happy customer imagery, and dynamic animations
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _productCarouselController;
  int _currentStat = 0;
  int _currentTestimonial = 0;
  
  final List<Map<String, String>> _dynamicStats = [
    {'number': '50K+', 'label': 'Happy Customers'},
    {'number': '4.9★', 'label': 'Average Rating'},
    {'number': '99%', 'label': 'Satisfaction Rate'},
    {'number': '24/7', 'label': 'Support Available'},
  ];

  final List<Map<String, String>> _testimonials = [
    {'quote': '"Amazing quality! Worth every penny"', 'name': 'Sarah M.', 'emoji': '😊'},
    {'quote': '"Fast delivery, excellent service!"', 'name': 'John D.', 'emoji': '😃'},
    {'quote': '"Best shopping experience ever"', 'name': 'Emma L.', 'emoji': '🥰'},
    {'quote': '"Absolutely love my purchase!"', 'name': 'Mike R.', 'emoji': '😍'},
  ];

  // Happy customer emojis for avatars
  final List<String> _customerEmojis = ['😊', '😃', '🥰', '😍', '🤩', '😎', '🙂', '😌'];

  // Real photos of happy customers using products
  final List<Map<String, String>> _customerPhotos = [
    {'url': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop', 'name': 'Alex M.'},
    {'url': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&h=300&fit=crop', 'name': 'Sarah J.'},
    {'url': 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=300&h=300&fit=crop', 'name': 'Mike R.'},
    {'url': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=300&h=300&fit=crop', 'name': 'Emma L.'},
    {'url': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&h=300&fit=crop', 'name': 'John D.'},
    {'url': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300&h=300&fit=crop', 'name': 'Lisa K.'},
    {'url': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&h=300&fit=crop', 'name': 'Chris B.'},
    {'url': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&h=300&fit=crop', 'name': 'Anna W.'},
  ];

  // Photos of people using/enjoying products (lifestyle shots)
  final List<Map<String, String>> _lifestylePhotos = [
    {'url': 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=400&h=300&fit=crop', 'caption': 'Shopping with style'},
    {'url': 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=400&h=300&fit=crop', 'caption': 'Unboxing happiness'},
    {'url': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&h=300&fit=crop', 'caption': 'Perfect purchases'},
    {'url': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=400&h=300&fit=crop', 'caption': 'Quality products'},
    {'url': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=400&h=300&fit=crop', 'caption': 'Team satisfaction'},
    {'url': 'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400&h=300&fit=crop', 'caption': 'Office favorites'},
  ];

  // Product images - replace with your actual product URLs from Firestore
  final List<String> _featuredProducts = [
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400', // Watch
    'https://images.unsplash.com/photo-1572635196237-14b3f281503f?w=400', // Sunglasses
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400', // Headphones
    'https://images.unsplash.com/photo-1560343090-f0409e92791a?w=400', // Sneakers
    'https://images.unsplash.com/photo-1491553895911-0055eca6402d?w=400', // Sneakers
    'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400', // Backpack
  ];

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
    
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    
    _productCarouselController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    )..repeat();
    
    _cycleStats();
    _cycleTestimonials();
    _initializeApp();
  }

  void _cycleStats() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) {
        setState(() {
          _currentStat = (_currentStat + 1) % _dynamicStats.length;
        });
        return true;
      }
      return false;
    });
  }

  void _cycleTestimonials() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 3000));
      if (mounted) {
        setState(() {
          _currentTestimonial = (_currentTestimonial + 1) % _testimonials.length;
        });
        return true;
      }
      return false;
    });
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 10));
    
    if (!mounted) return;
    
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
    _productCarouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.shortestSide >= 600;
    final isMobile = size.width < 600;
    
    return Scaffold(
      body: Stack(
        children: [
          // Premium Gradient Background
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF667eea),
                  const Color(0xFF764ba2),
                  const Color(0xFFf093fb),
                  const Color(0xFFffd6a5),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),
          
          // Animated Background Pattern
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _rotateController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _DynamicBackgroundPainter(_rotateController.value),
                );
              },
            ),
          ),
          
          // Floating Product Images (Background)
          ...List.generate(isMobile ? 3 : 6, (index) => _buildFloatingProductImage(index, size)),
          
          // Happy Customer Avatars (Floating) - with real photos
          ...List.generate(isMobile ? 6 : 12, (index) => _buildFloatingAvatar(index, size)),
          
          // Floating Lifestyle Photos (People using products)
          ...List.generate(isMobile ? 2 : 4, (index) => _buildFloatingLifestyleCard(index, size)),
          
          // Main Content
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    
                    // Animated Logo with Enhanced Glow
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_pulseController.value * 0.1),
                          child: Container(
                            padding: EdgeInsets.all(isTablet ? 40 : 30),
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
                            child: NovaStoreLogo(
                              size: isTablet ? 120 : (isMobile ? 80 : 100),
                              showText: false,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ).animate()
                      .fadeIn(duration: 600.ms)
                      .scale(delay: 200.ms, duration: 800.ms, begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
                    
                    SizedBox(height: isTablet ? 50 : 30),
                    
                    // Brand Name with Enhanced Styling
                    Text(
                      'NovaStoreAi',
                      style: TextStyle(
                        fontSize: isTablet ? 64 : (isMobile ? 40 : 52),
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -1.5,
                        shadows: const [
                          Shadow(
                            color: Colors.black38,
                            blurRadius: 25,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(delay: 400.ms, begin: 0.3, end: 0)
                      .shimmer(delay: 1000.ms, duration: 2000.ms, color: Colors.white70),
                    
                    SizedBox(height: isTablet ? 16 : 12),
                    
                    // Enhanced Tagline
                    Text(
                      'AI-Powered Shopping Experience',
                      style: TextStyle(
                        fontSize: isTablet ? 22 : (isMobile ? 14 : 18),
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ).animate()
                      .fadeIn(delay: 800.ms, duration: 600.ms)
                      .slideY(delay: 800.ms, begin: 0.2, end: 0),
                    
                    SizedBox(height: isTablet ? 60 : 40),
                    
                    // Featured Products Carousel
                    SizedBox(
                      height: isTablet ? 100 : (isMobile ? 60 : 80),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                        itemCount: _featuredProducts.length * 100,
                        itemBuilder: (context, index) {
                          final productIndex = index % _featuredProducts.length;
                          final itemSize = isTablet ? 100.0 : (isMobile ? 60.0 : 80.0);
                          return Container(
                            width: itemSize,
                            height: itemSize,
                            margin: EdgeInsets.only(right: isMobile ? 8 : 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
                              border: Border.all(color: Colors.white, width: isMobile ? 2 : 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(isTablet ? 17 : 13),
                              child: Image.network(
                                _featuredProducts[productIndex],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.white.withOpacity(0.2),
                                    child: Icon(Icons.shopping_bag, color: Colors.white, size: itemSize * 0.4),
                                  );
                                },
                              ),
                            ),
                          ).animate()
                            .fadeIn(delay: (1400 + productIndex * 100).ms, duration: 600.ms)
                            .scale(delay: (1400 + productIndex * 100).ms);
                        },
                      ),
                    ),
                    
                    SizedBox(height: isTablet ? 50 : 30),
                    
                    // Happy Customers Wall
                    Container(
                      constraints: BoxConstraints(maxWidth: isTablet ? 700 : 500),
                      child: Column(
                        children: [
                          Text(
                            'Join 50,000+ Happy Customers',
                            style: TextStyle(
                              fontSize: isTablet ? 20 : (isMobile ? 14 : 16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: isTablet ? 60 : (isMobile ? 40 : 50),
                            child: Stack(
                              alignment: Alignment.center,
                              children: List.generate(
                                math.min(8, _customerPhotos.length),
                                (index) {
                                  final offset = (index - 3.5) * (isMobile ? 35 : 45);
                                  final scale = 1.0 - (index - 3.5).abs() * 0.08;
                                  return Transform.translate(
                                    offset: Offset(offset, 0),
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Container(
                                        width: isTablet ? 60 : (isMobile ? 40 : 50),
                                        height: isTablet ? 60 : (isMobile ? 40 : 50),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 3),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: Image.network(
                                            _customerPhotos[index]['url']!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: Colors.white.withOpacity(0.3),
                                                child: Center(
                                                  child: Text(
                                                    _customerEmojis[index % _customerEmojis.length],
                                                    style: TextStyle(fontSize: (isTablet ? 60 : (isMobile ? 40 : 50)) * 0.4),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ).animate(delay: Duration(milliseconds: 1600 + index * 100))
                                    .fadeIn(duration: 400.ms)
                                    .scale(begin: const Offset(0.5, 0.5));
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(5, (i) => Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: isTablet ? 20 : (isMobile ? 14 : 16),
                              )),
                              SizedBox(width: isMobile ? 6 : 8),
                              Text(
                                '4.9 out of 5',
                                style: TextStyle(
                                  fontSize: isTablet ? 16 : (isMobile ? 12 : 14),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ).animate(delay: 2000.ms).fadeIn().slideX(begin: -0.3, end: 0),
                        ],
                      ),
                    ).animate()
                      .fadeIn(delay: 1400.ms, duration: 600.ms),
                    
                    SizedBox(height: isTablet ? 40 : 24),
                    
                    // Customer Testimonial Carousel with Real Photos
                    Container(
                      constraints: BoxConstraints(maxWidth: isTablet ? 600 : 400),
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 30),
                      child: AnimatedSwitcher(
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
                          key: ValueKey<int>(_currentTestimonial),
                          padding: EdgeInsets.all(isMobile ? 16 : 20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                          ),
                          child: Row(
                            children: [
                              // Real Customer Photo
                              Container(
                                width: isTablet ? 50 : (isMobile ? 35 : 40),
                                height: isTablet ? 50 : (isMobile ? 35 : 40),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        _customerPhotos[_currentTestimonial % _customerPhotos.length]['url']!,
                                        fit: BoxFit.cover,
                                        width: isTablet ? 50 : (isMobile ? 35 : 40),
                                        height: isTablet ? 50 : (isMobile ? 35 : 40),
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.white.withOpacity(0.3),
                                            child: Center(
                                              child: Text(
                                                _testimonials[_currentTestimonial]['emoji']!,
                                                style: TextStyle(fontSize: isTablet ? 24 : (isMobile ? 18 : 20)),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Verified badge
                                    Positioned(
                                      bottom: -2,
                                      right: -2,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF10B981),
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 1.5),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: isMobile ? 8 : 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: isMobile ? 12 : 15),
                              // Testimonial Text
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _testimonials[_currentTestimonial]['quote']!,
                                      style: TextStyle(
                                        fontSize: isTablet ? 16 : (isMobile ? 11 : 13),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _testimonials[_currentTestimonial]['name']!,
                                      style: TextStyle(
                                        fontSize: isTablet ? 13 : (isMobile ? 10 : 11),
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Star Rating
                              Row(
                                children: List.generate(5, (index) => 
                                  Icon(Icons.star, color: Colors.amber, size: isTablet ? 16 : (isMobile ? 12 : 14))
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ).animate()
                      .fadeIn(delay: 1600.ms, duration: 600.ms),
                    
                    SizedBox(height: isTablet ? 40 : 24),
                    
                    // Live Purchases Notification
                    Container(
                      constraints: BoxConstraints(maxWidth: isTablet ? 400 : 320),
                      padding: EdgeInsets.all(isMobile ? 10 : 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF10B981), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF10B981).withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: isTablet ? 40 : (isMobile ? 30 : 35),
                            height: isTablet ? 40 : (isMobile ? 30 : 35),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                _customerPhotos[(_currentStat + 2) % _customerPhotos.length]['url']!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.white.withOpacity(0.3),
                                    child: const Icon(Icons.person, color: Colors.white, size: 20),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: isMobile ? 10 : 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: isMobile ? 6 : 8,
                                      height: isMobile ? 6 : 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF10B981),
                                        shape: BoxShape.circle,
                                      ),
                                    ).animate(onPlay: (controller) => controller.repeat())
                                      .fadeOut(duration: 800.ms)
                                      .then()
                                      .fadeIn(duration: 800.ms),
                                    SizedBox(width: isMobile ? 4 : 6),
                                    Text(
                                      'Just purchased!',
                                      style: TextStyle(
                                        fontSize: isTablet ? 13 : (isMobile ? 10 : 11),
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF10B981),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: isMobile ? 2 : 4),
                                Text(
                                  '${_customerPhotos[(_currentStat + 2) % _customerPhotos.length]['name']} from ${['New York', 'London', 'Tokyo', 'Paris', 'Sydney'][_currentStat % 5]}',
                                  style: TextStyle(
                                    fontSize: isTablet ? 12 : (isMobile ? 9 : 10),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: isTablet ? 24 : (isMobile ? 18 : 20),
                          ),
                        ],
                      ),
                    ).animate()
                      .fadeIn(delay: 2200.ms, duration: 600.ms)
                      .slideX(delay: 2200.ms, begin: -0.3, end: 0),
                    
                    SizedBox(height: isTablet ? 40 : 24),
                    
                    // Dynamic Stats Counter
                    Container(
                      constraints: BoxConstraints(maxWidth: isTablet ? 300 : 250),
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 30 : 40, 
                        vertical: isMobile ? 16 : 20
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 25,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: AnimatedSwitcher(
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
                        child: Column(
                          key: ValueKey<int>(_currentStat),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _dynamicStats[_currentStat]['number']!,
                              style: TextStyle(
                                fontSize: isTablet ? 52 : (isMobile ? 36 : 44),
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _dynamicStats[_currentStat]['label']!,
                              style: TextStyle(
                                fontSize: isTablet ? 16 : (isMobile ? 12 : 14),
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.95),
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ).animate()
                      .fadeIn(delay: 1200.ms, duration: 600.ms)
                      .scale(delay: 1200.ms, begin: const Offset(0.8, 0.8)),
                    
                    SizedBox(height: isTablet ? 60 : 40),
                    
                    // Loading Animation
                    Column(
                      children: [
                        SizedBox(
                          width: isTablet ? 60 : (isMobile ? 40 : 50),
                          height: isTablet ? 60 : (isMobile ? 40 : 50),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: isTablet ? 60 : (isMobile ? 40 : 50),
                                height: isTablet ? 60 : (isMobile ? 40 : 50),
                                child: CircularProgressIndicator(
                                  strokeWidth: isMobile ? 2 : 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.3)),
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _rotateController,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _rotateController.value * 2 * math.pi,
                                    child: SizedBox(
                                      width: isTablet ? 60 : (isMobile ? 40 : 50),
                                      height: isTablet ? 60 : (isMobile ? 40 : 50),
                                      child: CircularProgressIndicator(
                                        strokeWidth: isMobile ? 3 : 4,
                                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                        value: 0.7,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Preparing your shopping experience...',
                          style: TextStyle(
                            fontSize: isTablet ? 16 : (isMobile ? 12 : 14),
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ).animate(onPlay: (controller) => controller.repeat())
                          .fadeIn(duration: 1000.ms)
                          .then()
                          .fadeOut(duration: 1000.ms),
                      ],
                    ).animate()
                      .fadeIn(delay: 1800.ms, duration: 600.ms),
                    
                    SizedBox(height: size.height * 0.05),
                  ],
                ),
              ),
            ),
          ),
          
          // Enhanced Trust Badges
          Positioned(
            bottom: isMobile ? 20 : 40,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTrustBadge(Icons.verified_user, 'Secure', Colors.green, isMobile),
                  SizedBox(width: isMobile ? 12 : 20),
                  _buildTrustBadge(Icons.local_shipping, 'Free Ship', Colors.blue, isMobile),
                  SizedBox(width: isMobile ? 12 : 20),
                  _buildTrustBadge(Icons.support_agent, '24/7', Colors.purple, isMobile),
                  SizedBox(width: isMobile ? 12 : 20),
                  _buildTrustBadge(Icons.stars, '4.9★', Colors.amber, isMobile),
                ],
              ),
            ).animate()
              .fadeIn(delay: 2000.ms, duration: 600.ms)
              .slideY(delay: 2000.ms, begin: 0.5, end: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildTrustBadge(IconData icon, String label, Color accentColor, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 12, 
        vertical: isMobile ? 6 : 8
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: isMobile ? 14 : 16),
          SizedBox(width: isMobile ? 4 : 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 10 : 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingProductImage(int index, Size size) {
    final random = math.Random(index + 100);
    final isLeft = index % 2 == 0;
    final isMobile = size.width < 600;
    final startX = isLeft ? random.nextDouble() * size.width * 0.15 : size.width * 0.85 + random.nextDouble() * size.width * 0.15;
    final startY = 100.0 + random.nextDouble() * (size.height - 200);
    final duration = 4000 + random.nextInt(2000);
    final imageSize = isMobile ? 50.0 : 60.0;
    
    return Positioned(
      left: startX,
      top: startY,
      child: Container(
        width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            _featuredProducts[index % _featuredProducts.length],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.white.withOpacity(0.2),
                child: Icon(Icons.inventory_2, color: Colors.white, size: imageSize * 0.4),
              );
            },
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat())
        .moveY(
          begin: 0,
          end: isLeft ? -80 : 80,
          duration: Duration(milliseconds: duration),
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: 800.ms)
        .then()
        .fadeOut(duration: 800.ms),
    );
  }

  Widget _buildFloatingAvatar(int index, Size size) {
    final random = math.Random(index + 200);
    final isMobile = size.width < 600;
    final startX = random.nextDouble() * size.width;
    final startY = random.nextDouble() * size.height;
    final duration = 5000 + random.nextInt(3000);
    final avatarSize = (isMobile ? 40.0 : 50.0) + random.nextDouble() * (isMobile ? 15 : 20);
    
    final customerIndex = index % _customerPhotos.length;
    final customer = _customerPhotos[customerIndex];
    
    return Positioned(
      left: startX,
      top: startY,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 3,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipOval(
              child: Image.network(
                customer['url']!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: avatarSize,
                    height: avatarSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Text(
                        _customerEmojis[customerIndex % _customerEmojis.length],
                        style: TextStyle(fontSize: avatarSize * 0.5),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Verified badge
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: avatarSize * 0.25,
                ),
              ),
            ),
          ],
        ),
      ).animate(onPlay: (controller) => controller.repeat())
        .moveY(
          begin: 0,
          end: -60 - random.nextDouble() * 80,
          duration: Duration(milliseconds: duration),
          curve: Curves.easeInOut,
        )
        .fadeOut(duration: Duration(milliseconds: duration ~/ 2)),
    );
  }

  Widget _buildFloatingLifestyleCard(int index, Size size) {
    final random = math.Random(index + 300);
    final isMobile = size.width < 600;
    final isLeft = index % 2 == 0;
    final startX = isLeft ? 20.0 + random.nextDouble() * size.width * 0.1 : size.width * 0.75 + random.nextDouble() * size.width * 0.15;
    final startY = 150.0 + random.nextDouble() * (size.height - 400);
    final duration = 6000 + random.nextInt(2000);
    final cardWidth = isMobile ? 120.0 : 160.0;
    final cardHeight = isMobile ? 90.0 : 120.0;
    
    final lifestyleIndex = index % _lifestylePhotos.length;
    final lifestyle = _lifestylePhotos[lifestyleIndex];
    
    return Positioned(
      left: startX,
      top: startY,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(13),
          child: Stack(
            children: [
              Image.network(
                lifestyle['url']!,
                width: cardWidth,
                height: cardHeight,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white.withOpacity(0.2),
                    child: Center(
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: cardWidth * 0.3,
                      ),
                    ),
                  );
                },
              ),
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Caption
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lifestyle['caption']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 9 : 11,
                        fontWeight: FontWeight.w700,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: isMobile ? 8 : 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Verified badge
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 6, vertical: isMobile ? 2 : 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: isMobile ? 8 : 10,
                      ),
                      SizedBox(width: isMobile ? 2 : 3),
                      Text(
                        'REAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 7 : 8,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat())
        .moveY(
          begin: 0,
          end: isLeft ? -100 : 100,
          duration: Duration(milliseconds: duration),
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: 1000.ms)
        .then()
        .fadeOut(duration: 1000.ms),
    );
  }
}

// Custom Painter for Dynamic Background
class _DynamicBackgroundPainter extends CustomPainter {
  final double animationValue;
  
  _DynamicBackgroundPainter(this.animationValue);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    // Animated expanding circles
    for (var i = 0; i < 5; i++) {
      final progress = (animationValue + i / 5) % 1.0;
      final radius = progress * size.width * 0.8;
      
      paint.color = Colors.white.withOpacity(0.06 * (1 - progress));
      
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        radius,
        paint,
      );
    }
    
    // Rotating radial lines
    paint.strokeWidth = 1.5;
    for (var i = 0; i < 12; i++) {
      final angle = (animationValue * 2 * math.pi) + (i * math.pi / 6);
      final x1 = size.width / 2 + math.cos(angle) * 80;
      final y1 = size.height / 2 + math.sin(angle) * 80;
      final x2 = size.width / 2 + math.cos(angle) * size.width * 0.5;
      final y2 = size.height / 2 + math.sin(angle) * size.height * 0.5;
      
      paint.color = Colors.white.withOpacity(0.12);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
    
    // Subtle grid pattern
    paint.strokeWidth = 0.5;
    paint.color = Colors.white.withOpacity(0.04);
    
    for (var x = 0.0; x < size.width; x += 50) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    for (var y = 0.0; y < size.height; y += 50) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(_DynamicBackgroundPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}