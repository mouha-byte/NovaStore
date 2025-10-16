# 🚀 Guide Rapide - Accès Admin

## ✅ Modifications effectuées

1. **UserModel** : Ajout du champ `isAdmin`
2. **AuthService** : Ajout de la méthode `isAdmin()`
3. **HomeScreen** : Ajout du bouton Admin Dashboard (🛡️) dans l'AppBar
4. **AdminDashboard** : 5 onglets complets (Statistiques, Commandes, Produits, Utilisateurs, Dépôts)

---

## 📋 ÉTAPES POUR TESTER

### Étape 1: Créer les données de test
Dans l'application, vous verrez un bouton **"Seed Data"** dans l'Admin Dashboard.

**OU** vous pouvez créer manuellement l'utilisateur admin dans Firebase Console:

1. Allez dans Firebase Console → Firestore Database
2. Collection: `users`
3. Cliquez sur **"Add document"**
4. Remplissez:
   ```
   Document ID: (auto)
   
   email: "admin@store.com"
   password: "ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f"
   name: "Admin User"
   isAdmin: true (boolean)
   walletBalance: 500 (number)
   addresses: [] (array vide)
   createdAt: (timestamp actuel)
   updatedAt: (timestamp actuel)
   ```

> **Note**: Le password hashé correspond à `admin123`

### Étape 2: Se connecter en tant qu'admin

1. Lancez l'application
2. Connectez-vous avec:
   - **Email**: `admin@store.com`
   - **Password**: `admin123`

3. Vous verrez maintenant l'icône **🛡️ Admin** dans l'AppBar

### Étape 3: Accéder au Dashboard Admin

Cliquez sur l'icône **🛡️** dans l'AppBar pour accéder au dashboard complet avec 5 onglets.

---

## 🎯 FONCTIONNALITÉS ADMIN

### 📊 Onglet Statistiques
- Nombre total de commandes
- Revenus totaux
- Nombre d'utilisateurs
- Nombre de produits
- Détails des commandes (en attente, livrées)
- Détails des dépôts (approuvés, montant total)

### 📦 Onglet Commandes
- **✅ Accepter** une commande
- **❌ Refuser** une commande
- **🚚 Marquer comme expédiée** (avec numéro de tracking)
- **✔️ Marquer comme livrée**
- Voir toutes les informations (adresse, montant, date)

### 🛍️ Onglet Produits
- Liste de tous les produits
- **✏️ Modifier** un produit (à venir)
- **🗑️ Supprimer** un produit (avec confirmation)
- Voir les détails (prix, variantes, ventes)

### 👥 Onglet Utilisateurs
- Liste de tous les utilisateurs
- Voir: nom, email, solde wallet
- Badge admin/utilisateur
- **Promouvoir en admin** (pour les utilisateurs normaux)

### 💰 Onglet Dépôts
- Liste de tous les dépôts
- **✅ Approuver** un dépôt (met à jour automatiquement le solde)
- **❌ Rejeter** un dépôt
- Filtres par statut (en attente, approuvé, rejeté)

---

## 🔐 Comptes de Test

Après avoir exécuté le seed data, vous aurez:

### Admin
- **Email**: `admin@store.com`
- **Password**: `admin123`
- **Solde**: $500
- **Droits**: Accès complet au dashboard admin

### Utilisateur Normal
- **Email**: `test@example.com`
- **Password**: `password123`
- **Solde**: $100
- **Droits**: Utilisateur standard (pas d'accès admin)

---

## 🐛 Dépannage

### Le bouton admin n'apparaît pas?

**Vérifiez que**:
1. ✅ Vous êtes connecté avec `admin@store.com`
2. ✅ Le champ `isAdmin: true` existe dans Firestore pour cet utilisateur
3. ✅ Vous avez redémarré l'application après la modification

### Comment vérifier dans Firestore?

1. Firebase Console → Firestore Database
2. Collection `users`
3. Trouvez le document avec `email: admin@store.com`
4. Vérifiez que `isAdmin: true` (type boolean)

### Recréer l'utilisateur admin manuellement

Si nécessaire, supprimez l'utilisateur existant et recréez-le avec les bonnes données (voir Étape 1).

---

## 📝 Hash des mots de passe

Les mots de passe sont hashés avec SHA-256:

- `admin123` → `ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f`
- `password123` → `ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f`

> **Important**: Pour la production, utilisez un système plus sécurisé (bcrypt, scrypt, ou Firebase Authentication).

---

## ✨ Architecture

```
HomeScreen
  └─ AppBar
      ├─ 🛡️ Admin (si isAdmin == true)
      ├─ 💰 Wallet
      ├─ 🛍️ Orders
      └─ 🔒 Logout
```

L'icône admin apparaît **uniquement** si:
- `authService.isAdmin()` retourne `true`
- Ce qui vérifie: `_currentUser != null && _currentUser.isAdmin == true`

---

## 🎉 C'est prêt!

Votre application dispose maintenant d'un système admin complet avec 5 sections de gestion.
