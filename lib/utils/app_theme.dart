import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =========================
// COULEURS LIGHT MODE
// =========================
class AppColorsLight {
  // Primary - Gradient moderne
  static const primary = Color(0xFF6366F1); // Indigo
  static const primaryDark = Color(0xFF4F46E5);
  static const primaryLight = Color(0xFF818CF8);
  
  // Secondary - Accent
  static const secondary = Color(0xFFEC4899); // Pink
  static const secondaryDark = Color(0xFFDB2777);
  
  // Success / Error
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);
  
  // Neutral
  static const background = Color(0xFFFAFAFA);
  static const surface = Colors.white;
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE5E7EB);
  static const divider = Color(0xFFF3F4F6);
  
  // Gradient
  static const gradientStart = Color(0xFF6366F1);
  static const gradientEnd = Color(0xFFEC4899);
  
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get darkGradient => LinearGradient(
    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

// =========================
// COULEURS DARK MODE
// =========================
class AppColorsDark {
  // Primary - Gradient moderne (plus clair en dark mode)
  static const primary = Color(0xFF818CF8); // Indigo Light
  static const primaryDark = Color(0xFF6366F1);
  static const primaryLight = Color(0xFFA5B4FC);
  
  // Secondary - Accent
  static const secondary = Color(0xFFF472B6); // Pink Light
  static const secondaryDark = Color(0xFFEC4899);
  
  // Success / Error
  static const success = Color(0xFF34D399);
  static const error = Color(0xFFF87171);
  static const warning = Color(0xFFFBBF24);
  static const info = Color(0xFF60A5FA);
  
  // Neutral
  static const background = Color(0xFF0F172A); // Slate 900
  static const surface = Color(0xFF1E293B); // Slate 800
  static const surfaceLight = Color(0xFF334155); // Slate 700
  static const textPrimary = Color(0xFFF1F5F9); // Slate 100
  static const textSecondary = Color(0xFF94A3B8); // Slate 400
  static const border = Color(0xFF334155); // Slate 700
  static const divider = Color(0xFF1E293B);
  
  // Gradient
  static const gradientStart = Color(0xFF818CF8);
  static const gradientEnd = Color(0xFFF472B6);
  
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient get darkGradient => LinearGradient(
    colors: [Colors.black.withOpacity(0.9), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}

// =========================
// COULEURS (Backward compatibility)
// =========================
class AppColors {
  static const primary = AppColorsLight.primary;
  static const primaryDark = AppColorsLight.primaryDark;
  static const primaryLight = AppColorsLight.primaryLight;
  static const secondary = AppColorsLight.secondary;
  static const secondaryDark = AppColorsLight.secondaryDark;
  static const success = AppColorsLight.success;
  static const error = AppColorsLight.error;
  static const warning = AppColorsLight.warning;
  static const info = AppColorsLight.info;
  static const background = AppColorsLight.background;
  static const surface = AppColorsLight.surface;
  static const textPrimary = AppColorsLight.textPrimary;
  static const textSecondary = AppColorsLight.textSecondary;
  static const border = AppColorsLight.border;
  static const divider = AppColorsLight.divider;
  static const gradientStart = AppColorsLight.gradientStart;
  static const gradientEnd = AppColorsLight.gradientEnd;
  
  static LinearGradient get primaryGradient => AppColorsLight.primaryGradient;
  static LinearGradient get darkGradient => AppColorsLight.darkGradient;
}

// =========================
// TYPOGRAPHIE
// =========================
class AppTypography {
  static TextTheme get textTheme => TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 48,
      fontWeight: FontWeight.w900,
      letterSpacing: -1.5,
      color: AppColors.textPrimary,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 36,
      fontWeight: FontWeight.w800,
      letterSpacing: -1,
      color: AppColors.textPrimary,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: AppColors.textPrimary,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimary,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: Colors.white,
    ),
  );
}

// =========================
// RESPONSIVE BREAKPOINTS
// =========================
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double wide = 1600;
  
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobile;
  
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobile &&
      MediaQuery.of(context).size.width < desktop;
  
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;
  
  static double getMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobile) return width;
    if (width < tablet) return 600;
    if (width < desktop) return 900;
    if (width < wide) return 1200;
    return 1400;
  }
}

// =========================
// SPACING
// =========================
class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

// =========================
// BORDER RADIUS
// =========================
class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
  
  static BorderRadius get circular8 => BorderRadius.circular(sm);
  static BorderRadius get circular12 => BorderRadius.circular(md);
  static BorderRadius get circular16 => BorderRadius.circular(lg);
  static BorderRadius get circular24 => BorderRadius.circular(xl);
}

// =========================
// SHADOWS
// =========================
class AppShadows {
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get xl => [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];
}

// =========================
// ANIMATIONS
// =========================
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
}

