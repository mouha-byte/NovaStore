import 'package:flutter/material.dart';

/// Constants pour les sections de la page d'atterrissage
/// Produit: Mini Mixeur Bouteille USB Portable 380ml
class LandingConstants {
  // ==================== COULEURS ====================
  static const primaryColor = Color(0xFF6366F1);
  static const secondaryColor = Color(0xFF8B5CF6);
  static const darkGray = Color(0xFF1F2937);
  static const mediumGray = Color(0xFF6B7280);
  static const lightGray = Color(0xFF4B5563);
  static const yellow = Color(0xFFFBBF24);
  static const yellowAccent = Color(0xFFFBBF24);
  static const pinkAccent = Color(0xFFEC4899);
  static const redProblem = Color(0xFFEF4444);
  static const greenSolution = Color(0xFF10B981);
  static const blue = Color(0xFF3B82F6);
  static const purple = Color(0xFF8B5CF6);

  // ==================== BREAKPOINTS ====================
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  // ==================== IMAGES & ASSETS ====================
  // Images principales du produit pour le carrousel Hero (5 photos)
  static const String productImage = 'assets/images/product_hero.png';
  static const List<String> heroCarouselImages = [
    "assets/images/blender-portable-380ml-mixeur.webp",
    "assets/images/first.jpg",
    "assets/images/612wu4a5oeL._AC_UF1000,1000_QL80_.jpg",
    // "assets/images/lifestyle_nomad.png",
    "assets/images/71k-9Uit9SL.jpg",
    "assets/images/product_features.png",
  ];

  // Images pour les pain points
  static const String painPointWastedMoneyImage =
      'assets/images/problems/first.jpg'; // smoothie bar expensive
  static const String painPointTimeLostImage =
      'assets/images/problems/second.jpg'; // busy kitchen chaos
  static const String painPointPoorQualityImage =
      'assets/images/problems/third.jpg'; // unhealthy fast food

  // Images pour les solutions/bénéfices
  static const String benefitPremiumQualityImage =
      'assets/images/solution/first.jpg'; // portable blender charging
  static const String benefitSupportImage =
      'assets/images/solution/second.jpg'; // blender with fruits
  static const String benefitGuaranteeImage =
      'assets/images/solution/third.jpg'; // quick blend action
  // ==================== HERO SECTION ====================
  static const String heroTrendingBadge =
      '1 Meilleur Vente Ce Mois\nRemain only 20 in stock! Hurry up!';
  static const String heroSubtitle =
      'Des Smoothies Frais Partout, À Tout Moment - Rechargeable, Portable et Ultra-Pratique';

  static const List<HeroBadge> heroBadges = [
    HeroBadge(icon: Icons.verified_user, text: 'Garantie 30 Jours'),
    HeroBadge(icon: Icons.local_shipping, text: 'Livraison Gratuite'),
    HeroBadge(icon: Icons.star, text: '4.9/5 (1,200+ Avis)'),
  ];

  static const String heroCTA = 'Commandez Maintenant';
  static const String heroFinePrint =
      '✓ Aucune carte requise  ✓ Annulation à tout moment';

  // ==================== PROBLEM SECTION ====================
  static const String problemBadge =
      'LE PROBLÈME\nQUE NOUS RÉSOLVONS\nPOUR NOS CLIENTS';
  static const String problemTitle =
      'Fatigué de Ne Pas Pouvoir Préparer Vos Smoothies En Déplacement?';
  static const String problemDescription =
      'Vous voulez manger sainement mais vous manquez de temps. Les mixeurs classiques sont '
      'trop encombrants. Les bouteilles ordinaires ne peuvent pas mixer vos fruits. '
      'Vous finissez par acheter des smoothies chers et sucrés en magasin.';

  static const List<PainPoint> painPoints = [
    PainPoint(
      emoji: '💸',
      title: 'Argent Gaspillé',
      description:
          'Dépenser 5-8€ par jour en smoothies en magasin, alors que vous pourriez les faire vous-même',
      imageUrl: painPointWastedMoneyImage,
    ),
    PainPoint(
      emoji: '⏰',
      title: 'Perte de Temps',
      description:
          'Les mixeurs traditionnels sont trop gros, difficiles à nettoyer et impossibles à emporter',
      imageUrl: painPointTimeLostImage,
    ),
    PainPoint(
      emoji: '😤',
      title: 'Santé Négligée',
      description:
          'Impossible de maintenir une alimentation saine avec un mode de vie actif et mobile',
      imageUrl: painPointPoorQualityImage,
    ),
  ];

