# 🌱 Guide d'utilisation du Seeder de données

## 📋 Ce qui sera ajouté

### 📦 Produits (3)
1. **Smart LED Watch 2025** - $24.99 (3 variantes: Black, Silver, Rose Gold)
2. **Wireless Earbuds Pro** - $34.99 (2 variantes: White, Black)
3. **Portable Power Bank 20000mAh** - $19.99 (sans variante)

### 👥 Utilisateurs (3)
1. **Admin** - `admin@store.com` / `admin123` (Solde: $500, isAdmin: true)
2. **Test User** - `test@example.com` / `password123` (Solde: $100)
3. **Customer** - `customer@example.com` / `customer123` (Solde: $250)

---

## 🚀 Méthode 1: Exécuter le script directement

### Pour Web (Chrome):
```bash
flutter run lib/utils/seed_data.dart -d chrome
```

### Pour Android:
```bash
flutter run lib/utils/seed_data.dart -d <android_device_id>
```

### Pour voir les devices disponibles:
```bash
flutter devices
```

---

## 🚀 Méthode 2: Ajouter un bouton dans l'app

### Option A: Dans la page Admin

Modifiez `lib/screens/admin_dashboard_screen.dart`:

```dart
// Ajouter en haut du fichier
import '../utils/seed_data.dart';

// Ajouter dans le Scaffold, par exemple dans l'AppBar
appBar: AppBar(
  title: const Text('Admin Dashboard'),
  actions: [
    IconButton(
      icon: const Icon(Icons.add_circle),
      onPressed: () async {
        final seeder = FirebaseSeeder();
        await seeder.seedAll();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Données de test ajoutées!')),
        );
      },
      tooltip: 'Ajouter données de test',
    ),
  ],
),
```

### Option B: Dans la page Home (temporaire)

Ajoutez un FloatingActionButton dans `home_screen.dart`:

```dart
// Ajouter en haut
import '../utils/seed_data.dart';

// Dans le Scaffold
floatingActionButton: FloatingActionButton(
  onPressed: () async {
    final seeder = FirebaseSeeder();
    await seeder.seedAll();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Données ajoutées!')),
    );
  },
  child: const Icon(Icons.add),
  tooltip: 'Seed data',
),
```

---

## 🚀 Méthode 3: Via Firebase Console (Manuel)

### Ajouter un produit manuellement:

1. Aller sur https://console.firebase.google.com/
2. Sélectionner votre projet `store-ebecf`
3. Cliquer sur "Firestore Database"
4. Cliquer sur "Démarrer une collection"
5. Nom de la collection: `products`
6. Ajouter un document avec les champs suivants:

```json
{
  "title": "Smart LED Watch 2025",
  "subtitle": "Get the #1 trending smartwatch in 2025",
  "description": "Full description here...",
  "images": [
    "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800"
  ],
  "videos": [],
  "price": 24.99,
  "compareAtPrice": 39.99,
  "discountPercentage": 40,
  "variants": [],
  "soldCount": 100,
  "shippingETA": "5-10 business days",
  "returnPolicy": "30 days money-back guarantee",
  "createdAt": [timestamp now],
  "updatedAt": [timestamp now]
}
```

---

## 🗑️ Nettoyer les données

Si vous voulez tout supprimer et recommencer:

```dart
// Dans seed_data.dart, décommenter cette ligne:
await seeder.clearAll();
```

Puis relancer le script.

---

## ✅ Vérifier que ça a marché

### Dans Firebase Console:
1. Aller sur Firestore Database
2. Vérifier les collections:
   - `products` → 3 documents
   - `users` → 3 documents

### Dans l'application:
1. Lancer l'app: `flutter run -d chrome`
2. La page Home doit afficher 3 produits
3. Se connecter avec: `test@example.com` / `password123`
4. Le wallet doit afficher $100

---

## 🎯 Tester le flow complet

### 1. Se connecter en tant qu'utilisateur test
```
Email: test@example.com
Password: password123
```

### 2. Vérifier le wallet
- Aller dans l'icône wallet (en haut à droite)
- Solde doit afficher: $100.00

### 3. Acheter un produit
- Retour à Home
- Cliquer sur "Smart LED Watch" (le moins cher à $24.99)
- Cliquer sur "Acheter maintenant"
- Remplir l'adresse (ou laisser vide, une adresse par défaut existe)
- Cliquer sur "Passer la commande"
- ✅ Commande créée!

### 4. Se connecter en tant qu'admin
- Se déconnecter (icône logout)
- Se reconnecter avec:
```
Email: admin@store.com
Password: admin123
```

### 5. Gérer les commandes
- Naviguer vers `/admin` (ou ajouter un bouton dans l'app)
- Voir la commande du test user
- Cliquer dessus pour l'étendre
- Mettre à jour le statut: "Acheté" → "Expédié" → "Livré"

---

## 💡 Personnaliser les données

Modifiez `lib/utils/seed_data.dart`:

### Ajouter plus de produits:
```dart
{
  'title': 'Mon nouveau produit',
  'subtitle': 'Description courte',
  'description': 'Description longue...',
  'images': ['https://...'],
  'price': 29.99,
  'compareAtPrice': 49.99,
  'discountPercentage': 40,
  // ... autres champs
}
```

### Modifier les utilisateurs:
```dart
await authService.register(
  'mon-email@example.com',
  'mon-password',
  name: 'Mon Nom',
);
```

### Modifier les soldes:
```dart
await _db.collection('users').doc(userId).update({
  'walletBalance': 1000.0, // Nouveau solde
});
```

---

## ⚠️ Attention

- **Ne pas exécuter plusieurs fois** sans nettoyer d'abord (sauf si vous voulez des doublons)
- **Les utilisateurs** avec le même email ne seront pas recréés (erreur ignorée)
- **Les produits** seront dupliqués si vous relancez le script

---

## 🔧 Résolution de problèmes

### Erreur "Email déjà utilisé"
→ Normal, les utilisateurs ne seront pas recréés. Produits seront quand même ajoutés.

### Produits ne s'affichent pas
→ Vérifier dans Firebase Console que la collection `products` existe et contient des documents.

### Erreur de permission
→ Vérifier les règles Firestore (mode test activé).

### Images ne se chargent pas
→ URLs Unsplash peuvent nécessiter une connexion internet. Remplacez par vos propres URLs.

---

## 📊 Données complètes

Après exécution du seeder, votre Firestore contiendra:

```
Firestore Database
├── products (3 documents)
│   ├── Smart LED Watch 2025
│   ├── Wireless Earbuds Pro
│   └── Portable Power Bank 20000mAh
│
└── users (3 documents)
    ├── admin@store.com (isAdmin: true, balance: $500)
    ├── test@example.com (balance: $100)
    └── customer@example.com (balance: $250)
```

---

## 🎉 C'est prêt!

Votre base de données est maintenant remplie avec des données de test.

**Prochaine étape:** Lancer l'application!

```bash
flutter run -d chrome
```

Ou pour Android:
```bash
flutter run
```

Bon test! 🚀
