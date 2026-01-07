import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../models/user_model.dart';

/// Абстракция для удаленного источника данных аутентификации
abstract class AuthRemoteDataSource {
  /// Вход в систему
  Future<UserModel> login({
    required String email,
    required String password,
  });

  /// Регистрация
  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
  });

  /// Выход из системы
  Future<void> logout();

  /// Получение текущего пользователя
  Future<UserModel?> getCurrentUser();

  /// Слушатель состояния аутентификации
  Stream<UserModel?> get authStateChanges;
}

/// Реализация с Firebase Auth и Firestore
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final Logger logger;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.logger,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('User is null after login');
      }

      // Создаем модель пользователя напрямую
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        isOnline: true,
        lastSeen: DateTime.now(),
      );

      // Сохраняем пользователя в Firestore асинхронно
      firestore.collection('users').doc(userModel.id).set(
            userModel.toFirestore(),
            SetOptions(merge: true),
          ).catchError((e) => logger.w('Failed to save user to Firestore: $e'));

      return userModel;
    } catch (e) {
      logger.e('Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('User is null after registration');
      }

      // Создаем модель пользователя с предоставленным displayName
      final userModel = UserModel(
        id: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        photoUrl: null,
        isOnline: true,
        lastSeen: DateTime.now(),
      );

      // Сохраняем пользователя в Firestore
      await firestore.collection('users').doc(userModel.id).set(
            userModel.toFirestore(),
            SetOptions(merge: true),
          );

      logger.i('User registered and saved to Firestore: ${userModel.id}');
      return userModel;
    } catch (e) {
      logger.e('Registration error: $e');
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      logger.e('Logout error: $e');
      throw Exception('Logout failed: $e');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) return null;

      // Создаем модель из Firebase Auth данных
      final userModel = UserModel.fromFirebaseUser(user);

      // Пытаемся получить дополнительные данные из Firestore, но не падаем при ошибке
      try {
        final doc = await firestore.collection('users').doc(userModel.id).get();
        if (doc.exists) {
          return UserModel.fromFirestore(doc);
        } else {
          // Если нет в Firestore, сохраняем асинхронно
          firestore.collection('users').doc(userModel.id).set(
                userModel.toFirestore(),
                SetOptions(merge: true),
              ).catchError((e) => logger.w('Failed to save user to Firestore: $e'));
          return userModel;
        }
      } catch (firestoreError) {
        logger.w('Firestore error in getCurrentUser: $firestoreError');
        // Возвращаем данные из Firebase Auth, даже если Firestore не доступен
        return userModel;
      }
    } catch (e) {
      logger.e('Get current user error: $e');
      throw Exception('Get current user failed: $e');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) return null;
      try {
        return UserModel.fromFirebaseUser(user);
      } catch (e) {
        logger.e('Error in authStateChanges: $e');
        return null;
      }
    });
  }
}