  // ==================== SOLUTION SECTION ====================
  static const String solutionBadge = 'LA SOLUTION';
  static const String solutionTitle =
      'Mini Mixeur Bouteille USB Portable 380ml - Votre Allié Santé';
  static const String solutionDescription =
      'Enfin, un mixeur vraiment portable. Rechargeable par USB, capacité parfaite de 380ml, '
      'lames en acier inoxydable durables. Mixez et buvez directement dans la même bouteille!';

  static const List<Benefit> benefits = [
    Benefit(
      icon: Icons.nat,
      title: "",
      description: "",
      color:Colors.transparent,
      imageUrl: benefitPremiumQualityImage,
    ),
    Benefit(
      icon: Icons.blender,
      title: 'Bouteille-Mixeur 2-en-1',
      description:
          'Mixez vos fruits directement dans la bouteille de 380ml pour une consommation immédiate',
      color: blue,
      imageUrl: benefitSupportImage,
    ),
    Benefit(
      icon: Icons.flash_on,
      title: 'Fonctionnement Simple',
      description:
          'Démarrage par double-clic pour un mixage rapide et intuitif',
      color: purple,
      imageUrl: benefitGuaranteeImage,
    ),
  ];

  static const List<String> keyFeatures = [
    '🍹 Idéal pour Smoothies: Parfait pour les fruits, légumes, poudres de protéines et shakers',
    '🚀 Ultra-Portable: Design compact et léger avec un anneau de transport pratique',
    '🔪 Lames Acier Inoxydable: Lames intégrées pour un mixage efficace et durable',
    '🔋 Autonomie Longue Durée: Plusieurs utilisations avec une seule charge',
    '💧 Facile à Nettoyer: Rinçage simple sous l\'eau courante',
    '🌍 Écologique: Réduisez les déchets plastiques des bouteilles jetables',
  ];

  // ==================== FEATURES SECTION ====================
  static const String featuresBadge = 'CARACTÉRISTIQUES';
  static const String featuresTitle =
      'Tout Ce Dont Vous Avez Besoin Pour Des Smoothies Parfaits';
  static const String featuresDescription =
      'Conçu avec soin pour vous offrir la meilleure expérience de mixage portable.';

  static const List<Feature> features = [
    Feature(
      title: 'Recharge USB Universelle',
      description:
          'Compatible avec tous vos appareils: Powerbank, PC, chargeur voiture, prise murale.',
      icon: Icons.usb,
      color: Color(0xFFEF4444),
      imageUrl: 'assets/images/caracteristics/first.webp',
    ),
    Feature(
      title: 'Capacité Parfaite 380ml',
      description:
          'La taille idéale pour une portion individuelle. Pas trop grand, pas trop petit. Parfait pour votre smoothie quotidien',
      icon: Icons.local_drink,
      color: Color(0xFF10B981),
      imageUrl: 'assets/images/caracteristics/second.jpg',
    ),
    Feature(
      title: 'Lames Acier Inoxydable',
      description:
          'Lames professionnelles en acier inoxydable qui ne rouillent jamais. Mixe fruits, glace et légumes sans effort',
      icon: Icons.settings,
      color: Color(0xFF3B82F6),
      imageUrl: 'assets/images/caracteristics/third.webp',
    ),
    Feature(
      title: 'Double-Clic Simple',
      description:
          'Démarrage intuitif par double-clic. Pas de boutons compliqués, pas de modes multiples. Simple et efficace',
      icon: Icons.touch_app,
      color: Color(0xFF8B5CF6),
      imageUrl: 'assets/images/caracteristics/fourth.jpg',
    ),
    Feature(
      title: 'Design Ultra-Portable',
      description:
          'Léger et compact avec anneau de transport. Glissez-le dans votre sac de sport, sac à dos ou porte-gobelet',
      icon: Icons.luggage,
      color: Color(0xFFF59E0B),
      imageUrl: 'assets/images/caracteristics/five.jpg',
    ),
    Feature(
      title: 'Matériaux Sûrs',
      description:
          'Plastique sans BPA et acier inoxydable de qualité alimentaire. Sain pour vous et votre famille',
      icon: Icons.verified_user,
      color: Color(0xFFEC4899),
      imageUrl: 'assets/images/caracteristics/six.webp',
    ),
  ];

  // ==================== HOW IT WORKS SECTION ====================
  static const String howItWorksBadge = 'COMMENT ÇA MARCHE';
  static const String howItWorksTitle = 'Simple, Rapide, Efficace';
  static const String howItWorksDescription =
      'En seulement 3 étapes simples, profitez de smoothies frais partout.';

