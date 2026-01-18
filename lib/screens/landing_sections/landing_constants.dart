import 'package:flutter/material.dart';

/// Constants for the landing page sections
/// Product: Mini Portable USB Blender Bottle 380ml
class LandingConstants {
  // ==================== COLORS ====================
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
  // Main product images for Hero carousel (5 photos)
  static const String productImage = 'assets/images/product_hero.png';
  static const List<String> heroCarouselImages = [
    "assets/images/blender-portable-380ml-mixeur.webp",
    "assets/images/first.jpg",
    "assets/images/612wu4a5oeL._AC_UF1000,1000_QL80_.jpg",
    "assets/images/71k-9Uit9SL.jpg",
    "assets/images/product_features.png",
  ];

  // Images for pain points
  static const String painPointWastedMoneyImage =
      'assets/images/problems/first.jpg';
  static const String painPointTimeLostImage =
      'assets/images/problems/second.jpg';
  static const String painPointPoorQualityImage =
      'assets/images/problems/third.jpg';

  // Images for solutions/benefits
  static const String benefitPremiumQualityImage =
      'assets/images/solution/first.jpg';
  static const String benefitSupportImage =
      'assets/images/solution/second.jpg';
  static const String benefitGuaranteeImage =
      'assets/images/solution/third.jpg';

  // ==================== HERO SECTION ====================
  static const String heroTrendingBadge =
      '#1 Best Seller This Month\nOnly 20 left in stock! Hurry up!';
  static const String heroSubtitle =
      'Fresh Smoothies Anywhere, Anytime - Rechargeable, Portable and Ultra-Convenient';

  static const List<HeroBadge> heroBadges = [
    HeroBadge(icon: Icons.verified_user, text: '30-Day Guarantee'),
    HeroBadge(icon: Icons.local_shipping, text: 'Free Shipping'),
    HeroBadge(icon: Icons.star, text: '4.9/5 (1,200+ Reviews)'),
  ];

  static const String heroCTA = 'Order Now';
  static const String heroFinePrint =
      '✓ No card required  ✓ Cancel anytime';

  // ==================== PROBLEM SECTION ====================
  static const String problemBadge =
      'THE PROBLEM\nWE SOLVE\nFOR OUR CUSTOMERS';
  static const String problemTitle =
      'Tired of Not Being Able to Make Your Smoothies On-The-Go?';
  static const String problemDescription =
      'You want to eat healthy but you\'re short on time. Traditional blenders are '
      'too bulky. Regular bottles can\'t blend your fruits. '
      'You end up buying expensive, sugary smoothies at stores.';

  static const List<PainPoint> painPoints = [
    PainPoint(
      emoji: '💸',
      title: 'Wasted Money',
      description:
          'Spending \$5-8 per day on store smoothies when you could make them yourself',
      imageUrl: painPointWastedMoneyImage,
    ),
    PainPoint(
      emoji: '⏰',
      title: 'Time Lost',
      description:
          'Traditional blenders are too big, hard to clean and impossible to carry',
      imageUrl: painPointTimeLostImage,
    ),
    PainPoint(
      emoji: '😤',
      title: 'Neglected Health',
      description:
          'Impossible to maintain a healthy diet with an active, mobile lifestyle',
      imageUrl: painPointPoorQualityImage,
    ),
  ];

  // ==================== SOLUTION SECTION ====================
  static const String solutionBadge = 'THE SOLUTION';
  static const String solutionTitle =
      'Mini Portable USB Blender Bottle 380ml - Your Health Companion';
  static const String solutionDescription =
      'Finally, a truly portable blender. USB rechargeable, perfect 380ml capacity, '
      'durable stainless steel blades. Blend and drink directly from the same bottle!';

  static const List<Benefit> benefits = [
    Benefit(
      icon: Icons.high_quality,
      title: 'Premium Quality',
      description:
        'Durable, BPA-free materials with stainless steel blades for consistent, long-lasting performance.',
      color: greenSolution,
      imageUrl: benefitPremiumQualityImage,
    ),
    Benefit(
      icon: Icons.blender,
      title: '2-in-1 Bottle-Blender',
      description:
        'Blend your fruits directly in the 380ml bottle for immediate consumption',
      color: blue,
      imageUrl: benefitSupportImage,
    ),
    Benefit(
      icon: Icons.flash_on,
      title: 'Simple Operation',
      description:
          'Double-click start for quick and intuitive blending',
      color: purple,
      imageUrl: benefitGuaranteeImage,
    ),
  ];

