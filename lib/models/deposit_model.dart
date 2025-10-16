import 'package:cloud_firestore/cloud_firestore.dart';

class DepositModel {
  final String id;
  final String userId;
  final double amount;
  final String method;
  final String status;
  final DateTime createdAt;

  DepositModel({
    required this.id,
    required this.userId,
    required this.amount,
    this.method = 'Payeer',
    this.status = 'pending',
    required this.createdAt,
  });

  factory DepositModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return DepositModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      method: data['method'] ?? 'Payeer',
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'method': method,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.now(),
    };
  }
}