  static const List<HowItWorksStep> howItWorksSteps = [
    HowItWorksStep(
      number: 1,
      title: 'Remplissez',
      description:
          'Ajoutez vos fruits, légumes ou ingrédients préférés dans la bouteille. Coupez-les en petits morceaux',
      icon: Icons.add_circle_outline,
      color: Color(0xFF3B82F6),
    ),
    HowItWorksStep(
      number: 2,
      title: 'Double-Cliquez',
      description:
          'Fermez le couvercle et double-cliquez sur le bouton. Le mixage commence automatiquement pendant 40 secondes',
      icon: Icons.power_settings_new,
      color: Color(0xFF10B981),
    ),
    HowItWorksStep(
      number: 3,
      title: 'Dégustez',
      description:
          'Retirez les lames, fixez le couvercle à boire et savourez votre smoothie frais immédiatement',
      icon: Icons.celebration,
      color: Color(0xFFF59E0B),
    ),
  ];

  // ==================== TESTIMONIALS SECTION ====================
  static const String testimonialsBadge = 'TÉMOIGNAGES';
  static const String testimonialsTitle = 'Ce Que Disent Nos Clients';
  static const String testimonialsDescription =
      'Ne nous croyez pas sur parole. Découvrez ce que nos vrais clients pensent.';

  static const List<Testimonial> testimonials = [
    Testimonial(
      name: 'Christophe L.',
      status: 'Achat Vérifié',
      rating: 5,
      review:
          '"Parfait pour mes smoothies du matin! Je l\'utilise tous les jours avant le sport. La capacité de 380ml est idéale et se nettoie en 30 secondes. Je recommande à 100%!"',
      avatarUrl: 'assets/images/clients/first_man.png',
      timeAgo: 'Il y a 2 semaines',
    ),
    Testimonial(
      name: 'Layoun D.',
      status: 'Achat Vérifié',
      rating: 5,
      review:
          '"Je l\'emmène partout: au bureau, à la salle de sport, en voyage. La recharge USB est super pratique. Les lames sont puissantes, même pour les fruits congelés!"',
avatarUrl:"assets/images/clients/second_man.jpg"      ,timeAgo: 'Il y a 1 mois',
    ),
    Testimonial(
      name: 'Amélie R.',
      status: 'Achat Vérifié',
      rating: 5,
      review:
          '"Excellent rapport qualité-prix! Fini les smoothies à 7€ en magasin. En une semaine, je l\'ai déjà rentabilisé. Mes enfants adorent faire leurs propres mélanges!"',
      avatarUrl: 'assets/images/clients/third_woman.png',
      timeAgo: 'Il y a 3 jours',
    ),
    Testimonial(
      name: 'Thomas B.',
      status: 'Achat Vérifié',
      rating: 5,
      review:
          '"Compact et efficace! Je pensais que ce serait faible mais il mixe parfaitement. Le double-clic est génial, pas besoin de tenir le bouton. Design très réussi!"',
      avatarUrl: 'assets/images/clients/fourth_man.png',
      timeAgo: 'Il y a 1 semaine',
    ),
    Testimonial(
      name: 'Julie M.',
      status: 'Achat Vérifié',
      rating: 5,
      review:
          '"Game changer pour mon mode de vie actif! Je peux enfin manger sainement même avec mon emploi du temps chargé. La batterie tient super bien, je recharge une fois par semaine."',
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop',
      timeAgo: 'Il y a 5 jours',
    ),
    Testimonial(
      name: 'Pierre K.',
      status: 'Achat Vérifié',
      rating: 5,
      review:
          '"Livraison rapide, produit conforme. Les lames en inox sont de qualité, aucun problème après 2 mois d\'utilisation intensive. Le meilleur achat de l\'année!"',
      avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop',
      timeAgo: 'Il y a 2 semaines',
    ),
  ];

  // ==================== PRICING SECTION ====================

  static const String pricingBadge = 'TARIFS';
  static const String pricingTitle = 'Choisissez Votre Pack';
  static const String pricingDescription =
      'Tous les packs incluent notre garantie satisfait ou remboursé de 30 jours.';

  static const List<PricingPlan> pricingPlans = [
    PricingPlan(
      title: 'Solo',
      price: '27.99',
      originalPrice: '46',
      subtitle: 'Parfait pour essayer',
      features: [
        '1 Mini Mixeur',
        'Garantie 30 Jours',
        'Câble USB Inclus',
      ],
      color: Color(0xFF3B82F6),
      isPopular: false,
    ),
    PricingPlan(
      title: 'Duo',
      price: '52.99',
      originalPrice: '92',
      subtitle: 'Le Plus Populaire',
      features: [
        '2 Mini Mixeurs',
        'Livraison Gratuite',
        'Garantie 30 Jours',
        '2 Câbles USB',
      ],
      color: Color(0xFF10B981),
      isPopular: true,
    ),
    PricingPlan(
      title: 'Famille',
      price: '109.99',
      originalPrice: '184',
      subtitle: 'Meilleure Économie',
      features: [
        '4 Mini Mixeurs',
        'Livraison Gratuite',
        'Garantie 60 Jours',
        '4 Câbles USB',
        'Pack Accessoires',
      ],
      color: Color(0xFF8B5CF6),
      isPopular: false,
    ),
  ];

