import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/user_model.dart';

class AuthService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  // Connexion simple (email + password hashé)
  Future<UserModel?> login(String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);
      
      final querySnapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: hashedPassword)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Email ou mot de passe incorrect');
      }

      _currentUser = UserModel.fromFirestore(querySnapshot.docs.first);
      return _currentUser;
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Inscription
  Future<UserModel?> register(String email, String password, {String? name}) async {
    try {
      // Vérifier si l'email existe déjà
      final existing = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (existing.docs.isNotEmpty) {
        throw Exception('Cet email est déjà utilisé');
      }

      final hashedPassword = _hashPassword(password);
      
      final docRef = await _db.collection('users').add({
        'email': email,
        'password': hashedPassword,
        'name': name,
        'walletBalance': 0.0,
        'addresses': [],
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });

      final doc = await docRef.get();
      _currentUser = UserModel.fromFirestore(doc);
      return _currentUser;
    } catch (e) {
      throw Exception('Erreur d\'inscription: $e');
    }
  }

  // Déconnexion
  void logout() {
    _currentUser = null;
  }

  // Rafraîchir les données de l'utilisateur depuis Firestore
  Future<void> refreshUserData() async {
    if (_currentUser == null) return;

    try {
      final doc = await _db.collection('users').doc(_currentUser!.id).get();
      if (doc.exists) {
        _currentUser = UserModel.fromFirestore(doc);
      }
    } catch (e) {
      print('Erreur refresh user data: $e');
    }
  }

  // Hash du mot de passe (simple pour MVP)
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // Vérifier si connecté
  bool isLoggedIn() {
    return _currentUser != null;
  }

  // Vérifier si admin
  bool isAdmin() {
    return _currentUser != null && _currentUser!.isAdmin == true;
  }

  // Obtenir l'ID de l'utilisateur connecté
  String? getCurrentUserId() {
    return _currentUser?.id;
  }
}
