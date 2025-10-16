import 'package:flutter/material.dart';

// Constantes de l'application
class AppConstants {
  // Nom de l'application
  static const String appName = 'Store App 2025';
  
  // URL de base Payeer (à remplacer par votre vraie URL)
  static const String payeerBaseUrl = 'https://payeer.com/merchant/';
  
  // Durée du splash screen
  static const Duration splashDuration = Duration(seconds: 2);
  
  // Options de livraison
  static const String shippingStandard = 'standard';
  static const String shippingExpress = 'express';
  
  // Statuts de commande
  static const String orderStatusPending = 'pending';
  static const String orderStatusPurchased = 'purchased';
  static const String orderStatusShipped = 'shipped';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusRefunded = 'refunded';
  
  // Statuts de dépôt
  static const String depositStatusPending = 'pending';
  static const String depositStatusApproved = 'approved';
  static const String depositStatusRejected = 'rejected';
  
  // Méthodes de paiement
  static const String paymentMethodWallet = 'wallet';
  static const String paymentMethodPayeer = 'Payeer';
}

// Couleurs de l'application (personnalisables)
class AppColors {
  static const Color primary = Colors.blue;
  static const Color secondary = Colors.blueAccent;
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
  static const Color error = Colors.red;
  static const Color info = Colors.blue;
  
  static const Color textPrimary = Colors.black87;
  static const Color textSecondary = Colors.black54;
  static const Color textLight = Colors.white;
  
  static const Color background = Colors.white;
  static const Color cardBackground = Colors.white;
}

// Styles de texte
class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: Colors.grey,
  );
  
  static const TextStyle price = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
}

// Espacements
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}

// Bordures
class AppBorders {
  static BorderRadius borderRadius = BorderRadius.circular(8);
  static BorderRadius borderRadiusLg = BorderRadius.circular(16);
  static BorderRadius borderRadiusSm = BorderRadius.circular(4);
}