  // ========================================
  // Before/After Section
  // ========================================
  static const String beforeAfterBadge = 'TRANSFORMATION';
  static const String beforeAfterTitle = 'Voyez La Différence';
  static const String beforeAfterSubtitle =
      'Résultats réels de clients réels. Glissez pour comparer.';

  static const String beforeImageUrl =
      'assets/images/avant.png'; // Cuisine désorganisée
  static const String afterImageUrl =
      'assets/images/apres.jpg'; // Cuisine organisée avec smoothies

  static const List<ResultStat> resultStats = [
    ResultStat(
      value: '95%',
      label: 'Satisfaction',
      icon: Icons.trending_up,
    ),
    ResultStat(
      value: '2 Minutes',
      label: 'Temps Moyen',
      icon: Icons.schedule,
    ),
    ResultStat(
      value: '15K+',
      label: 'Smoothies Faits',
      icon: Icons.people,
    ),
  ];

  // ========================================
  // Comparison Section
  // ========================================
  static const String comparisonBadge = 'COMPARAISON';
  static const String comparisonTitle = 'Pourquoi Nous Sommes Différents';
  static const String comparisonSubtitle =
      'Découvrez comment nous nous démarquons de la concurrence.';

  static const List<ComparisonFeature> comparisonFeatures = [
    ComparisonFeature(
      feature: 'Rechargeable USB',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Capacité 380ml',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Lames Inox Premium',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Sans BPA',
      others: true,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Portable & Léger',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Garantie 2 Ans',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Livraison Gratuite',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Retours 30 Jours',
      others: false,
      ours: true,
    ),
  ];

  // ========================================
  // FAQ Section
  // ========================================
  static const String faqBadge = 'FAQ';
  static const String faqTitle = 'Questions Fréquentes';
  static const String faqSubtitle =
      'Vous avez des questions ? Nous avons les réponses.';
  static const String faqContactTitle = 'Encore des Questions ?';
  static const String faqContactSubtitle =
      'Notre équipe est disponible 24/7 pour vous aider';
  static const String faqContactButton = 'Contacter le Support';

  static const List<FAQItem> faqItems = [
    FAQItem(
      question: 'Combien de temps dure la livraison ?',
      answer:
          'Nous offrons une livraison express GRATUITE sur toutes les commandes. La plupart des commandes arrivent sous 2-3 jours ouvrables. Vous recevrez un numéro de suivi dès l\'expédition.',
    ),
    FAQItem(
      question: 'Quelle est votre politique de retour ?',
      answer:
          'Nous offrons une garantie satisfait ou remboursé de 30 jours. Si vous n\'êtes pas complètement satisfait, retournez-le pour un remboursement complet, sans question. Nous prenons même en charge les frais de retour.',
    ),
    FAQItem(
      question: 'Ce produit est-il sans danger ?',
      answer:
          'Absolument ! Notre mixeur est sans BPA et fabriqué avec des matériaux de qualité alimentaire. Les lames sont en acier inoxydable et le système USB est certifié sécuritaire.',
    ),
    FAQItem(
      question: 'Comment savoir si cela fonctionnera pour moi ?',
      answer:
          'Plus de 15 000 clients ont déjà fait des smoothies délicieux. De plus, avec notre garantie de 30 jours, vous pouvez l\'essayer sans risque. S\'il ne vous convient pas, vous êtes remboursé.',
    ),
    FAQItem(
      question: 'Qu\'est-ce qui différencie ce mixeur des autres ?',
      answer:
          'Nous utilisons des lames en inox premium, offrons une capacité idéale de 380ml, rechargeable USB, garantie 2 ans, et support 24/7. Nos clients nous notent 4.9/5 étoiles constamment.',
    ),
    FAQItem(
      question: 'Offrez-vous des prix en gros ?',
      answer:
          'Oui ! Contactez notre équipe commerciale pour les commandes de 10+ unités. Nous offrons des tarifs spéciaux pour les entreprises et revendeurs.',
    ),
    FAQItem(
      question: 'Le paiement est-il sécurisé ?',
      answer:
          'Votre sécurité est notre priorité. Nous utilisons un cryptage SSL 256 bits (le même niveau que les banques). Nous ne stockons jamais vos informations de paiement.',
    ),
    FAQItem(
      question: 'Puis-je suivre ma commande ?',
      answer:
          'Oui ! Une fois expédiée, vous recevrez un numéro de suivi par e-mail. Vous pouvez suivre votre colis en temps réel jusqu\'à sa livraison.',
    ),
  ];

