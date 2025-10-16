# 📁 Structure complète du projet Store App 2025

## 🎯 Résumé

Application Flutter MVP de dropshipping avec:
- ✅ 9 écrans fonctionnels
- ✅ Authentification custom (email/password)
- ✅ Firestore pour données
- ✅ Wallet system
- ✅ Admin dashboard
- ✅ Code minimal et léger

---

## 📂 Arborescence

```
store_app2025/
│
├── 📄 README.md                      # Documentation principale
├── 📄 SETUP_GUIDE.md                 # Guide de configuration Firebase (⭐ START HERE)
├── 📄 DEPLOYMENT_CHECKLIST.md        # Checklist avant déploiement
├── 📄 FIRESTORE_SAMPLE_DATA.md       # Exemples de données Firestore
├── 📄 ANDROID_SETUP.md               # Configuration Android spécifique
├── 📄 firestore.rules                # Règles de sécurité Firestore
├── 📄 pubspec.yaml                   # Dépendances Flutter
│
├── lib/
│   ├── 📄 main.dart                  # Point d'entrée + routing
│   │
│   ├── models/                       # 📦 Modèles de données (4 fichiers)
│   │   ├── user_model.dart           # Utilisateur + Adresse
│   │   ├── product_model.dart        # Produit + Variante
│   │   ├── order_model.dart          # Commande
│   │   └── deposit_model.dart        # Dépôt wallet
│   │
│   ├── services/                     # 🔧 Services (2 fichiers)
│   │   ├── auth_service.dart         # Auth custom (login/register)
│   │   └── firestore_service.dart    # CRUD Firestore
│   │
│   ├── screens/                      # 📱 Écrans (9 fichiers)
│   │   ├── splash_screen.dart        # Splash (2s redirect)
│   │   ├── login_screen.dart         # Connexion/Inscription
│   │   ├── home_screen.dart          # Liste produits
│   │   ├── product_screen.dart       # Détails produit
│   │   ├── wallet_screen.dart        # Portefeuille
│   │   ├── checkout_screen.dart      # Paiement
│   │   ├── order_confirmation_screen.dart  # Confirmation
│   │   ├── orders_screen.dart        # Liste commandes user
│   │   └── admin_dashboard_screen.dart     # Admin
│   │
│   ├── widgets/                      # 🎨 Widgets réutilisables
│   │   └── common_widgets.dart       # Loading, Error, Empty
│   │
│   └── utils/                        # 🛠️ Utilitaires
│       ├── constants.dart            # Constantes, couleurs, styles
│       └── helpers.dart              # Fonctions utilitaires
│
├── android/                          # Configuration Android
│   ├── app/
│   │   ├── google-services.json      # ⚠️ À AJOUTER depuis Firebase
│   │   └── build.gradle              # ⚠️ À MODIFIER (minSdk, plugin)
│   └── build.gradle                  # ⚠️ À MODIFIER (Google Services)
│
├── ios/                              # Configuration iOS
│   └── Runner/
│       └── GoogleService-Info.plist  # ⚠️ À AJOUTER (optionnel)
│
└── web/                              # Configuration Web
    └── index.html                    # ⚠️ À MODIFIER (Firebase config)
```

---

## 📊 Collections Firestore requises

### 1️⃣ users
```
{
  email: string
  password: string (SHA-256 hash)
  name: string
  phone: string
  walletBalance: number
  addresses: array
  createdAt: timestamp
  updatedAt: timestamp
}
```

### 2️⃣ products (⚠️ À créer manuellement)
```
{
  title: string
  subtitle: string
  description: string
  images: array
  videos: array
  price: number
  compareAtPrice: number
  discountPercentage: number
  variants: array
  soldCount: number
  shippingETA: string
  returnPolicy: string
  createdAt: timestamp
  updatedAt: timestamp
}
```

### 3️⃣ orders (créée automatiquement)
```
{
  userId: string
  productId: string
  variantId: string
  quantity: number
  totalPrice: number
  shippingAddress: object
  shippingOption: string
  couponCode: string
  paymentMethod: string
  status: string
  trackingNumber: string
  createdAt: timestamp
  updatedAt: timestamp
}
```

