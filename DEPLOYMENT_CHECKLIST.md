# ✅ Checklist de déploiement - Store App 2025

## 📋 Avant de commencer

- [ ] Flutter SDK installé (3.5.4+)
- [ ] Compte Firebase créé
- [ ] Éditeur de code configuré (VS Code / Android Studio)
- [ ] Émulateur Android ou device physique prêt

---

## 🔥 Configuration Firebase

### 1. Projet Firebase
- [ ] Projet créé sur https://console.firebase.google.com/
- [ ] Nom du projet noté: `_______________`
- [ ] Firestore Database activé (mode test)
- [ ] Région sélectionnée: `_______________`

### 2. Configuration Android
- [ ] Application Android ajoutée dans Firebase
- [ ] Package name: `com.example.store_app2025`
- [ ] `google-services.json` téléchargé
- [ ] `google-services.json` placé dans `android/app/`
- [ ] `android/build.gradle` modifié (plugin Google Services)
- [ ] `android/app/build.gradle` modifié (minSdk = 21, plugin ajouté)

### 3. Configuration Web (optionnel)
- [ ] Application Web ajoutée dans Firebase
- [ ] Configuration copiée dans `web/index.html`

### 4. Règles Firestore
- [ ] Règles copiées depuis `firestore.rules`
- [ ] Règles publiées dans Firebase Console
- [ ] Mode test activé (allow read, write: if true)

---

## 📦 Données de test

### Collection products
- [ ] Collection `products` créée dans Firestore
- [ ] Au moins 1 produit ajouté avec tous les champs:
  - [ ] title
  - [ ] subtitle
  - [ ] description
  - [ ] images (array)
  - [ ] price
  - [ ] compareAtPrice
  - [ ] discountPercentage
  - [ ] variants (array, peut être vide)
  - [ ] soldCount
  - [ ] shippingETA
  - [ ] returnPolicy
  - [ ] createdAt (timestamp)
  - [ ] updatedAt (timestamp)

### Images de test
- [ ] URLs d'images valides utilisées
- [ ] Images accessibles (tester dans navigateur)

---

## 💻 Configuration locale

### Dépendances
- [ ] `flutter pub get` exécuté avec succès
- [ ] Toutes les dépendances installées
- [ ] Aucune erreur de compilation

### Vérifications
- [ ] `flutter doctor` lancé
- [ ] Tous les problèmes résolus (ou marqués ✓)
- [ ] Au moins 1 device disponible pour tests

---

## 🧪 Tests de l'application

### Test 1: Lancement
- [ ] `flutter run` fonctionne
- [ ] Splash screen s'affiche
- [ ] Redirection vers home après 2 secondes
- [ ] Pas d'erreur dans la console

### Test 2: Produits
- [ ] Au moins 1 produit s'affiche sur home
- [ ] Images des produits se chargent
- [ ] Prix affichés correctement
- [ ] Clic sur produit ouvre la page détail

### Test 3: Authentification
- [ ] Inscription fonctionne
- [ ] Email: `test@example.com`
- [ ] Password: `password123`
- [ ] Utilisateur créé dans Firestore collection `users`
- [ ] Redirection vers home après inscription
- [ ] Connexion fonctionne avec mêmes identifiants
- [ ] Déconnexion fonctionne

### Test 4: Wallet
- [ ] Page wallet accessible
- [ ] Solde à 0$ affiché
- [ ] Bouton "Ajouter des fonds" fonctionne
- [ ] Montant saisi: `100`
- [ ] Dépôt créé dans Firestore collection `deposits`
- [ ] Status = `pending`

### Test 5: Admin Dashboard
- [ ] Navigation vers `/admin` fonctionne
- [ ] Onglet "Commandes" s'affiche
- [ ] Onglet "Dépôts" s'affiche
- [ ] Dépôt de test visible dans la liste
- [ ] Bouton "Approuver" ✓ fonctionne
- [ ] Dépôt passe à status `approved`
- [ ] Retour sur wallet → solde mis à jour à 100$

