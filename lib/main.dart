import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/theme_service.dart';

import 'screens/splash_screen_dynamic.dart';
import 'screens/login_screen_modern.dart';
import 'screens/home_screen_modern.dart';
import 'screens/landing_page_screen.dart';
import 'screens/single_product_landing.dart';
import 'screens/product_screen_modern.dart';
import 'screens/wallet_screen_modern.dart';
import 'screens/checkout_screen_modern.dart';
import 'screens/order_confirmation_screen.dart';
import 'screens/orders_screen_modern.dart';
import 'screens/admin_dashboard_screen.dart';

import 'models/product_model.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
            title: 'Store App 2025',
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
            case '/login':
              return MaterialPageRoute(
                builder: (_) => const LoginScreen(),
              );
            case '/home':
              return MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              );
            case '/product':
              final productId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => ProductScreen(productId: productId),
              );
            case '/landing':
              final product = settings.arguments as ProductModel;
              return MaterialPageRoute(
                builder: (_) => SingleProductLanding(product: product),
              );
            case '/landing-alt':
              final product = settings.arguments as ProductModel;
              return MaterialPageRoute(
                builder: (_) => LandingPageScreen(product: product),
              );
            case '/wallet':
              return MaterialPageRoute(
                builder: (_) => const WalletScreen(),
              );
            case '/checkout':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (_) => CheckoutScreen(
                  product: args['product'] as ProductModel,
                  variant: args['variant'] as ProductVariant?,
                ),
              );
            case '/order-confirmation':
              final orderId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => OrderConfirmationScreen(orderId: orderId),
              );
            case '/orders':
              return MaterialPageRoute(
                builder: (_) => const OrdersScreenModern(),
              );
            case '/admin':
              return MaterialPageRoute(
                builder: (_) => const AdminDashboardScreen(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              );
          }
        },
          );
        },
      ),
    );
  }
}