### 4️⃣ deposits (créée automatiquement)
```
{
  userId: string
  amount: number
  method: string
  status: string
  createdAt: timestamp
  updatedAt: timestamp
}
```

---

## 🔄 Flux utilisateur

### Client:
```
1. Splash (2s)
   ↓
2. Home (liste produits)
   ↓ Clic Login/Register
3. Login/Register
   ↓ Succès
4. Home (avec wallet visible)
   ↓ Clic Wallet
5. Wallet → Add Funds → Payeer (simulé)
   ↓ Admin approuve
6. Home → Product
   ↓ Clic Buy Now
7. Checkout (formulaire + wallet check)
   ↓ Place Order
8. Order Confirmation
   ↓
9. Orders List
```

### Admin:
```
1. Navigate to /admin
   ↓
2. Dashboard Tabs:
   - Orders (voir, update status)
   - Deposits (approve/reject)
```

---

## 📦 Dépendances principales

```yaml
dependencies:
  firebase_core: ^3.6.0        # Firebase init
  cloud_firestore: ^5.4.4      # Base de données
  provider: ^6.1.2             # State management
  url_launcher: ^6.3.1         # Ouvrir Payeer
  intl: ^0.19.0                # Format dates/prix
  crypto: ^3.0.3               # Hash passwords
```

---

## 🎨 Design Philosophy

**Minimaliste et léger:**
- Pas de packages lourds (pas de GetX, Bloc, etc.)
- Provider pour state simple
- Material Design natif
- Code direct et lisible
- Aucun asset complexe
- Focus sur la fonctionnalité

---

## 🔐 Sécurité MVP

**⚠️ Pour développement uniquement:**
- Auth custom (SHA-256 simple)
- Firestore rules en mode test
- Pas de validation email
- Pas de 2FA

**✅ Pour production, ajouter:**
- Firebase Authentication
- Règles Firestore sécurisées
- Validation email
- Rate limiting
- HTTPS obligatoire
- Encryption des données sensibles

---

## 🚀 Commandes utiles

```bash
# Installation
flutter pub get

# Lancer
flutter run

# Lancer sur device spécifique
flutter run -d chrome
flutter run -d <device_id>

# Build
flutter build apk
flutter build appbundle
flutter build web

# Clean
flutter clean
flutter pub get

# Diagnostics
flutter doctor
flutter doctor -v
```

---

## 📝 Variables d'environnement à configurer

1. **Firebase:**
   - Project ID
   - API Keys
   - google-services.json

2. **Payeer:**
   - Merchant ID
   - Secret Key
   - Callback URL

3. **Admin:**
   - Liste emails admin
   - Permissions

---

## 🎯 Fichiers à modifier en priorité

### Avant premier lancement:
1. ✅ `android/app/google-services.json` (ajouter)
2. ✅ `android/build.gradle` (modifier)
3. ✅ `android/app/build.gradle` (modifier)
4. ✅ Firestore rules (publier)
5. ✅ Ajouter 1 produit dans Firestore

### Pour personnalisation:
1. `lib/utils/constants.dart` (couleurs, nom app)
2. `lib/screens/splash_screen.dart` (logo)
3. `android/app/src/main/res/` (icônes)

---

## 📈 Métriques à suivre

### Techniques:
- Temps de chargement
- Erreurs Firestore
- Crashs app
- Performance queries

### Business:
- Inscriptions
- Commandes
- Taux conversion
- Panier moyen
- Dépôts approuvés

---

## 🔗 Ressources

- [Flutter Doc](https://flutter.dev/docs)
- [Firebase Flutter](https://firebase.flutter.dev/)
- [Firestore Doc](https://firebase.google.com/docs/firestore)
- [Provider Package](https://pub.dev/packages/provider)

---

## ⚡ Quick Start (TL;DR)

```bash
# 1. Setup Firebase
# → Créer projet, activer Firestore, télécharger google-services.json

# 2. Config
flutter pub get

# 3. Ajouter produit dans Firestore
# → Console Firebase > Firestore > products > Add document

# 4. Run
flutter run

# 5. Test
# → S'inscrire, ajouter fonds (admin approve), acheter
```

---

**🎉 Vous avez maintenant une app MVP complète et fonctionnelle!**

**📖 Prochaine étape:** Ouvrir `SETUP_GUIDE.md` pour configurer Firebase.