  static const List<String> keyFeatures = [
    '🍹 Ideal for Smoothies: Perfect for fruits, vegetables, protein powders and shakes',
    '🚀 Ultra-Portable: Compact and lightweight design with convenient carrying loop',
    '🔪 Stainless Steel Blades: Built-in blades for efficient and durable blending',
    '🔋 Long Battery Life: Multiple uses on a single charge',
    '💧 Easy to Clean: Simple rinse under running water',
    '🌍 Eco-Friendly: Reduce plastic waste from disposable bottles',
  ];

  // ==================== FEATURES SECTION ====================
  static const String featuresBadge = 'FEATURES';
  static const String featuresTitle =
      'Everything You Need for Perfect Smoothies';
  static const String featuresDescription =
      'Carefully designed to give you the best portable blending experience.';

  static const List<Feature> features = [
    Feature(
      title: 'Universal USB Charging',
      description:
          'Compatible with all your devices: Powerbank, PC, car charger, wall outlet.',
      icon: Icons.usb,
      color: Color(0xFFEF4444),
      imageUrl: 'assets/images/caracteristics/first.webp',
    ),
    Feature(
      title: 'Perfect 380ml Capacity',
      description:
          'The ideal size for a single serving. Not too big, not too small. Perfect for your daily smoothie',
      icon: Icons.local_drink,
      color: Color(0xFF10B981),
      imageUrl: 'assets/images/caracteristics/second.jpg',
    ),
    Feature(
      title: 'Stainless Steel Blades',
      description:
          'Professional stainless steel blades that never rust. Blends fruits, ice and vegetables effortlessly',
      icon: Icons.settings,
      color: Color(0xFF3B82F6),
      imageUrl: 'assets/images/caracteristics/third.webp',
    ),
    Feature(
      title: 'Simple Double-Click',
      description:
          'Intuitive double-click start. No complicated buttons, no multiple modes. Simple and effective',
      icon: Icons.touch_app,
      color: Color(0xFF8B5CF6),
      imageUrl: 'assets/images/caracteristics/fourth.jpg',
    ),
    Feature(
      title: 'Ultra-Portable Design',
      description:
          'Lightweight and compact with carrying loop. Fits in your gym bag, backpack or cup holder',
      icon: Icons.luggage,
      color: Color(0xFFF59E0B),
      imageUrl: 'assets/images/caracteristics/five.jpg',
    ),
    Feature(
      title: 'Safe Materials',
      description:
          'BPA-free plastic and food-grade stainless steel. Healthy for you and your family',
      icon: Icons.verified_user,
      color: Color(0xFFEC4899),
      imageUrl: 'assets/images/caracteristics/six.webp',
    ),
  ];

  // ==================== HOW IT WORKS SECTION ====================
  static const String howItWorksBadge = 'HOW IT WORKS';
  static const String howItWorksTitle = 'Simple, Fast, Effective';
  static const String howItWorksDescription =
      'In just 3 simple steps, enjoy fresh smoothies anywhere.';

  static const List<HowItWorksStep> howItWorksSteps = [
    HowItWorksStep(
      number: 1,
      title: 'Fill',
      description:
          'Add your fruits, vegetables or favorite ingredients to the bottle. Cut them into small pieces',
      icon: Icons.add_circle_outline,
      color: Color(0xFF3B82F6),
    ),
    HowItWorksStep(
      number: 2,
      title: 'Double-Click',
      description:
          'Close the lid and double-click the button. Blending starts automatically for 40 seconds',
      icon: Icons.power_settings_new,
      color: Color(0xFF10B981),
    ),
    HowItWorksStep(
      number: 3,
      title: 'Enjoy',
      description:
          'Remove the blades, attach the drinking lid and savor your fresh smoothie immediately',
      icon: Icons.celebration,
      color: Color(0xFFF59E0B),
    ),
  ];

  // ==================== TESTIMONIALS SECTION ====================
  static const String testimonialsBadge = 'TESTIMONIALS';
  static const String testimonialsTitle = 'What Our Customers Say';
  static const String testimonialsDescription =
      'Don\'t take our word for it. Discover what our real customers think.';

