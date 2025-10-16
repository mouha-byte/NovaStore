import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final double walletBalance;
  final List<Address> addresses;
  final DateTime createdAt;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.walletBalance = 0.0,
    this.addresses = const [],
    required this.createdAt,
    this.isAdmin = false,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'],
      phone: data['phone'],
      walletBalance: (data['walletBalance'] ?? 0).toDouble(),
      addresses: (data['addresses'] as List?)
              ?.map((a) => Address.fromMap(a))
              .toList() ??
          [],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isAdmin: data['isAdmin'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'walletBalance': walletBalance,
      'addresses': addresses.map((a) => a.toMap()).toList(),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.now(),
      'isAdmin': isAdmin,
    };
  }
}

class Address {
  final String address;
  final String city;
  final String state;
  final String zip;
  final String country;
  final bool isDefault;

  Address({
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
    this.isDefault = false,
  });

  factory Address.fromMap(Map data) {
    return Address(
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      zip: data['zip'] ?? '',
      country: data['country'] ?? '',
      isDefault: data['default'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
      'default': isDefault,
    };
  }
}
