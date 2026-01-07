import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

/// Репозиторий для аутентификации
abstract class AuthRepository {
  /// Вход в систему
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Регистрация
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? displayName,
  });

  /// Выход из системы
  Future<Either<Failure, void>> logout();

  /// Получение текущего пользователя
  Future<Either<Failure, User?>> getCurrentUser();

  /// Слушатель состояния аутентификации
  Stream<User?> get authStateChanges;
}
