# Exemples de données à ajouter manuellement dans Firestore

## Collection: products

### Document 1: product_001

```json
{
  "title": "Smart LED Watch 2025",
  "subtitle": "Get the #1 trending smartwatch in 2025",
  "description": "Experience the future with our revolutionary smart LED watch. Features include:\n\n✓ HD Display with vibrant colors\n✓ 7-day battery life\n✓ Water resistant (IP68)\n✓ Heart rate monitor\n✓ Sleep tracking\n✓ Multiple sport modes\n✓ Bluetooth connectivity\n\nPerfect for fitness enthusiasts and tech lovers!",
  "images": [
    "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800",
    "https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=800"
  ],
  "videos": [],
  "price": 24.99,
  "compareAtPrice": 39.99,
  "discountPercentage": 40,
  "variants": [
    {
      "variantId": "black",
      "title": "Black",
      "SKU": "LED-WATCH-BLK",
      "stock": 120,
      "price": 24.99
    },
    {
      "variantId": "silver",
      "title": "Silver",
      "SKU": "LED-WATCH-SLV",
      "stock": 80,
      "price": 27.99
    },
    {
      "variantId": "rose-gold",
      "title": "Rose Gold",
      "SKU": "LED-WATCH-RG",
      "stock": 60,
      "price": 29.99
    }
  ],
  "soldCount": 1247,
  "shippingETA": "5-10 business days",
  "returnPolicy": "30 days money-back guarantee",
  "createdAt": "2025-01-01T00:00:00Z",
  "updatedAt": "2025-01-01T00:00:00Z"
}
```

### Document 2: product_002

```json
{
  "title": "Wireless Earbuds Pro",
  "subtitle": "Premium sound quality meets comfort",
  "description": "Immerse yourself in crystal-clear audio with our latest wireless earbuds.\n\n✓ Active noise cancellation\n✓ 30-hour total battery life\n✓ IPX7 water resistance\n✓ Touch controls\n✓ Premium audio quality\n✓ Ergonomic design\n✓ Fast charging (15 min = 3 hours)\n\nYour perfect companion for music, calls, and workouts!",
  "images": [
    "https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800",
    "https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=800"
  ],
  "videos": [],
  "price": 34.99,
  "compareAtPrice": 59.99,
  "discountPercentage": 42,
  "variants": [
    {
      "variantId": "white",
      "title": "White",
      "SKU": "EARBUDS-WHT",
      "stock": 150,
      "price": 34.99
    },
    {
      "variantId": "black",
      "title": "Black",
      "SKU": "EARBUDS-BLK",
      "stock": 100,
      "price": 34.99
    }
  ],
  "soldCount": 892,
  "shippingETA": "7-12 business days",
  "returnPolicy": "30 days money-back guarantee",
  "createdAt": "2025-01-05T00:00:00Z",
  "updatedAt": "2025-01-05T00:00:00Z"
}
```

---

## Collection: users (exemple - créé automatiquement à l'inscription)

### Document: user_example

```json
{
  "email": "test@example.com",
  "password": "HASHED_PASSWORD_SHA256",
  "name": "Test User",
  "phone": "+33612345678",
  "walletBalance": 100.00,
  "addresses": [
    {
      "address": "123 Rue de la Paix",
      "city": "Paris",
      "state": "Île-de-France",
      "zip": "75001",
      "country": "France",
      "default": true
    }
  ],
  "createdAt": "2025-01-10T12:00:00Z",
  "updatedAt": "2025-01-10T12:00:00Z"
}
```

---

## Comment ajouter dans Firebase Console:

1. Aller sur https://console.firebase.google.com/
2. Sélectionner votre projet
3. Cliquer sur "Firestore Database" dans le menu
4. Cliquer sur "Démarrer en mode test" (pour développement)
5. Cliquer sur "Démarrer une collection"
6. Nom de la collection: `products`
7. Cliquer sur "ID de document automatique"
8. Copier-coller les champs depuis les exemples ci-dessus

**Note**: Pour les champs de type Timestamp (createdAt, updatedAt):
- Type: timestamp
- Valeur: Cliquer sur l'horloge et sélectionner la date/heure actuelle

**Note**: Pour les tableaux (images, variants):
- Type: array
- Ajouter chaque élément un par un

**Note**: Pour les objets imbriqués (variants):
- Type: map
- Ajouter chaque propriété une par une

---

## Images de test gratuites (Unsplash):

Si les liens d'images ne marchent pas, vous pouvez:

1. Utiliser des URLs Unsplash directement
2. Uploader vos propres images sur Firebase Storage
3. Utiliser des placeholders: `https://via.placeholder.com/800`

Exemple Firebase Storage:
```
gs://your-project.appspot.com/products/watch1.jpg
```

---

## Créer un utilisateur admin:

1. S'inscrire normalement via l'app
2. Dans Firestore Console, ouvrir le document user créé
3. Ajouter un champ: 
   - Nom: `isAdmin`
   - Type: boolean
   - Valeur: true

4. Ensuite, dans l'app, vous pourrez vérifier ce champ pour donner accès à `/admin`
