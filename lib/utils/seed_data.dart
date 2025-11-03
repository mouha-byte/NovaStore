import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../services/auth_service.dart';

class FirebaseSeeder {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Méthode principale pour seed toutes les données
  Future<void> seedAll() async {
    print('🌱 Démarrage du seeding...');
    
    try {
      await seedProducts();
      await seedUsers();
      print('✅ Seeding terminé avec succès!');
    } catch (e) {
      print('❌ Erreur lors du seeding: $e');
    }
  }

  // Seed des produits
  Future<void> seedProducts() async {
    print('📦 Ajout des produits...');

    final products = [
      {
        'title': 'Mini Mixeur Bouteille USB Portable 380ml',
        'subtitle': 'Get the #1 trending smartwatch in 2025',
        'description': '''Experience the future with our revolutionary smart LED watch. Features include:

✓ HD Display with vibrant colors
✓ 7-day battery life
✓ Water resistant (IP68)
✓ Heart rate monitor
✓ Sleep tracking
✓ Multiple sport modes
✓ Bluetooth connectivity

Perfect for fitness enthusiasts and tech lovers!''',
        'images': [
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
          'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=800',
        ],
        'videos': [],
        'price': 24.99,
        'compareAtPrice': 39.99,
        'discountPercentage': 40,
        'variants': [
          {
            'variantId': 'black',
            'title': 'Black',
            'SKU': 'LED-WATCH-BLK',
            'stock': 120,
            'price': 24.99,
          },
          {
            'variantId': 'silver',
            'title': 'Silver',
            'SKU': 'LED-WATCH-SLV',
            'stock': 80,
            'price': 27.99,
          },
          {
            'variantId': 'rose-gold',
            'title': 'Rose Gold',
            'SKU': 'LED-WATCH-RG',
            'stock': 60,
            'price': 29.99,
          },
        ],
        'soldCount': 1247,
        'shippingETA': '5-10 business days',
        'returnPolicy': '30 days money-back guarantee',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'title': 'Wireless Earbuds Pro',
        'subtitle': 'Premium sound quality meets comfort',
        'description': '''Immerse yourself in crystal-clear audio with our latest wireless earbuds.

✓ Active noise cancellation
✓ 30-hour total battery life
✓ IPX7 water resistance
✓ Touch controls
✓ Premium audio quality
✓ Ergonomic design
✓ Fast charging (15 min = 3 hours)

Your perfect companion for music, calls, and workouts!''',
        'images': [
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
          'https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=800',
        ],
        'videos': [],
        'price': 34.99,
        'compareAtPrice': 59.99,
        'discountPercentage': 42,
        'variants': [
          {
            'variantId': 'white',
            'title': 'White',
            'SKU': 'EARBUDS-WHT',
            'stock': 150,
            'price': 34.99,
          },
          {
            'variantId': 'black',
            'title': 'Black',
            'SKU': 'EARBUDS-BLK',
            'stock': 100,
            'price': 34.99,
          },
        ],
        'soldCount': 892,
        'shippingETA': '7-12 business days',
        'returnPolicy': '30 days money-back guarantee',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
      {
        'title': 'Portable Power Bank 20000mAh',
        'subtitle': 'Never run out of battery again',
        'description': '''High-capacity power bank with fast charging technology.

✓ 20000mAh capacity
✓ Charges iPhone 12 times
✓ Dual USB ports
✓ LED battery indicator
✓ Fast charging support
✓ Lightweight design
✓ Safety protection

Keep all your devices powered throughout the day!''',
        'images': [
          'https://images.unsplash.com/photo-1609091839311-d5365f9ff1c5?w=800',
        ],
        'videos': [],
        'price': 19.99,
        'compareAtPrice': 34.99,
        'discountPercentage': 43,
        'variants': [],
        'soldCount': 543,
        'shippingETA': '5-10 business days',
        'returnPolicy': '30 days money-back guarantee',
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      },
    ];

    for (var product in products) {
      await _db.collection('products').add(product);
      print('  ✓ Produit ajouté: ${product['title']}');
    }
  }

  // Seed des utilisateurs de test
  Future<void> seedUsers() async {
    print('👤 Ajout des utilisateurs...');

    final authService = AuthService();

    // Utilisateur admin
    try {
      final adminUser = await authService.register(
        'admin@store.com',
        'admin123',
        name: 'Admin User',
      );

      if (adminUser != null) {
        // Ajouter le flag isAdmin
        await _db.collection('users').doc(adminUser.id).update({
          'isAdmin': true,
          'walletBalance': 500.0, // Admin avec du solde pour tester
        });
        print('  ✓ Admin créé: admin@store.com / admin123');
      }
    } catch (e) {
      print('  ℹ️ Admin existe déjà ou erreur: $e');
    }

    // Utilisateur test normal
    try {
      final testUser = await authService.register(
        'test@example.com',
        'password123',
        name: 'Test User',
      );

      if (testUser != null) {
        // Ajouter un solde initial
        await _db.collection('users').doc(testUser.id).update({
          'walletBalance': 100.0,
          'addresses': [
            {
              'address': '123 Test Street',
              'city': 'Paris',
              'state': 'Île-de-France',
              'zip': '75001',
              'country': 'France',
              'default': true,
            }
          ],
        });
        print('  ✓ User test créé: test@example.com / password123');
      }
    } catch (e) {
      print('  ℹ️ User test existe déjà ou erreur: $e');
    }

    // Utilisateur avec commande
    try {
      final customerUser = await authService.register(
        'customer@example.com',
        'customer123',
        name: 'Customer User',
      );

      if (customerUser != null) {
        await _db.collection('users').doc(customerUser.id).update({
          'walletBalance': 250.0,
        });
        print('  ✓ Customer créé: customer@example.com / customer123');
      }
    } catch (e) {
      print('  ℹ️ Customer existe déjà ou erreur: $e');
    }
  }

  // Méthode pour nettoyer toutes les données (ATTENTION!)
  Future<void> clearAll() async {
    print('🗑️  Nettoyage des données...');
    
    // Supprimer tous les produits
    final products = await _db.collection('products').get();
    for (var doc in products.docs) {
      await doc.reference.delete();
    }
    print('  ✓ Produits supprimés');

    // Supprimer toutes les commandes
    final orders = await _db.collection('orders').get();
    for (var doc in orders.docs) {
      await doc.reference.delete();
    }
    print('  ✓ Commandes supprimées');

    // Supprimer tous les dépôts
    final deposits = await _db.collection('deposits').get();
    for (var doc in deposits.docs) {
      await doc.reference.delete();
    }
    print('  ✓ Dépôts supprimés');

    print('✅ Nettoyage terminé!');
  }
}

// Fonction principale pour exécuter le seeding
Future<void> main() async {
  print('🚀 Initialisation Firebase...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final seeder = FirebaseSeeder();
  
  // Décommenter pour nettoyer avant de seed
  // await seeder.clearAll();
  
  await seeder.seedAll();

  print('\n📊 Données ajoutées:');
  print('  - 3 produits');
  print('  - 3 utilisateurs:');
  print('    • admin@store.com / admin123 (Admin avec 500\$)');
  print('    • test@example.com / password123 (User avec 100\$)');
  print('    • customer@example.com / customer123 (Customer avec 250\$)');
  print('\n✨ Vous pouvez maintenant lancer l\'application!');
  print('   flutter run');
}
