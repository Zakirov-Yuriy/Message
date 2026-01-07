import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Реализация репозитория аутентификации
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'Нет подключения к интернету'));
    }

    try {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'Нет подключения к интернету'));
    }

    try {
      final userModel = await remoteDataSource.register(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(userModel.toEntity());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel?.toEntity());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return remoteDataSource.authStateChanges.map((userModel) {
      return userModel?.toEntity();
    });
  }

  /// Преобразование исключений в Failure
  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('email-already-in-use')) {
      return const AuthFailure(message: 'Пользователь с таким email уже существует');
    } else if (message.contains('weak-password')) {
      return const AuthFailure(message: 'Пароль слишком слабый');
    } else if (message.contains('invalid-email')) {
      return const AuthFailure(message: 'Неверный формат email');
    } else if (message.contains('user-disabled')) {
      return const AuthFailure(message: 'Пользователь заблокирован');
    } else if (message.contains('user-not-found')) {
      return const AuthFailure(message: 'Пользователь не найден');
    } else if (message.contains('wrong-password')) {
      return const AuthFailure(message: 'Неверный пароль');
    } else {
      return AuthFailure(message: message);
    }
  }
}
