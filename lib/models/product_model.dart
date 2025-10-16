import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<String> images;
  final double price;
  final double compareAtPrice;
  final int discountPercentage;
  final List<ProductVariant> variants;
  final int soldCount;
  final String shippingETA;
  final String returnPolicy;

  ProductModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.images,
    required this.price,
    required this.compareAtPrice,
    required this.discountPercentage,
    this.variants = const [],
    this.soldCount = 0,
    this.shippingETA = '5-10 days',
    this.returnPolicy = '30 days return policy',
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ProductModel(
      id: doc.id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      price: (data['price'] ?? 0).toDouble(),
      compareAtPrice: (data['compareAtPrice'] ?? 0).toDouble(),
      discountPercentage: data['discountPercentage'] ?? 0,
      variants: (data['variants'] as List?)
              ?.map((v) => ProductVariant.fromMap(v))
              .toList() ??
          [],
      soldCount: data['soldCount'] ?? 0,
      shippingETA: data['shippingETA'] ?? '5-10 days',
      returnPolicy: data['returnPolicy'] ?? '30 days return policy',
    );
  }
}

class ProductVariant {
  final String variantId;
  final String title;
  final String sku;
  final int stock;
  final double? price;

  ProductVariant({
    required this.variantId,
    required this.title,
    required this.sku,
    required this.stock,
    this.price,
  });

  factory ProductVariant.fromMap(Map data) {
    return ProductVariant(
      variantId: data['variantId'] ?? '',
      title: data['title'] ?? '',
      sku: data['SKU'] ?? '',
      stock: data['stock'] ?? 0,
      price: data['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'variantId': variantId,
      'title': title,
      'SKU': sku,
      'stock': stock,
      if (price != null) 'price': price,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductVariant && other.variantId == variantId;
  }

  @override
  int get hashCode => variantId.hashCode;
}
