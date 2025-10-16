# 🛍️ Store App 2025 - MVP Dropshipping Flutter

Application Flutter minimaliste de dropshipping avec Firebase Firestore et paiements Payeer.

## ⚡ Quick Start

**Votre projet Firebase est configuré! Vous êtes prêt!**

### 1. Lancer l'application
```bash
flutter run -d chrome
```

### 2. Ajouter des données de test
- Dans l'app, aller sur `/admin` (taper dans l'URL)
- Cliquer sur l'icône ➕ en haut à droite
- Confirmer l'ajout des données

### 3. Se connecter et tester
```
Email: test@example.com
Password: password123
```

**📖 Guide complet**: Voir [START_HERE.md](START_HERE.md)

## ✨ Fonctionnalités MVP

### 👥 Client
- ✅ Inscription/Connexion classique (email + password)
- ✅ Page d'accueil avec produits
- ✅ Détails produit avec variantes
- ✅ Portefeuille (wallet) pour gérer les fonds
- ✅ Processus de paiement (checkout)
- ✅ Confirmation et suivi de commande
- ✅ Historique des commandes

### 🔧 Admin
- ✅ Dashboard administrateur
- ✅ Gestion des commandes (voir, mettre à jour statut)
- ✅ Gestion des dépôts (approuver/rejeter)
- ✅ Ajout de numéros de tracking

## 🏗️ Architecture

```
lib/
├── main.dart                  # Point d'entrée avec routing
├── models/                    # Modèles de données
│   ├── user_model.dart
│   ├── product_model.dart
│   ├── order_model.dart
│   └── deposit_model.dart
├── services/                  # Services Firebase
│   ├── auth_service.dart      # Auth custom (sans Firebase Auth)
│   └── firestore_service.dart # CRUD Firestore
├── screens/                   # Écrans de l'app
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── product_screen.dart
│   ├── wallet_screen.dart
│   ├── checkout_screen.dart
│   ├── order_confirmation_screen.dart
│   ├── orders_screen.dart
│   └── admin_dashboard_screen.dart
├── widgets/                   # Widgets réutilisables
│   └── common_widgets.dart
└── utils/                     # Utilitaires
    ├── constants.dart
    └── helpers.dart
```

## 🚀 Installation Rapide

### 1. Prérequis
- Flutter SDK 3.5.4+
- Compte Firebase
- Éditeur (VS Code, Android Studio)

### 2. Cloner et installer
```bash
cd store_app2025
flutter pub get
```

### 3. Configurer Firebase
**📖 Voir le guide détaillé: `SETUP_GUIDE.md`**

Résumé rapide:
1. Créer projet Firebase
2. Activer Firestore Database
3. Télécharger `google-services.json` → `android/app/`
4. Configurer les règles Firestore
5. Ajouter des produits de test

### 4. Lancer
```bash
flutter run
```

## 📂 Fichiers de documentation

- **`SETUP_GUIDE.md`** - Guide complet de configuration Firebase (⭐ COMMENCER ICI)
- **`FIRESTORE_SAMPLE_DATA.md`** - Exemples de données à ajouter
- **`firestore.rules`** - Règles de sécurité Firestore
- **`DB firstore structure.txt`** - Structure complète de la base de données

## 🔑 Technologies

- **Flutter** - Framework UI
- **Firebase Firestore** - Base de données NoSQL
- **Provider** - State management simple
- **Crypto** - Hash des mots de passe (SHA-256)
- **Payeer** - Système de paiement (à configurer)

## 📱 Routes de l'application

| Route | Description |
|-------|-------------|
| `/` | Splash screen |
| `/login` | Connexion/Inscription |
| `/home` | Accueil (liste produits) |
| `/product` | Détail produit |
| `/wallet` | Portefeuille |
| `/checkout` | Paiement |
| `/order-confirmation` | Confirmation |
| `/orders` | Mes commandes |
| `/admin` | Dashboard admin |

## 🔐 Authentification

⚠️ **Auth personnalisée** (pas Firebase Auth)
- Mots de passe hashés avec SHA-256
- Stockage dans Firestore collection `users`
- Simple et léger pour MVP

## 💳 Système de paiement

1. **Wallet (Portefeuille)**
   - L'utilisateur ajoute des fonds via Payeer
   - Le dépôt est en attente (`pending`)
   - L'admin approuve le dépôt
   - Le solde est mis à jour

2. **Achat**
   - Vérification du solde wallet
   - Déduction automatique
   - Création de la commande

## 🎨 Personnalisation

### Couleurs et styles
Modifier `lib/utils/constants.dart`:
```dart
class AppColors {
  static const Color primary = Colors.blue; // Changer ici
  static const Color success = Colors.green;
  // ...
}
```

### Logo et nom
1. Remplacer l'icône dans `splash_screen.dart`
2. Changer `appName` dans `constants.dart`

## ⚠️ Important pour Production

- [ ] Sécuriser les règles Firestore
- [ ] Ajouter un système de rôles (isAdmin)
- [ ] Implémenter la vraie intégration Payeer
- [ ] Utiliser HTTPS pour toutes les images
- [ ] Ajouter la gestion d'erreurs robuste
- [ ] Implémenter les logs et analytics
- [ ] Tester sur vrais devices
- [ ] Optimiser les performances
- [ ] Ajouter un système de cache

## 🐛 Débogage

### Erreur "No Firebase App"
```bash
# Vérifier google-services.json
ls android/app/google-services.json
```

### Produits ne s'affichent pas
```dart
// Vérifier dans Firestore Console:
// - Collection "products" existe
// - Au moins 1 document avec tous les champs requis
```

### Erreur de permission Firestore
```javascript
// Vérifier les règles Firestore (mode test):
allow read, write: if true;
```

## 📊 Collections Firestore

| Collection | Description |
|-----------|-------------|
| `users` | Utilisateurs et wallets |
| `products` | Catalogue de produits |
| `orders` | Commandes clients |
| `deposits` | Dépôts wallet |

## 🚀 Prochaines versions

**V1** - Expansion produits
- Catalogue multi-produits
- Filtres et recherche
- Rôles utilisateurs

**V2** - Automation
- API fournisseurs
- Automatisation commandes
- Bot support IA

**V3** - Marketplace
- Multi-vendeurs
- Analytics avancées
- A/B testing

## 📞 Support

Pour des questions:
1. Consulter `SETUP_GUIDE.md`
2. Vérifier les logs Firebase Console
3. Utiliser `flutter doctor` pour diagnostiquer

## 📄 Licence

Projet privé - Tous droits réservés

---

**🎯 Objectif MVP**: Valider le produit gagnant et prendre des paiements

**⏱️ Temps de setup estimé**: 30-60 minutes

**🔥 Commencer maintenant**: Ouvrir `SETUP_GUIDE.md`
"# NovaStore" 