  static const List<Testimonial> testimonials = [
    Testimonial(
      name: 'Christopher L.',
      status: 'Verified Purchase',
      rating: 5,
      review:
          '"Perfect for my morning smoothies! I use it every day before the gym. The 380ml capacity is ideal and it cleans in 30 seconds. I recommend it 100%!"',
      avatarUrl: 'assets/images/clients/first_man.png',
      timeAgo: '2 weeks ago',
    ),
    Testimonial(
      name: 'Layoun D.',
      status: 'Verified Purchase',
      rating: 5,
      review:
          '"I take it everywhere: to the office, to the gym, on trips. The USB charging is super convenient. The blades are powerful, even for frozen fruits!"',
      avatarUrl: "assets/images/clients/second_man.jpg",
      timeAgo: '1 month ago',
    ),
    Testimonial(
      name: 'Emily R.',
      status: 'Verified Purchase',
      rating: 5,
      review:
          '"Excellent value for money! No more \$7 smoothies at the store. In one week, it already paid for itself. My kids love making their own blends!"',
      avatarUrl: 'assets/images/clients/third_woman.jpg',
      timeAgo: '3 days ago',
    ),
    Testimonial(
      name: 'Thomas B.',
      status: 'Verified Purchase',
      rating: 5,
      review:
          '"Compact and efficient! I thought it would be weak but it blends perfectly. The double-click is genius, no need to hold the button. Very successful design!"',
      avatarUrl: 'assets/images/clients/fourth_man.jpg',
      timeAgo: '1 week ago',
    ),
    Testimonial(
      name: 'Julie M.',
      status: 'Verified Purchase',
      rating: 5,
      review:
          '"Game changer for my active lifestyle! I can finally eat healthy even with my busy schedule. The battery holds up great, I charge once a week."',
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop',
      timeAgo: '5 days ago',
    ),
    Testimonial(
      name: 'Peter K.',
      status: 'Verified Purchase',
      rating: 5,
      review:
          '"Fast delivery, product as described. The stainless steel blades are quality, no issues after 2 months of intensive use. Best purchase of the year!"',
      avatarUrl: '',
      timeAgo: '2 weeks ago',
    ),
  ];

  // ==================== PRICING SECTION ====================

  static const String pricingBadge = 'PRICING';
  static const String pricingTitle = 'Choose Your Pack';
  static const String pricingDescription =
      'All packs include our 30-day money-back guarantee.';

  static const List<PricingPlan> pricingPlans = [
    PricingPlan(
      title: 'Solo',
      price: '27.99',
      originalPrice: '46',
      subtitle: 'Perfect to try',
      features: [
        '1 Mini Blender',
        '30-Day Guarantee',
        'USB Cable Included',
      ],
      color: Color(0xFF3B82F6),
      isPopular: false,
    ),
    PricingPlan(
      title: 'Duo',
      price: '52.99',
      originalPrice: '92',
      subtitle: 'Most Popular',
      features: [
        '2 Mini Blenders',
        'Free Shipping',
        '30-Day Guarantee',
        '2 USB Cables',
      ],
      color: Color(0xFF10B981),
      isPopular: true,
    ),
    PricingPlan(
      title: 'Family',
      price: '109.99',
      originalPrice: '184',
      subtitle: 'Best Savings',
      features: [
        '4 Mini Blenders',
        'Free Shipping',
        '60-Day Guarantee',
        '4 USB Cables',
        'Accessory Pack',
      ],
      color: Color(0xFF8B5CF6),
      isPopular: false,
    ),
  ];

  // ========================================
  // Before/After Section
  // ========================================
  static const String beforeAfterBadge = 'TRANSFORMATION';
  static const String beforeAfterTitle = 'See The Difference';
  static const String beforeAfterSubtitle =
      'Real results from real customers. Slide to compare.';

  static const String beforeImageUrl =
      'assets/images/avant.png';
  static const String afterImageUrl =
      'assets/images/apres.jpg';

  static const List<ResultStat> resultStats = [
    ResultStat(
      value: '95%',
      label: 'Satisfaction',
      icon: Icons.trending_up,
    ),
    ResultStat(
      value: '2 Minutes',
      label: 'Average Time',
      icon: Icons.schedule,
    ),
    ResultStat(
      value: '15K+',
      label: 'Smoothies Made',
      icon: Icons.people,
    ),
  ];

