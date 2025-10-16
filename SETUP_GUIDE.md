# 🚀 Guide de Configuration Firebase - Démarrage Rapide

## Étape 1: Créer un projet Firebase

1. Aller sur https://console.firebase.google.com/
2. Cliquer sur "Ajouter un projet"
3. Nom du projet: `store-app-2025` (ou votre choix)
4. Accepter les conditions
5. Désactiver Google Analytics (optionnel pour MVP)
6. Cliquer sur "Créer le projet"

---

## Étape 2: Configurer Firestore Database

1. Dans le menu de gauche, cliquer sur "Firestore Database"
2. Cliquer sur "Créer une base de données"
3. Choisir "Démarrer en mode test" (pour développement)
4. Choisir la région (ex: `europe-west1` pour Europe)
5. Cliquer sur "Activer"

---

## Étape 3: Ajouter Firebase à votre application Flutter

### Pour Android:

1. Dans Firebase Console, cliquer sur l'icône Android
2. Package Android: `com.example.store_app2025` (ou vérifier dans `android/app/build.gradle`)
3. Télécharger `google-services.json`
4. **Placer ce fichier dans**: `android/app/google-services.json`
5. Modifier `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

6. Modifier `android/app/build.gradle`:

```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
    id 'com.google.gms.google-services'  // Ajouter cette ligne
}

android {
    ...
    defaultConfig {
        minSdkVersion 21  // Changer de 19 à 21 minimum pour Firebase
        ...
    }
}
```

### Pour Web:

1. Dans Firebase Console, cliquer sur l'icône Web
2. Nom de l'app: "Store App Web"
3. Copier la configuration Firebase
4. Modifier `web/index.html` - Ajouter avant `</body>`:

```html
<script type="module">
  import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
  import { getFirestore } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-firestore.js";
  
  const firebaseConfig = {
    apiKey: "VOTRE_API_KEY",
    authDomain: "VOTRE_PROJECT.firebaseapp.com",
    projectId: "VOTRE_PROJECT_ID",
    storageBucket: "VOTRE_PROJECT.appspot.com",
    messagingSenderId: "VOTRE_SENDER_ID",
    appId: "VOTRE_APP_ID"
  };

  const app = initializeApp(firebaseConfig);
</script>
```

### Pour iOS (optionnel):

1. Dans Firebase Console, cliquer sur l'icône iOS
2. Bundle ID: `com.example.storeApp2025`
3. Télécharger `GoogleService-Info.plist`
4. Placer dans `ios/Runner/GoogleService-Info.plist`

---

## Étape 4: Configurer les règles Firestore

1. Dans Firestore Database, cliquer sur l'onglet "Règles"
2. Copier-coller les règles depuis le fichier `firestore.rules`
3. Cliquer sur "Publier"

---

## Étape 5: Ajouter des produits de test

1. Dans Firestore Database, cliquer sur "Démarrer une collection"
2. ID de collection: `products`
3. Utiliser les exemples du fichier `FIRESTORE_SAMPLE_DATA.md`
4. Ajouter au moins 1 produit pour tester

**Méthode rapide - Créer un produit minimal:**

Collection: `products`

Document ID: (auto)

Champs:
```
title: "Test Product"
subtitle: "Amazing product"
description: "Full description here"
images: ["https://via.placeholder.com/800"]
videos: []
price: 24.99
compareAtPrice: 39.99
discountPercentage: 40
variants: []
soldCount: 100
shippingETA: "5-10 days"
returnPolicy: "30 days return"
createdAt: [timestamp maintenant]
updatedAt: [timestamp maintenant]
```

---

## Étape 6: Lancer l'application

```bash
# Vérifier que tout est OK
flutter doctor

# Lancer sur Android
flutter run

# Ou sur Web
flutter run -d chrome

# Ou sur un émulateur spécifique
flutter devices
flutter run -d <device_id>
```

---

## Étape 7: Tester l'application

1. **S'inscrire**: 
   - Email: `test@example.com`
   - Password: `password123`

2. **Ajouter des fonds**:
   - Aller dans le wallet
   - Ajouter 100$ (simulé)
   - Approuver dans admin dashboard

3. **Passer une commande**:
   - Sélectionner un produit
   - Remplir l'adresse
   - Payer avec le wallet

4. **Admin Dashboard**:
   - Naviguer vers `/admin` manuellement
   - Voir les commandes
   - Mettre à jour les statuts

---

## 🎯 Points de contrôle

✅ Firebase projet créé
✅ Firestore Database activé
✅ Configuration Android/Web ajoutée
✅ `google-services.json` dans `android/app/`
✅ Règles Firestore configurées
✅ Au moins 1 produit ajouté dans Firestore
✅ `flutter pub get` exécuté
✅ Application lance sans erreur
✅ Connexion à Firestore fonctionne

---

## ⚠️ Problèmes courants

### Erreur: "No Firebase App"
- Vérifier que `google-services.json` est au bon endroit
- Vérifier que `com.google.gms.google-services` est dans `build.gradle`

### Erreur: "Firestore permission denied"
- Vérifier les règles Firestore (mode test = allow read, write: if true)

### Erreur: "minSdkVersion"
- Changer minSdkVersion à 21 minimum dans `android/app/build.gradle`

### Aucun produit ne s'affiche
- Vérifier qu'un produit existe dans Firestore collection `products`
- Vérifier les règles de lecture

### Erreur de connexion/inscription
- Vérifier que la collection `users` a les permissions de lecture/écriture

---

## 📱 Prochaines étapes

1. Personnaliser le design (couleurs, logo)
2. Ajouter plus de produits
3. Configurer Payeer pour vrais paiements
4. Ajouter un système de rôles admin
5. Améliorer les règles de sécurité Firestore
6. Ajouter Firebase Storage pour les images
7. Configurer Firebase Hosting pour le web

---

## 🔗 Ressources utiles

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)
- [Flutter Documentation](https://flutter.dev/docs)

---

## 💡 Astuce Pro

Pour développer plus vite, utilisez l'émulateur Firestore local:

```bash
firebase init emulators
firebase emulators:start
```

Puis dans votre code Flutter:
```dart
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
```