  // ========================================
  // Trust Badges Section
  // ========================================
  static const String trustTitle = 'Achetez en Toute Confiance';
  static const String trustSubtitle =
      'Votre satisfaction et sécurité sont nos priorités absolues.';

  static const List<TrustBadge> trustBadges = [
    TrustBadge(
      icon: Icons.lock,
      title: 'Paiement Sécurisé',
      description: 'Cryptage SSL 256-bits protège vos données',
      color: Color(0xFF10B981),
    ),
    TrustBadge(
      icon: Icons.local_shipping,
      title: 'Livraison Gratuite',
      description: 'Livraison rapide à votre porte',
      color: Color(0xFF3B82F6),
    ),
    TrustBadge(
      icon: Icons.currency_exchange,
      title: 'Retours 30 Jours',
      description: 'Remboursement complet si insatisfait',
      color: Color(0xFFF59E0B),
    ),
    TrustBadge(
      icon: Icons.support_agent,
      title: 'Support 24/7',
      description: 'Toujours là pour vous aider',
      color: Color(0xFF8B5CF6),
    ),
    TrustBadge(
      icon: Icons.verified_user,
      title: 'Produits Authentiques',
      description: 'Garantie 100% authentique',
      color: Color(0xFFEF4444),
    ),
    TrustBadge(
      icon: Icons.shield,
      title: 'Garantie Incluse',
      description: 'Garantie fabricant de 2 ans',
      color: Color(0xFF06B6D4),
    ),
    TrustBadge(
      icon: Icons.credit_card,
      title: 'Paiements Multiples',
      description: 'Toutes cartes acceptées',
      color: Color(0xFFEC4899),
    ),
    TrustBadge(
      icon: Icons.eco,
      title: 'Éco-Responsable',
      description: 'Matériaux et emballage durables',
      color: Color(0xFF22C55E),
    ),
  ];

  static const List<TrustStat> trustStats = [
    TrustStat(value: '15 000+', label: 'Clients Satisfaits'),
    TrustStat(value: '4.9/5', label: 'Note Moyenne'),
    TrustStat(value: '98%', label: 'Taux de Satisfaction'),
    TrustStat(value: '< 24h', label: 'Temps de Réponse'),
  ];

  // ========================================
  // Lifestyle Section
  // ========================================
  static const String lifestyleBadge = 'MODE DE VIE';
  static const String lifestyleTitle =
      'Plus Qu\'un Produit, C\'est un Style de Vie';
  static const String lifestyleSubtitle =
      'Rejoignez des milliers qui ont transformé leur routine quotidienne.';

  static const List<LifestyleImage> lifestyleImages = [
    LifestyleImage(
      imageUrl:
          'https://images.unsplash.com/photo-1556912173-3bb406ef7e77?w=600&h=800&fit=crop',
      caption: 'Routine Matinale',
      height: 400,
    ),
    LifestyleImage(
      imageUrl:
          'assets/images/mode_de_vie/doctor.webp',
      caption: 'Travail Nomade',
      height: 250,
    ),
    LifestyleImage(
      imageUrl:
          'assets/images/mode_de_vie/pret_a_voyage.jpeg',
      caption: 'Prêt à Voyager',
      height: 250,
    ),
    LifestyleImage(
      imageUrl:
          'assets/images/mode_de_vie/salle_de_sport.webp',
      caption: 'Parfait Pour le Fitness',
      height: 400,
    ),
    LifestyleImage(
      imageUrl:
          'https://images.unsplash.com/photo-1609220136736-443140cffec6?w=600&h=800&fit=crop',
      caption: 'Approuvé en Famille',
      height: 400,
    ),
    LifestyleImage(
      imageUrl:
          'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?w=600&h=400&fit=crop',
      caption: 'Usage Professionnel',
      height: 250,
    ),
  ];

  // ========================================
  // Limited Offer Section
  // ========================================
  static const String offerBadge = '⚡ OFFRE À DURÉE LIMITÉE';
  static const String offerTitle = 'Ne Manquez Pas Cette Offre !';
  static const String offerSubtitle =
      'Réduction spéciale se terminant bientôt !';

  static const String offerPrice = '23';
  static const String offerOriginalPrice = '39';
  static const String offerSavePercent = 'ÉCONOMISEZ 40%';
  static const String offerCurrency = '€';

  static const String offerButtonText =
      'PROFITEZ DE VOTRE RÉDUCTION MAINTENANT';
  static const String offerSecureText =
      '🔒 Paiement sécurisé • Cryptage 256-bits';

  static const List<String> offerBonusItems = [
    '✓ Livraison Premium Gratuite',
    '✓ Garantie Étendue de 2 Ans',
    '✓ Pack Bonus Exclusif (valeur 15€)',
    '✓ Garantie Satisfait ou Remboursé 30 Jours',
  ];

