import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String productId;
  final String? variantId;
  final int quantity;
  final double totalPrice;
  final Map<String, dynamic> shippingAddress;
  final String shippingOption;
  final String? couponCode;
  final String paymentMethod;
  final String status;
  final String? trackingNumber;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.productId,
    this.variantId,
    this.quantity = 1,
    required this.totalPrice,
    required this.shippingAddress,
    this.shippingOption = 'standard',
    this.couponCode,
    this.paymentMethod = 'wallet',
    this.status = 'pending',
    this.trackingNumber,
    required this.createdAt,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return OrderModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      productId: data['productId'] ?? '',
      variantId: data['variantId'],
      quantity: data['quantity'] ?? 1,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      shippingAddress: Map<String, dynamic>.from(data['shippingAddress'] ?? {}),
      shippingOption: data['shippingOption'] ?? 'standard',
      couponCode: data['couponCode'],
      paymentMethod: data['paymentMethod'] ?? 'wallet',
      status: data['status'] ?? 'pending',
      trackingNumber: data['trackingNumber'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'productId': productId,
      'variantId': variantId,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress,
      'shippingOption': shippingOption,
      'couponCode': couponCode,
      'paymentMethod': paymentMethod,
      'status': status,
      'trackingNumber': trackingNumber,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.now(),
    };
  }
}