// =========================
// THEME DATA - LIGHT MODE
// =========================
ThemeData get appTheme => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColorsLight.primary,
    primary: AppColorsLight.primary,
    secondary: AppColorsLight.secondary,
    surface: AppColorsLight.surface,
    error: AppColorsLight.error,
    brightness: Brightness.light,
  ),
  textTheme: AppTypography.textTheme,
  scaffoldBackgroundColor: AppColorsLight.background,
  
  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: AppColorsLight.textPrimary),
    titleTextStyle: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColorsLight.textPrimary,
    ),
  ),
  
  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsLight.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.circular12,
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  
  // Input
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsLight.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsLight.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsLight.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsLight.error),
    ),
    labelStyle: GoogleFonts.inter(
      color: AppColorsLight.textSecondary,
    ),
  ),
  
  // Card
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.circular16,
      side: const BorderSide(color: AppColorsLight.border, width: 1),
    ),
    color: Colors.white,
  ),
);

// =========================
// THEME DATA - DARK MODE
// =========================
ThemeData get appThemeDark => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColorsDark.primary,
    primary: AppColorsDark.primary,
    secondary: AppColorsDark.secondary,
    surface: AppColorsDark.surface,
    error: AppColorsDark.error,
    brightness: Brightness.dark,
  ),
  textTheme: _darkTextTheme,
  scaffoldBackgroundColor: AppColorsDark.background,
  
  // AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: AppColorsDark.surface,
    elevation: 0,
    centerTitle: false,
    iconTheme: const IconThemeData(color: AppColorsDark.textPrimary),
    titleTextStyle: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColorsDark.textPrimary,
    ),
  ),
  
  // Button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColorsDark.primary,
      foregroundColor: AppColorsDark.background,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.circular12,
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  
  // Input
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColorsDark.surface,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.md,
    ),
    border: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsDark.border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsDark.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsDark.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: AppRadius.circular12,
      borderSide: const BorderSide(color: AppColorsDark.error),
    ),
    labelStyle: GoogleFonts.inter(
      color: AppColorsDark.textSecondary,
    ),
  ),
  
  // Card
  cardTheme: CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.circular16,
      side: const BorderSide(color: AppColorsDark.border, width: 1),
    ),
    color: AppColorsDark.surface,
  ),
);

// Dark Text Theme
TextTheme get _darkTextTheme => TextTheme(
  displayLarge: GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
    color: AppColorsDark.textPrimary,
  ),
  displayMedium: GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    color: AppColorsDark.textPrimary,
  ),
  displaySmall: GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    color: AppColorsDark.textPrimary,
  ),
  headlineMedium: GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColorsDark.textPrimary,
  ),
  headlineSmall: GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColorsDark.textPrimary,
  ),
  titleLarge: GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColorsDark.textPrimary,
  ),
  titleMedium: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColorsDark.textPrimary,
  ),
  bodyLarge: GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColorsDark.textPrimary,
  ),
  bodyMedium: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColorsDark.textSecondary,
  ),
  labelLarge: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColorsDark.textPrimary,
  ),
);

// =========================
// CONSTANTES APP
// =========================
class AppConstants {
  // Winning Product ID (à configurer)
  static const String winningProductId = 'WINNING_PRODUCT_ID';
  
  // Payeer
  static const String payeerMerchantId = 'YOUR_PAYEER_MERCHANT_ID';
  
  // Images
  static const String logoUrl = 'https://via.placeholder.com/150x50?text=STORE+2025';
  static const String placeholderImage = 'https://via.placeholder.com/400x300';
  
  // Textes
  static const String appName = 'NovaStoreAi';
  static const String tagline = 'AI-Powered Shopping Experience';
  static const String copyright = '© 2025 NovaStoreAi. All rights reserved.';
  
  // Features bullets
  static const List<Map<String, dynamic>> features = [
    {'icon': Icons.local_shipping, 'text': 'Free Shipping'},
    {'icon': Icons.flash_on, 'text': 'Fast Delivery'},
    {'icon': Icons.verified_user, 'text': 'Trusted by 1000+'},
  ];
  
  // Reviews (fake pour MVP)
  static const List<Map<String, String>> reviews = [
    {
      'name': 'Sarah M.',
      'rating': '5',
      'text': 'Amazing product! Worth every penny. Highly recommended!',
    },
    {
      'name': 'John D.',
      'rating': '5',
      'text': 'Fast delivery and great quality. Will buy again!',
    },
    {
      'name': 'Emma W.',
      'rating': '5',
      'text': 'Best purchase this year. Everyone should get one!',
    },
  ];
  
  // FAQ
  static const List<Map<String, String>> faq = [
    {
      'question': 'How long does shipping take?',
      'answer': '5-10 business days for standard shipping.',
    },
    {
      'question': 'What is your return policy?',
      'answer': '30 days money-back guarantee, no questions asked.',
    },
    {
      'question': 'Is the product authentic?',
      'answer': '100% authentic products from trusted suppliers.',
    },
  ];
}
