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

import 'screens/splash_screen_simple.dart';


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
                    builder: (_) => const SplashScreen(),
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
              }
            },
          );
        },
      ),
    );
  }
}
