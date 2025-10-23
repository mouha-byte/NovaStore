# 🎨 Guide pour Changer l'Icône de l'Application

## ✅ Nom Modifié Partout

Le nom de l'application a été changé de **NovaStoreAi** à **Nova Ai Market** dans tous les fichiers :

### Fichiers Modifiés :
1. ✅ `lib/utils/app_theme.dart` - Nom et copyright
2. ✅ `lib/utils/constants.dart` - Nom de l'app
3. ✅ `lib/widgets/nova_store_logo.dart` - Logo texte "Nova Ai Market"
4. ✅ `lib/screens/splash_screen_simple.dart` - Titre
5. ✅ `lib/screens/splash_screen_dynamic.dart` - Titre
6. ✅ `lib/screens/landing_sections/navigation_widgets.dart` - Navigation
7. ✅ `lib/screens/landing_sections/footer_section.dart` - Footer et copyright
8. ✅ `lib/screens/landing_page_screen.dart` - Copyright
9. ✅ `lib/widgets/ai_chatbot_widget.dart` - Email de support

---

## 📱 Comment Changer l'Icône de l'Application

### Méthode Recommandée : Utiliser flutter_launcher_icons

#### 1. Installer le package

Ajoutez dans `pubspec.yaml` :

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1
```

#### 2. Configurer les icônes

Ajoutez cette configuration dans `pubspec.yaml` :

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  
  # Pour Android avec icône adaptative
  adaptive_icon_background: "#8B5CF6"  # Couleur violet/gradient
  adaptive_icon_foreground: "assets/icon/app_icon_foreground.png"
  
  # Pour iOS
  remove_alpha_ios: true
  
  # Pour Web
  web:
    generate: true
    image_path: "assets/icon/app_icon.png"
    background_color: "#8B5CF6"
    theme_color: "#8B5CF6"
  
  # Pour Windows
  windows:
    generate: true
    image_path: "assets/icon/app_icon.png"
    icon_size: 48
```

#### 3. Créer vos icônes

**Taille recommandée :** 1024x1024 pixels (PNG)

Créez le dossier et l'image :
```
assets/
  icon/
    app_icon.png (1024x1024px)
    app_icon_foreground.png (1024x1024px, pour Android adaptatif)
```

#### 4. Générer les icônes

Exécutez dans le terminal :

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

---

## 🎨 Design de l'Icône Recommandé

Pour **Nova Ai Market**, voici des suggestions :

### Option 1 : Icône avec Étoile + IA
- Fond : Gradient violet/rose (#8B5CF6 → #EC4899)
- Symbole : Étoile brillante ⭐ avec circuit IA
- Style : Moderne, minimaliste

### Option 2 : Icône Shopping Bag + IA
- Fond : Gradient violet/rose
- Symbole : Sac shopping avec cerveau IA/circuits
- Style : Élégant et tech

### Option 3 : Lettre "N" Stylisée
- Fond : Gradient violet/rose
- Symbole : "N" moderne avec effet néon/IA
- Style : Bold et futuriste

---

## 🛠️ Méthode Manuelle (Alternative)

Si vous préférez ne pas utiliser le package :

### Android

1. Créez des icônes de différentes tailles :
   - `android/app/src/main/res/mipmap-mdpi/ic_launcher.png` (48x48)
   - `android/app/src/main/res/mipmap-hdpi/ic_launcher.png` (72x72)
   - `android/app/src/main/res/mipmap-xhdpi/ic_launcher.png` (96x96)
   - `android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png` (144x144)
   - `android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png` (192x192)

### iOS

1. Ouvrez `ios/Runner.xcworkspace` dans Xcode
2. Dans le navigateur de projet, cliquez sur `Runner` → `Assets.xcassets` → `AppIcon`
3. Glissez-déposez vos icônes dans les emplacements appropriés

### Web

Remplacez ces fichiers :
- `web/icons/Icon-192.png` (192x192)
- `web/icons/Icon-512.png` (512x512)
- `web/favicon.png` (16x16 ou 32x32)

---

## 📋 Checklist de Vérification

Après avoir changé l'icône :

- [ ] Tester sur Android (émulateur/appareil)
- [ ] Tester sur iOS (simulateur/appareil)
- [ ] Vérifier sur Web (navigateur)
- [ ] Vérifier l'icône dans la liste des apps
- [ ] Vérifier l'icône dans les notifications
- [ ] Vérifier l'icône sur l'écran d'accueil

---

## 🎯 Commandes Utiles

```bash
# Nettoyer le projet
flutter clean

# Réinstaller les dépendances
flutter pub get

# Générer les icônes
flutter pub run flutter_launcher_icons

# Reconstruire l'application
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
```

---

## 🆘 Problèmes Courants

**Problème :** L'icône ne change pas après la génération
- **Solution :** Désinstallez complètement l'app et réinstallez

**Problème :** Erreur lors de la génération
- **Solution :** Vérifiez que l'image est bien au format PNG et 1024x1024px

**Problème :** Icône déformée
- **Solution :** Assurez-vous que l'image est carrée avec des marges appropriées

---

## 💡 Outils en Ligne Recommandés

Pour créer/convertir des icônes :
- **Canva** (canva.com) - Design d'icône
- **AppIcon.co** - Générateur d'icônes multi-plateformes
- **Figma** - Design professionnel
- **IconKitchen** - Générateur Android adaptatif

---

## ✨ Résumé

✅ **Nom changé** : NovaStoreAi → **Nova Ai Market**
✅ **Logo mis à jour** : Affiche "Nova Ai Market"
✅ **Copyright** : © 2025 Nova Ai Market
✅ **Email support** : support@novaaimarket.com
✅ **Téléphone** : 1-800-NOVA-MARKET

🎨 **Prochaine étape** : Créer et configurer l'icône de l'application avec le package `flutter_launcher_icons`

---

**Créé le :** ${DateTime.now().toString().split(' ')[0]}
**Auteur :** GitHub Copilot