  static const String offerTimerHours = 'HEURES';
  static const String offerTimerMinutes = 'MINUTES';
  static const String offerTimerSeconds = 'SECONDES';

  // ========================================
  // Videos Section
  // ========================================
  static const String videosBadge = 'VOYEZ-LE EN ACTION';
  static const String videosTitle = 'Regardez Comment Ça Fonctionne';
  static const String videosSubtitle =
      'Découvrez de vraies personnes obtenant de vrais résultats avec notre produit.';

  static const List<VideoItem> videoItems = [
    VideoItem(
      title: 'Easy to set up, short demonstration',
      views: '240K vues',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=800&h=500&fit=crop',
      duration: Duration(minutes: 4, seconds: 30),
      videoUrl: 'assets/videos/first.mp4',
    ),
    VideoItem(
      title: 'Easy to set up, short demonstration',
      views: '180K vues',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800&h=500&fit=crop',
      duration: Duration(minutes: 6, seconds: 15),
      videoUrl: 'assets/videos/second.mp4',
    ),
    VideoItem(
      title: 'Review Influencer',
      views: '320K vues',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1556909212-d5b604d0c90d?w=800&h=500&fit=crop',
      duration: Duration(minutes: 8, seconds: 42),
      videoUrl: 'assets/videos/third.mp4',
    ),
    VideoItem(
      title: 'Famille',
      views: '210K vues',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&h=500&fit=crop',
      duration: Duration(minutes: 5, seconds: 33),
      videoUrl: 'assets/videos/fourth.mp4',
    ),
  ];

  // ========================================
  // Final CTA Section
  // ========================================
  static const String finalCTATitle = 'Prêt à Transformer Votre Routine ?';
  static const String finalCTASubtitle =
      'Rejoignez plus de 15 000 clients satisfaits qui ont déjà fait le choix. '
      'Ne laissez pas passer cette opportunité.';
  static const String finalCTAButton = 'OBTENEZ LE VÔTRE MAINTENANT';

  static const String finalCTASecureCheckout = 'Paiement Sécurisé';
  static const String finalCTAGuarantee = 'Garantie 30 Jours';

  static const String finalCTARating = '4.9 sur 5 étoiles';
  static const String finalCTAReviewCount = 'Basé sur 1 200+ avis';

  static const List<FinalCTABenefit> finalCTABenefits = [
    FinalCTABenefit(icon: Icons.local_shipping, label: 'Livraison Gratuite'),
    FinalCTABenefit(icon: Icons.support_agent, label: 'Support 24/7'),
    FinalCTABenefit(icon: Icons.verified, label: 'Garantie 2 Ans'),
    FinalCTABenefit(icon: Icons.currency_exchange, label: 'Remboursement'),
  ];

  // ========================================
  // Brands Section
  // ========================================
  static const String brandsSectionTitle = 'Vu Dans Les Médias';

  static const List<BrandItem> brandsList = [
    BrandItem(name: 'Cuisine Magazine', logo: '🍴'),
    BrandItem(name: 'Santé Plus', logo: '💚'),
    BrandItem(name: 'Tech Daily', logo: '⚡'),
    BrandItem(name: 'Lifestyle Blog', logo: '🌟'),
    BrandItem(name: 'Sport & Nutrition', logo: '💪'),
    BrandItem(name: 'Home & Living', logo: '🏡'),
    BrandItem(name: 'Eco Friendly', logo: '🌱'),
    BrandItem(name: 'Family Guide', logo: '👨‍👩‍👧'),
  ];

  static const List<BrandStat> brandStats = [
    BrandStat(value: '15K+', label: 'Clients Satisfaits'),
    BrandStat(value: '4.9★', label: 'Note Moyenne'),
    BrandStat(value: '98%', label: 'Taux de Satisfaction'),
    BrandStat(value: '24/7', label: 'Support Disponible'),
  ];

  // ========================================
  // Customer Stories Section
  // ========================================
  static const String storiesBadge = 'HISTOIRES DE SUCCÈS';
  static const String storiesTitle =
      'Des Vraies Histoires, Des Vrais Résultats';
  static const String storiesSubtitle =
      'Découvrez comment notre mixeur a transformé la vie de nos clients.';

