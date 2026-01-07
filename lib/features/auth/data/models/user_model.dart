import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

/// Модель пользователя для работы с данными
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.isOnline = false,
    this.lastSeen,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool isOnline;
  final DateTime? lastSeen;

  /// Создание из Firebase User
  factory UserModel.fromFirebaseUser(dynamic firebaseUser) {
    try {
      return UserModel(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    } catch (e) {
      // Если есть проблема с типами, создаем минимальную модель
      print('Error in UserModel.fromFirebaseUser: $e');
      print('firebaseUser type: ${firebaseUser.runtimeType}');
      print('firebaseUser: $firebaseUser');
      rethrow;
    }
  }

  /// Создание из Firestore документа
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'],
      photoUrl: data['photoUrl'],
      isOnline: data['isOnline'] ?? false,
      lastSeen: data['lastSeen']?.toDate(),
    );
  }

  /// Преобразование в Map для Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isOnline': isOnline,
      'lastSeen': lastSeen?.toUtc(),
    };
  }

  /// Преобразование в Entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      isOnline: isOnline,
      lastSeen: lastSeen,
    );
  }
}