### Test 6: Achat
- [ ] Sélection d'un produit
- [ ] Page produit affiche toutes les infos
- [ ] Variante sélectionnable (si variants présents)
- [ ] Clic sur "Acheter maintenant"
- [ ] Page checkout s'affiche
- [ ] Formulaire d'adresse rempli:
  - [ ] Adresse: `123 Test Street`
  - [ ] Ville: `Paris`
  - [ ] Code postal: `75001`
  - [ ] Pays: `France`
- [ ] Option de livraison sélectionnée
- [ ] Solde wallet suffisant
- [ ] Clic sur "Passer la commande"
- [ ] Commande créée dans Firestore
- [ ] Redirection vers page confirmation
- [ ] Solde wallet déduit

### Test 7: Commandes
- [ ] Page "Mes commandes" accessible
- [ ] Commande de test visible
- [ ] Statut = `pending`
- [ ] Clic sur commande ouvre les détails
- [ ] Toutes les infos affichées correctement

### Test 8: Admin - Gestion commande
- [ ] Retour sur `/admin`
- [ ] Commande visible dans liste
- [ ] Expansion du card fonctionne
- [ ] Détails de la commande affichés
- [ ] Bouton "Acheté" fonctionne
- [ ] Status mis à jour → `purchased`
- [ ] Bouton "Expédié" fonctionne
- [ ] Dialog numéro tracking s'affiche
- [ ] Numéro saisi: `TRACK123456`
- [ ] Status mis à jour → `shipped`
- [ ] Bouton "Livré" fonctionne
- [ ] Status mis à jour → `delivered`

---

## 🎨 Personnalisation (optionnel)

- [ ] Nom de l'app changé dans `constants.dart`
- [ ] Couleur primaire changée dans `constants.dart`
- [ ] Logo/icône splash screen modifié
- [ ] Nom du package changé (si nécessaire)

---

## 🔐 Sécurité (avant production)

- [ ] Règles Firestore sécurisées (pas mode test)
- [ ] Champ `isAdmin` ajouté pour utilisateurs admin
- [ ] Vérification `isAdmin` avant accès `/admin`
- [ ] Variables sensibles dans fichiers .env
- [ ] `.gitignore` configuré (google-services.json)

---

## 🚀 Déploiement

### Android
- [ ] Keystore créé
- [ ] `build.gradle` configuré pour release
- [ ] APK généré: `flutter build apk`
- [ ] APK testé sur device réel
- [ ] Play Store listing préparé

### Web (optionnel)
- [ ] Build web: `flutter build web`
- [ ] Firebase Hosting configuré
- [ ] Deploy: `firebase deploy --only hosting`
- [ ] URL de prod notée: `_______________`

---

## 📊 Suivi post-lancement

- [ ] Firebase Analytics configuré
- [ ] Crashlytics configuré
- [ ] Support client configuré (email)
- [ ] Payeer vraiment intégré (remplacer simulé)
- [ ] Monitoring des commandes actif
- [ ] Backup Firestore configuré

---

## ✅ Validation finale

- [ ] Tous les tests ci-dessus passent ✓
- [ ] Aucune erreur dans logs
- [ ] Performance acceptable (< 3s chargement)
- [ ] UX fluide sur device réel
- [ ] Prêt pour utilisateurs beta

---

## 📝 Notes

Date de complétion: `_______________`

Problèmes rencontrés:
```
_______________________________________
_______________________________________
_______________________________________
```

Améliorations futures:
```
_______________________________________
_______________________________________
_______________________________________
```

---

**🎉 Félicitations! Votre app MVP est prête!**

Prochaines étapes:
1. Trouver 10 utilisateurs beta
2. Collecter feedback
3. Itérer sur le produit
4. Planifier version V1