  static const List<CustomerStory> customerStories = [
    CustomerStory(
      title: 'De la Difficulté à la Réussite',
      subtitle: 'L\'Histoire de Marie',
      story:
          '"J\'étais très sceptique au début, mais ce mixeur portable a complètement changé ma routine matinale. '
          'En 30 jours, j\'ai remarqué une grande amélioration de mon énergie et de ma santé. Je prépare maintenant '
          'mes smoothies partout - au bureau, à la salle de sport, même en voyage. C\'est devenu mon compagnon '
          'indispensable et je le recommande à tous mes amis!"',
      imageUrl:
          'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800&h=500&fit=crop',
      accentColorValue: 0xFF3B82F6,
      imageOnLeft: true,
    ),
    CustomerStory(
      title: 'La Solution Professionnelle',
      subtitle: 'L\'Expérience de Thomas',
      story:
          '"En tant que sportif professionnel, j\'avais besoin d\'un mixeur fiable et pratique. Ce produit a dépassé '
          'toutes mes attentes. USB rechargeable, puissant, facile à nettoyer - tout ce dont j\'avais besoin. '
          'Ma performance s\'est améliorée grâce à une meilleure nutrition. Mes collègues me demandent constamment '
          'où je l\'ai acheté. C\'est un investissement qui vaut vraiment le coup!"',
      imageUrl:
          'assets/images/caracteristics/thomas.jpg',
      accentColorValue: 0xFF10B981,
      imageOnLeft: false,
    ),
    CustomerStory(
      title: 'La Transformation Familiale',
      subtitle: 'La Famille Dubois',
      story:
          '"Nous cherchions une solution pour que toute la famille mange plus sainement. Ce mixeur est parfait! '
          'Nos enfants adorent préparer leurs propres smoothies, et nous apprécions la facilité d\'utilisation. '
          'C\'est devenu un rituel familial du matin. Plus besoin d\'acheter des jus coûteux au supermarché. '
          'Nous économisons de l\'argent et mangeons plus sainement. On ne peut plus s\'en passer!"',
      imageUrl:
          'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=800&h=500&fit=crop',
      accentColorValue: 0xFF8B5CF6,
      imageOnLeft: true,
    ),
  ];
  // ========================================
  // Experts Section
  // ========================================
  static const String expertsBadge = 'RECOMMANDÉ PAR DES EXPERTS';
  static const String expertsTitle = 'Approuvé par les Professionnels';
  static const String expertsSubtitle =
      'Les experts de l\'industrie recommandent notre mixeur pour sa qualité et ses résultats.';

  static const List<ExpertEndorsement> expertEndorsements = [
    ExpertEndorsement(
      name: 'Dr. Marie Dubois',
      title: 'Nutritionniste Diplômée',
      credentials: 'Université Paris Sorbonne • 12 ans d\'expérience',
      quote:
          '"La qualité de ce mixeur portable est exceptionnelle. Les lames en acier inoxydable '
          'préservent tous les nutriments. Je le recommande à tous mes patients pour leurs smoothies quotidiens."',
      imageUrl:
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop',
      accentColorValue: 0xFF3B82F6,
    ),
    ExpertEndorsement(
      name: 'Thomas Martin',
      title: 'Coach Sportif Certifié',
      credentials: 'FitnessPro • 250K abonnés',
      quote:
          '"J\'ai testé des dizaines de mixeurs portables. Celui-ci surpasse tous les autres en termes '
          'de puissance et de portabilité. Idéal pour les athlètes et les personnes actives."',
      imageUrl:
          'assets/images/recommended/second.jpg',
      accentColorValue: 0xFF10B981,
    ),
    ExpertEndorsement(
      name: 'Sophie Laurent',
      title: 'Experte en Sécurité Alimentaire',
      credentials: 'Institut Sécurité Santé • Certifiée',
      quote:
          '"Après des tests rigoureux, ce produit dépasse toutes les normes de sécurité. Les matériaux '
          'sont sans BPA et totalement sûrs. C\'est efficace et sans danger."',
      imageUrl:
          'assets/images/recommended/third.jpg',
      accentColorValue: 0xFF8B5CF6,
    ),
  ];

  // ========================================
  // Manufacturing Section
  // ========================================
  static const String manufacturingBadge = 'ARTISANAT DE QUALITÉ';
  static const String manufacturingTitle =
      'Fabriqué avec Soin, Conçu pour Durer';
  static const String manufacturingSubtitle =
      'Chaque produit est fabriqué avec précision et attention aux détails.';