  // ========================================
  // Comparison Section
  // ========================================
  static const String comparisonBadge = 'COMPARISON';
  static const String comparisonTitle = 'Why We\'re Different';
  static const String comparisonSubtitle =
      'Discover how we stand out from the competition.';

  static const List<ComparisonFeature> comparisonFeatures = [
    ComparisonFeature(
      feature: 'USB Rechargeable',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: '380ml Capacity',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Premium Stainless Blades',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'BPA Free',
      others: true,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Portable & Lightweight',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: '2-Year Warranty',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: 'Free Shipping',
      others: false,
      ours: true,
    ),
    ComparisonFeature(
      feature: '30-Day Returns',
      others: false,
      ours: true,
    ),
  ];

  // ========================================
  // FAQ Section
  // ========================================
  static const String faqBadge = 'FAQ';
  static const String faqTitle = 'Frequently Asked Questions';
  static const String faqSubtitle =
      'Got questions? We\'ve got answers.';
  static const String faqContactTitle = 'Still Have Questions?';
  static const String faqContactSubtitle =
      'Our team is available 24/7 to help you';
  static const String faqContactButton = 'Contact Support';

  static const List<FAQItem> faqItems = [
    FAQItem(
      question: 'How long does shipping take?',
      answer:
          'We offer FREE express shipping on all orders. Most orders arrive within 2-3 business days. You\'ll receive a tracking number once shipped.',
    ),
    FAQItem(
      question: 'What is your return policy?',
      answer:
          'We offer a 30-day money-back guarantee. If you\'re not completely satisfied, return it for a full refund, no questions asked. We even cover return shipping.',
    ),
    FAQItem(
      question: 'Is this product safe?',
      answer:
          'Absolutely! Our blender is BPA-free and made with food-grade materials. The blades are stainless steel and the USB system is safety certified.',
    ),
    FAQItem(
      question: 'How do I know if this will work for me?',
      answer:
          'Over 15,000 customers have already made delicious smoothies. Plus, with our 30-day guarantee, you can try it risk-free. If it doesn\'t suit you, you\'re refunded.',
    ),
    FAQItem(
      question: 'What makes this blender different from others?',
      answer:
          'We use premium stainless steel blades, offer an ideal 380ml capacity, USB rechargeable, 2-year warranty, and 24/7 support. Our customers consistently rate us 4.9/5 stars.',
    ),
    FAQItem(
      question: 'Do you offer bulk pricing?',
      answer:
          'Yes! Contact our sales team for orders of 10+ units. We offer special rates for businesses and resellers.',
    ),
    FAQItem(
      question: 'Is the payment secure?',
      answer:
          'Your security is our priority. We use 256-bit SSL encryption (the same level as banks). We never store your payment information.',
    ),
    FAQItem(
      question: 'Can I track my order?',
      answer:
          'Yes! Once shipped, you\'ll receive a tracking number by email. You can track your package in real-time until delivery.',
    ),
  ];

  // ========================================
  // Trust Badges Section
  // ========================================
  static const String trustTitle = 'Shop with Confidence';
  static const String trustSubtitle =
      'Your satisfaction and security are our top priorities.';

  static const List<TrustBadge> trustBadges = [
    TrustBadge(
      icon: Icons.lock,
      title: 'Secure Payment',
      description: '256-bit SSL encryption protects your data',
      color: Color(0xFF10B981),
    ),
    TrustBadge(
      icon: Icons.local_shipping,
      title: 'Free Shipping',
      description: 'Fast delivery to your door',
      color: Color(0xFF3B82F6),
    ),
    TrustBadge(
      icon: Icons.currency_exchange,
      title: '30-Day Returns',
      description: 'Full refund if not satisfied',
      color: Color(0xFFF59E0B),
    ),
    TrustBadge(
      icon: Icons.support_agent,
      title: '24/7 Support',
      description: 'Always here to help you',
      color: Color(0xFF8B5CF6),
    ),
    TrustBadge(
      icon: Icons.verified_user,
      title: 'Authentic Products',
      description: '100% authenticity guaranteed',
      color: Color(0xFFEF4444),
    ),
    TrustBadge(
      icon: Icons.shield,
      title: 'Warranty Included',
      description: '2-year manufacturer warranty',
      color: Color(0xFF06B6D4),
    ),
    TrustBadge(
      icon: Icons.credit_card,
      title: 'Multiple Payments',
      description: 'All cards accepted',
      color: Color(0xFFEC4899),
    ),
    TrustBadge(
      icon: Icons.eco,
      title: 'Eco-Responsible',
      description: 'Sustainable materials and packaging',
      color: Color(0xFF22C55E),
    ),
  ];

