# Store App 2025 - MVP Flutter

Application Flutter minimaliste de dropshipping avec Firebase Firestore.

## Configuration

### 1. Firebase Setup

1. Créer un projet Firebase sur https://console.firebase.google.com/
2. Ajouter une application Android/iOS/Web selon votre besoin
3. Télécharger les fichiers de configuration:
   - Android: `google-services.json` → placer dans `android/app/`
   - iOS: `GoogleService-Info.plist` → placer dans `ios/Runner/`
   - Web: Copier la config dans `web/index.html`

4. Activer Firestore Database dans Firebase Console

5. Configurer les règles de sécurité Firestore (temporaires pour dev):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users - read own data
    match /users/{userId} {
      allow read, write: if true; // Simplifier pour MVP
    }
    
    // Products - read all
    match /products/{productId} {
      allow read: if true;
      allow write: if false; // À gérer manuellement
    }
    
    // Orders
    match /orders/{orderId} {
      allow read, write: if true; // Simplifier pour MVP
    }
    
    // Deposits
    match /deposits/{depositId} {
      allow read, write: if true; // Simplifier pour MVP
    }
  }
}
```

### 2. Installation des dépendances

```bash
flutter pub get
```

### 3. Ajouter manuellement un produit dans Firestore

Dans Firebase Console > Firestore Database, créer une collection `products` avec un document:

```json
{
  "title": "Product Title",
  "subtitle": "Get the #1 trending product in 2025",
  "description": "Full product description here...",
  "images": [
    "https://example.com/image1.jpg",
    "https://example.com/image2.jpg"
  ],
  "videos": [],
  "price": 24.99,
  "compareAtPrice": 39.99,
  "discountPercentage": 40,
  "variants": [
    {
      "variantId": "red-small",
      "title": "Red - Small",
      "SKU": "PROD-RED-S",
      "stock": 100,
      "price": 24.99
    }
  ],
  "soldCount": 150,
  "shippingETA": "5-10 days",
  "returnPolicy": "30 days return policy",
  "createdAt": [timestamp],
  "updatedAt": [timestamp]
}
```

### 4. Lancer l'application

```bash
flutter run
```

## Fonctionnalités MVP

### Client:
- ✅ Inscription/Connexion simple (email + password)
- ✅ Page d'accueil avec liste de produits
- ✅ Page détail produit avec variantes
- ✅ Portefeuille (wallet) pour ajouter des fonds
- ✅ Page de paiement (checkout)
- ✅ Confirmation de commande
- ✅ Liste des commandes

### Admin:
- ✅ Dashboard pour voir toutes les commandes
- ✅ Gestion des dépôts (approuver/rejeter)
- ✅ Mise à jour du statut des commandes
- ✅ Ajout de numéro de tracking

## Routes

- `/` - Splash screen
- `/login` - Connexion/Inscription
- `/home` - Accueil (liste produits)
- `/product` - Détail produit
- `/wallet` - Portefeuille
- `/checkout` - Paiement
- `/order-confirmation` - Confirmation
- `/orders` - Liste commandes
- `/admin` - Dashboard admin

## Accès Admin

Pour accéder au dashboard admin, naviguer manuellement vers `/admin` ou ajouter un bouton dans l'app.

## Structure du projet

```
lib/
├── main.dart
├── models/
│   ├── user_model.dart
│   ├── product_model.dart
│   ├── order_model.dart
│   └── deposit_model.dart
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
└── screens/
    ├── splash_screen.dart
    ├── login_screen.dart
    ├── home_screen.dart
    ├── product_screen.dart
    ├── wallet_screen.dart
    ├── checkout_screen.dart
    ├── order_confirmation_screen.dart
    ├── orders_screen.dart
    └── admin_dashboard_screen.dart
```

## Notes importantes

- **Auth simple**: Les mots de passe sont hashés avec SHA-256 (basique pour MVP)
- **Pas de Firebase Auth**: Authentification custom stockée dans Firestore
- **Design minimaliste**: Code léger, pas de design complexe
- **Payeer**: Le lien Payeer est simulé, à remplacer par votre vraie intégration
- **Admin**: Pour production, ajouter un champ `isAdmin` dans users et vérifier avant d'afficher `/admin`

## Prochaines étapes

1. Configurer Firebase pour votre projet
2. Ajouter les fichiers de configuration Firebase
3. Créer un produit test dans Firestore
4. Tester le flow complet: inscription → achat → admin
5. Personnaliser les couleurs et le logo
6. Ajouter votre vraie intégration Payeer
7. Sécuriser les règles Firestore pour production

## Support

Pour toute question sur l'implémentation, consultez la documentation Firebase:
- https://firebase.google.com/docs/flutter/setup
- https://firebase.google.com/docs/firestore
