import 'package:intl/intl.dart';

class Helpers {
  // Format de prix
  static String formatPrice(double price, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(price);
  }
  
  // Format de date
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
  
  // Format de date et heure
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
  
  // Format de date relative (il y a X jours)
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} an${(difference.inDays / 365).floor() > 1 ? 's' : ''}';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} mois';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} heure${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''}';
    } else {
      return 'À l\'instant';
    }
  }
  
  // Validation email
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
  
  // Validation mot de passe (min 6 caractères)
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
  
  // Tronquer le texte
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
  
  // Calculer le pourcentage de réduction
  static int calculateDiscount(double originalPrice, double salePrice) {
    if (originalPrice <= 0) return 0;
    return ((originalPrice - salePrice) / originalPrice * 100).round();
  }
  
  // Obtenir le libellé du statut de commande
  static String getOrderStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'En attente';
      case 'purchased':
        return 'Acheté';
      case 'shipped':
        return 'Expédié';
      case 'delivered':
        return 'Livré';
      case 'refunded':
        return 'Remboursé';
      default:
        return status;
    }
  }
  
  // Obtenir le libellé du statut de dépôt
  static String getDepositStatusLabel(String status) {
    switch (status) {
      case 'pending':
        return 'En attente';
      case 'approved':
        return 'Approuvé';
      case 'rejected':
        return 'Rejeté';
      default:
        return status;
    }
  }
}