  static const List<TrustStat> trustStats = [
    TrustStat(value: '15,000+', label: 'Happy Customers'),
    TrustStat(value: '4.9/5', label: 'Average Rating'),
    TrustStat(value: '98%', label: 'Satisfaction Rate'),
    TrustStat(value: '< 24h', label: 'Response Time'),
  ];

  // ========================================
  // Lifestyle Section
  // ========================================
  static const String lifestyleBadge = 'LIFESTYLE';
  static const String lifestyleTitle =
      'More Than a Product, It\'s a Lifestyle';
  static const String lifestyleSubtitle =
      'Join thousands who have transformed their daily routine.';

  static const List<LifestyleImage> lifestyleImages = [
    LifestyleImage(
      imageUrl:
          'https://images.unsplash.com/photo-1556912173-3bb406ef7e77?w=600&h=800&fit=crop',
      caption: 'Morning Routine',
      height: 400,
    ),
    LifestyleImage(
      imageUrl:
          'assets/images/mode_de_vie/doctor.webp',
      caption: 'Remote Work',
      height: 250,
    ),
    LifestyleImage(
      imageUrl:
          'assets/images/mode_de_vie/pret_a_voyage.jpeg',
      caption: 'Ready to Travel',
      height: 250,
    ),
    LifestyleImage(
      imageUrl:
          'assets/images/mode_de_vie/salle_de_sport.webp',
      caption: 'Perfect for Fitness',
      height: 400,
    ),
    LifestyleImage(
      imageUrl:
          'https://images.unsplash.com/photo-1609220136736-443140cffec6?w=600&h=800&fit=crop',
      caption: 'Family Approved',
      height: 400,
    ),
    LifestyleImage(
      imageUrl:
          'https://images.unsplash.com/photo-1622597467836-f3285f2131b8?w=600&h=400&fit=crop',
      caption: 'Professional Use',
      height: 250,
    ),
  ];

  // ========================================
  // Limited Offer Section
  // ========================================
  static const String offerBadge = '⚡ LIMITED TIME OFFER';
  static const String offerTitle = 'Don\'t Miss This Deal!';
  static const String offerSubtitle =
      'Special discount ending soon!';

  static const String offerPrice = '23';
  static const String offerOriginalPrice = '39';
  static const String offerSavePercent = 'SAVE 40%';
  static const String offerCurrency = '\$';

  static const String offerButtonText =
      'CLAIM YOUR DISCOUNT NOW';
  static const String offerSecureText =
      '🔒 Secure checkout • 256-bit encryption';

  static const List<String> offerBonusItems = [
    '✓ Free Premium Shipping',
    '✓ Extended 2-Year Warranty',
    '✓ Exclusive Bonus Pack (\$15 value)',
    '✓ 30-Day Money-Back Guarantee',
  ];

  static const String offerTimerHours = 'HOURS';
  static const String offerTimerMinutes = 'MINUTES';
  static const String offerTimerSeconds = 'SECONDS';

  // ========================================
  // Videos Section
  // ========================================
  static const String videosBadge = 'SEE IT IN ACTION';
  static const String videosTitle = 'Watch How It Works';
  static const String videosSubtitle =
      'Discover real people getting real results with our product.';

  static const List<VideoItem> videoItems = [
    VideoItem(
      title: 'Easy to set up, short demonstration',
      views: '240K views',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=800&h=500&fit=crop',
      duration: Duration(minutes: 4, seconds: 30),
      videoUrl: 'assets/videos/first.mp4',
    ),
    VideoItem(
      title: 'Easy to set up, short demonstration',
      views: '180K views',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800&h=500&fit=crop',
      duration: Duration(minutes: 6, seconds: 15),
      videoUrl: 'assets/videos/second.mp4',
    ),
    VideoItem(
      title: 'Influencer Review',
      views: '320K views',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1556909212-d5b604d0c90d?w=800&h=500&fit=crop',
      duration: Duration(minutes: 8, seconds: 42),
      videoUrl: 'assets/videos/third.mp4',
    ),
    VideoItem(
      title: 'Family',
      views: '210K views',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=800&h=500&fit=crop',
      duration: Duration(minutes: 5, seconds: 33),
      videoUrl: 'assets/videos/fourth.mp4',
    ),
  ];

