# Configuration Android pour Firebase

## Fichier: android/build.gradle

Ajouter dans `buildscript` → `dependencies`:

```gradle
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.google.gms:google-services:4.4.0'  // ← AJOUTER CETTE LIGNE
    }
}
```

---

## Fichier: android/app/build.gradle

### 1. Ajouter le plugin en haut (après les autres plugins):

```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
    id 'com.google.gms.google-services'  // ← AJOUTER CETTE LIGNE
}
```

### 2. Modifier minSdkVersion dans android → defaultConfig:

```gradle
android {
    namespace = "com.example.store_app2025"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    defaultConfig {
        applicationId = "com.example.store_app2025"
        minSdk = 21  // ← CHANGER DE 19 À 21 (minimum pour Firebase)
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode.toInteger()
        versionName = flutterVersionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.debug
        }
    }
}
```

---

## Fichier: android/app/google-services.json

Télécharger depuis Firebase Console et placer à:
```
android/app/google-services.json
```

**Important**: Ce fichier doit être dans `android/app/`, pas dans `android/`!

---

## Vérification

Après configuration, exécuter:

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

Si erreur "Task :app:processDebugGoogleServices", vérifier:
1. `google-services.json` est dans `android/app/`
2. Le plugin est bien ajouté dans `android/app/build.gradle`
3. Package name dans `google-services.json` correspond à `applicationId`

---

## Package Name

Le package name doit être cohérent partout:

- Firebase Console: `com.example.store_app2025`
- android/app/build.gradle → applicationId: `com.example.store_app2025`
- google-services.json → package_name: `com.example.store_app2025`

Pour changer le package name, voir:
https://stackoverflow.com/questions/51534616/how-to-change-package-name-in-flutter