  static const List<ManufacturingProcess> manufacturingProcesses = [
    ManufacturingProcess(
      step: '1. Conception',
      description:
          'Notre équipe d\'experts conçoit chaque détail avec des logiciels de pointe',
      icon: Icons.draw,
      colorValue: 0xFF3B82F6,
      imageUrl:
          'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=600&h=400&fit=crop',
    ),
    ManufacturingProcess(
      step: '2. Matériaux',
      description:
          'Nous sélectionnons uniquement les meilleurs matériaux de fournisseurs certifiés',
      icon: Icons.inventory_2,
      colorValue: 0xFF10B981,
      imageUrl:
          'https://images.unsplash.com/photo-1565793298595-6a879b1d9492?w=600&h=400&fit=crop',
    ),
    ManufacturingProcess(
      step: '3. Fabrication',
      description:
          'Assemblage de précision par des artisans qualifiés avec des décennies d\'expérience',
      icon: Icons.settings,
      colorValue: 0xFFF59E0B,
      imageUrl:
          'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=600&h=400&fit=crop',
    ),
    ManufacturingProcess(
      step: '4. Contrôle Qualité',
      description:
          'Chaque unité subit des tests rigoureux pour garantir nos normes élevées',
      icon: Icons.verified,
      colorValue: 0xFF8B5CF6,
      imageUrl:
          'assets/images/caracteristics/controle_qualite.jpg',
    ),
  ];

  static const String certificationTitle = 'Certifié et Approuvé';

  static const List<Certification> certifications = [
    Certification(label: 'CE Européen', icon: Icons.verified_user),
    Certification(label: 'Normes FDA', icon: Icons.gpp_good),
    Certification(label: 'Sans BPA', icon: Icons.eco),
    Certification(label: 'Garantie 2 Ans', icon: Icons.check_circle),
  ];
}

// ==================== MODÈLES DE DONNÉES ====================
class HeroBadge {
  final IconData icon;
  final String text;

  const HeroBadge({required this.icon, required this.text});
}

class PainPoint {
  final String emoji;
  final String title;
  final String description;
  final String imageUrl;

  const PainPoint({
    required this.emoji,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class Benefit {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final String imageUrl;

  const Benefit({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.imageUrl,
  });
}

class Feature {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String imageUrl;

  const Feature({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.imageUrl,
  });
}

class HowItWorksStep {
  final int number;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const HowItWorksStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class Testimonial {
  final String name;
  final String status;
  final int rating;
  final String review;
  final String avatarUrl;
  final String timeAgo;

  const Testimonial({
    required this.name,
    required this.status,
    required this.rating,
    required this.review,
    required this.avatarUrl,
    required this.timeAgo,
  });
}

class PricingPlan {
  final String title;
  final String price;
  final String originalPrice;
  final String subtitle;
  final List<String> features;
  final Color color;
  final bool isPopular;

  const PricingPlan({
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.subtitle,
    required this.features,
    required this.color,
    required this.isPopular,
  });
}

class ResultStat {
  final String value;
  final String label;
  final IconData icon;

  const ResultStat({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class ComparisonFeature {
  final String feature;
  final bool others;
  final bool ours;

  const ComparisonFeature({
    required this.feature,
    required this.others,
    required this.ours,
  });
}

class FAQItem {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
  });
}

class TrustBadge {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const TrustBadge({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class TrustStat {
  final String value;
  final String label;

  const TrustStat({
    required this.value,
    required this.label,
  });
}

class LifestyleImage {
  final String imageUrl;
  final String caption;
  final double height;

  const LifestyleImage({
    required this.imageUrl,
    required this.caption,
    required this.height,
  });
}

class VideoItem {
  final String title;
  final String views;
  final String thumbnailUrl;
  final Duration duration;
  final String videoUrl;

  const VideoItem({
    required this.title,
    required this.views,
    required this.thumbnailUrl,
    required this.duration,
    required this.videoUrl,
  });
}

class FinalCTABenefit {
  final IconData icon;
  final String label;

  const FinalCTABenefit({
    required this.icon,
    required this.label,
  });
}

class BrandItem {
  final String name;
  final String logo;

  const BrandItem({
    required this.name,
    required this.logo,
  });
}

class BrandStat {
  final String value;
  final String label;

  const BrandStat({
    required this.value,
    required this.label,
  });
}

class CustomerStory {
  final String title;
  final String subtitle;
  final String story;
  final String imageUrl;
  final int accentColorValue;
  final bool imageOnLeft;

  const CustomerStory({
    required this.title,
    required this.subtitle,
    required this.story,
    required this.imageUrl,
    required this.accentColorValue,
    required this.imageOnLeft,
  });
}

class ExpertEndorsement {
  final String name;
  final String title;
  final String credentials;
  final String quote;
  final String imageUrl;
  final int accentColorValue;

  const ExpertEndorsement({
    required this.name,
    required this.title,
    required this.credentials,
    required this.quote,
    required this.imageUrl,
    required this.accentColorValue,
  });
}

class ManufacturingProcess {
  final String step;
  final String description;
  final IconData icon;
  final int colorValue;
  final String imageUrl;

  const ManufacturingProcess({
    required this.step,
    required this.description,
    required this.icon,
    required this.colorValue,
    required this.imageUrl,
  });
}

class Certification {
  final String label;
  final IconData icon;

  const Certification({
    required this.label,
    required this.icon,
  });
}