  // ========================================
  // Final CTA Section
  // ========================================
  static const String finalCTATitle = 'Ready to Transform Your Routine?';
  static const String finalCTASubtitle =
      'Join over 15,000 satisfied customers who have already made the choice. '
      'Don\'t let this opportunity pass you by.';
  static const String finalCTAButton = 'GET YOURS NOW';

  static const String finalCTASecureCheckout = 'Secure Checkout';
  static const String finalCTAGuarantee = '30-Day Guarantee';

  static const String finalCTARating = '4.9 out of 5 stars';
  static const String finalCTAReviewCount = 'Based on 1,200+ reviews';

  static const List<FinalCTABenefit> finalCTABenefits = [
    FinalCTABenefit(icon: Icons.local_shipping, label: 'Free Shipping'),
    FinalCTABenefit(icon: Icons.support_agent, label: '24/7 Support'),
    FinalCTABenefit(icon: Icons.verified, label: '2-Year Warranty'),
    FinalCTABenefit(icon: Icons.currency_exchange, label: 'Money Back'),
  ];

  // ========================================
  // Brands Section
  // ========================================
  static const String brandsSectionTitle = 'As Seen In';

  static const List<BrandItem> brandsList = [
    BrandItem(name: 'Cuisine Magazine', logo: '🍴'),
    BrandItem(name: 'Health Plus', logo: '💚'),
    BrandItem(name: 'Tech Daily', logo: '⚡'),
    BrandItem(name: 'Lifestyle Blog', logo: '🌟'),
    BrandItem(name: 'Sports & Nutrition', logo: '💪'),
    BrandItem(name: 'Home & Living', logo: '🏡'),
    BrandItem(name: 'Eco Friendly', logo: '🌱'),
    BrandItem(name: 'Family Guide', logo: '👨‍👩‍👧'),
  ];

  static const List<BrandStat> brandStats = [
    BrandStat(value: '15K+', label: 'Happy Customers'),
    BrandStat(value: '4.9★', label: 'Average Rating'),
    BrandStat(value: '98%', label: 'Satisfaction Rate'),
    BrandStat(value: '24/7', label: 'Support Available'),
  ];

  // ========================================
  // Customer Stories Section
  // ========================================
  static const String storiesBadge = 'SUCCESS STORIES';
  static const String storiesTitle =
      'Real Stories, Real Results';
  static const String storiesSubtitle =
      'Discover how our blender has transformed our customers\' lives.';

  static const List<CustomerStory> customerStories = [
    CustomerStory(
      title: 'From Struggle to Success',
      subtitle: 'Marie\'s Story',
      story:
          '"I was very skeptical at first, but this portable blender completely changed my morning routine. '
          'In 30 days, I noticed a huge improvement in my energy and health. I now make '
          'my smoothies everywhere - at the office, at the gym, even while traveling. It\'s become my essential '
          'companion and I recommend it to all my friends!"',
      imageUrl:
          'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800&h=500&fit=crop',
      accentColorValue: 0xFF3B82F6,
      imageOnLeft: true,
    ),
    CustomerStory(
      title: 'The Professional Solution',
      subtitle: 'Thomas\'s Experience',
      story:
          '"As a professional athlete, I needed a reliable and practical blender. This product exceeded '
          'all my expectations. USB rechargeable, powerful, easy to clean - everything I needed. '
          'My performance improved thanks to better nutrition. My colleagues constantly ask me '
          'where I bought it. It\'s an investment truly worth making!"',
      imageUrl:
          'assets/images/caracteristics/thomas.jpg',
      accentColorValue: 0xFF10B981,
      imageOnLeft: false,
    ),
    CustomerStory(
      title: 'The Family Transformation',
      subtitle: 'The Dubois Family',
      story:
          '"We were looking for a solution to help the whole family eat healthier. This blender is perfect! '
          'Our kids love making their own smoothies, and we appreciate how easy it is to use. '
          'It\'s become a morning family ritual. No more buying expensive juices at the supermarket. '
          'We\'re saving money and eating healthier. We can\'t live without it anymore!"',
      imageUrl:
          'https://images.unsplash.com/photo-1511895426328-dc8714191300?w=800&h=500&fit=crop',
      accentColorValue: 0xFF8B5CF6,
      imageOnLeft: true,
    ),
  ];

