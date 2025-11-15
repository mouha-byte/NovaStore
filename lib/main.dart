import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:store_app2025/screens/single_product_landing.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/theme_service.dart';

import 'screens/checkout_screen_modern.dart';

import 'screens/static pages/privacy_policy_screen.dart';
import 'screens/static pages/terms_of_service_screen.dart';
import 'screens/static pages/cookie_policy_screen.dart';
import 'screens/static pages/security_screen.dart';
import 'screens/static pages/payment_success_screen.dart';
import 'screens/static pages/payment_failed_screen.dart';
import 'screens/static pages/payment_status_screen.dart';

import 'models/product_model.dart';
import 'utils/app_theme.dart';

// Simple App Initializer Widget
class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for Firebase and Firestore initialization
    await Future.delayed(const Duration(milliseconds: 500));
    
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
      }
    } catch (e) {
      // If error, still navigate with a default product
      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          '/landing',
          arguments: ProductModel(
            id: 'default',
            title: 'Mini Mixeur Bouteille USB Portable 380ml',
            subtitle: 'Rechargeable USB - Parfait pour smoothies',
            description: 'Mixeur portable rechargeable USB avec lames en acier inoxydable',
            price: 23.0,
            compareAtPrice: 46.0,
            discountPercentage: 50,
            images: [],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Professional loading animation
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  const Color(0xFF8B5CF6),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Animated dots
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                const SizedBox(width: 8),
                _buildDot(1),
                const SizedBox(width: 8),
                _buildDot(2),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDot(int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, double value, child) {
        final delay = index * 0.2;
        final adjustedValue = (value - delay).clamp(0.0, 1.0);
        final opacity = (adjustedValue * 2).clamp(0.0, 1.0);
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF8B5CF6).withOpacity(opacity),
            shape: BoxShape.circle,
          ),
        );
      },
      onEnd: () {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable path URL strategy for clean URLs (remove # from URLs)
  if (kIsWeb) {
    usePathUrlStrategy();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
        ChangeNotifierProvider<ThemeService>(create: (_) => ThemeService()),
      ],
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Nova Ai Market',
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            darkTheme: appThemeDark,
            themeMode: themeService.themeMode,
            initialRoute: '/',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(
                    builder: (_) => const AppInitializer(),
                  );

                case '/landing':
                  final product = settings.arguments as ProductModel;
                  return MaterialPageRoute(
                    builder: (_) => SingleProductLanding(product: product),
                  );

                case '/privacy':
                  return MaterialPageRoute(
                    builder: (_) => const PrivacyPolicyScreen(),
                  );

                case '/checkout':
                  final args = settings.arguments as Map<String, dynamic>;
                  return MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      product: args['product'] as ProductModel,
                      variant: args['variant'] as ProductVariant?,
                    ),
                  );
                case '/terms':
                  return MaterialPageRoute(
                    builder: (_) => const TermsOfServiceScreen(),
                  );
                case '/cookies':
                  return MaterialPageRoute(
                    builder: (_) => const CookiePolicyScreen(),
                  );
                case '/security':
                  return MaterialPageRoute(
                    builder: (_) => const SecurityScreen(),
                  );
                case '/success':
                case '/payment-success':
                  return MaterialPageRoute(
                    builder: (_) => const PaymentSuccessScreen(),
                  );
                case '/fail':
                case '/payment-failed':
                  return MaterialPageRoute(
                    builder: (_) => const PaymentFailedScreen(),
                  );
                case '/status':
                case '/payment-status':
                  return MaterialPageRoute(
                    builder: (_) => const PaymentStatusScreen(),
                  );
                default:
                  return null;
              }
            },
          );
        },
      ),
    );
  }
}
