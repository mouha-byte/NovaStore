import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/deposit_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ===== PRODUCTS =====
  Stream<List<ProductModel>> getProducts() {
    return _db.collection('products').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromFirestore(doc))
              .toList(),
        );
  }

  Future<ProductModel?> getProduct(String productId) async {
    final doc = await _db.collection('products').doc(productId).get();
    if (doc.exists) {
      return ProductModel.fromFirestore(doc);
    }
    return null;
  }

  // ===== USER =====
  Future<UserModel?> getUser(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  Future<void> updateUserBalance(String userId, double newBalance) async {
    await _db.collection('users').doc(userId).update({
      'walletBalance': newBalance,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<void> addUserAddress(String userId, Address address) async {
    await _db.collection('users').doc(userId).update({
      'addresses': FieldValue.arrayUnion([address.toMap()]),
      'updatedAt': Timestamp.now(),
    });
  }

  // ===== ORDERS =====
  Future<String> createOrder(OrderModel order) async {
    final docRef = await _db.collection('orders').add(order.toMap());
    return docRef.id;
  }

  Stream<List<OrderModel>> getUserOrders(String userId) {
    return _db
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) {
            final orders = snapshot.docs
                .map((doc) => OrderModel.fromFirestore(doc))
                .toList();
            // Trier côté client
            orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return orders;
          },
        );
  }

  Future<OrderModel?> getOrder(String orderId) async {
    final doc = await _db.collection('orders').doc(orderId).get();
    if (doc.exists) {
      return OrderModel.fromFirestore(doc);
    }
    return null;
  }

  // ===== DEPOSITS =====
  Future<String> createDeposit(DepositModel deposit) async {
    final docRef = await _db.collection('deposits').add(deposit.toMap());
    return docRef.id;
  }

  Stream<List<DepositModel>> getUserDeposits(String userId) {
    return _db
        .collection('deposits')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) {
            final deposits = snapshot.docs
                .map((doc) => DepositModel.fromFirestore(doc))
                .toList();
            // Trier côté client
            deposits.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return deposits;
          },
        );
  }

  // ===== ADMIN =====
  Stream<List<OrderModel>> getAllOrders() {
    return _db
        .collection('orders')
        .snapshots()
        .map(
          (snapshot) {
            final orders = snapshot.docs
                .map((doc) => OrderModel.fromFirestore(doc))
                .toList();
            // Trier côté client
            orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return orders;
          },
        );
  }

  Stream<List<DepositModel>> getAllDeposits() {
    return _db
        .collection('deposits')
        .snapshots()
        .map(
          (snapshot) {
            final deposits = snapshot.docs
                .map((doc) => DepositModel.fromFirestore(doc))
                .toList();
            // Trier côté client
            deposits.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return deposits;
          },
        );
  }

  Future<void> updateOrderStatus(String orderId, String status,
      {String? trackingNumber}) async {
    final updateData = {
      'status': status,
      'updatedAt': Timestamp.now(),
    };
    if (trackingNumber != null) {
      updateData['trackingNumber'] = trackingNumber;
    }
    await _db.collection('orders').doc(orderId).update(updateData);
  }

  Future<void> updateDepositStatus(String depositId, String status) async {
    await _db.collection('deposits').doc(depositId).update({
      'status': status,
      'updatedAt': Timestamp.now(),
    });
  }
}