  // ========================================
  // Experts Section
  // ========================================
  static const String expertsBadge = 'RECOMMENDED BY EXPERTS';
  static const String expertsTitle = 'Approved by Professionals';
  static const String expertsSubtitle =
      'Industry experts recommend our blender for its quality and results.';

  static const List<ExpertEndorsement> expertEndorsements = [
    ExpertEndorsement(
      name: 'Dr. Marie Dubois',
      title: 'Certified Nutritionist',
      credentials: 'Paris Sorbonne University • 12 years experience',
      quote:
          '"The quality of this portable blender is exceptional. The stainless steel blades '
          'preserve all nutrients. I recommend it to all my patients for their daily smoothies."',
      imageUrl:
          'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=400&h=400&fit=crop',
      accentColorValue: 0xFF3B82F6,
    ),
    ExpertEndorsement(
      name: 'Thomas Martin',
      title: 'Certified Fitness Coach',
      credentials: 'FitnessPro • 250K followers',
      quote:
          '"I\'ve tested dozens of portable blenders. This one outperforms all others in terms '
          'of power and portability. Ideal for athletes and active people."',
      imageUrl:
          'assets/images/recommended/second.jpg',
      accentColorValue: 0xFF10B981,
    ),
    ExpertEndorsement(
      name: 'Sophie Laurent',
      title: 'Food Safety Expert',
      credentials: 'Health Safety Institute • Certified',
      quote:
          '"After rigorous testing, this product exceeds all safety standards. The materials '
          'are BPA-free and completely safe. It\'s effective and hazard-free."',
      imageUrl:
          'assets/images/recommended/third.jpg',
      accentColorValue: 0xFF8B5CF6,
    ),
  ];

  // ========================================
  // Manufacturing Section
  // ========================================
  static const String manufacturingBadge = 'QUALITY CRAFTSMANSHIP';
  static const String manufacturingTitle =
      'Made with Care, Built to Last';
  static const String manufacturingSubtitle =
      'Every product is manufactured with precision and attention to detail.';

  static const List<ManufacturingProcess> manufacturingProcesses = [
    ManufacturingProcess(
      step: '1. Design',
      description:
          'Our expert team designs every detail with cutting-edge software',
      icon: Icons.draw,
      colorValue: 0xFF3B82F6,
      imageUrl:
          'https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=600&h=400&fit=crop',
    ),
    ManufacturingProcess(
      step: '2. Materials',
      description:
          'We select only the best materials from certified suppliers',
      icon: Icons.inventory_2,
      colorValue: 0xFF10B981,
      imageUrl:
          'https://images.unsplash.com/photo-1565793298595-6a879b1d9492?w=600&h=400&fit=crop',
    ),
    ManufacturingProcess(
      step: '3. Manufacturing',
      description:
          'Precision assembly by skilled craftsmen with decades of experience',
      icon: Icons.settings,
      colorValue: 0xFFF59E0B,
      imageUrl:
          'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?w=600&h=400&fit=crop',
    ),
    ManufacturingProcess(
      step: '4. Quality Control',
      description:
          'Every unit undergoes rigorous testing to ensure our high standards',
      icon: Icons.verified,
      colorValue: 0xFF8B5CF6,
      imageUrl:
          'assets/images/caracteristics/controle_qualite.jpg',
    ),
  ];

  static const String certificationTitle = 'Certified and Approved';

  static const List<Certification> certifications = [
    Certification(label: 'CE European', icon: Icons.verified_user),
    Certification(label: 'FDA Standards', icon: Icons.gpp_good),
    Certification(label: 'BPA Free', icon: Icons.eco),
    Certification(label: '2-Year Warranty', icon: Icons.check_circle),
  ];
}

// ==================== DATA MODELS ====================
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
