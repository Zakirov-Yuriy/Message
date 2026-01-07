import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC для управления аутентификацией
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);

    // Временно отключаем слушатель authStateChanges для избежания конфликтов
    // _authStateSubscription = sl<AuthRepository>().authStateChanges.listen(
    //   (user) {
    //     if (user != null) {
    //       emit(AuthAuthenticated(user));
    //     } else {
    //       emit(const AuthUnauthenticated());
    //     }
    //   },
    // );
  }

  // late final StreamSubscription<User?> _authStateSubscription;

  final LoginUseCase _loginUseCase = sl<LoginUseCase>();
  final RegisterUseCase _registerUseCase = sl<RegisterUseCase>();

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final result = await _loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );

      result.fold(
        (failure) => emit(AuthError(failure)),
        (user) => emit(AuthAuthenticated(user)),
      );
    } catch (e) {
      // Если есть исключение, проверим напрямую Firebase Auth
      final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        // Создаем User entity из Firebase User
        final user = User(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName,
          photoUrl: firebaseUser.photoURL,
          isOnline: true,
          lastSeen: DateTime.now(),
        );
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError(const AuthFailure(message: 'Ошибка входа')));
      }
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final result = await _registerUseCase(
        RegisterParams(
          email: event.email,
          password: event.password,
          displayName: event.displayName,
        ),
      );

      result.fold(
        (failure) => emit(AuthError(failure)),
        (user) => emit(AuthAuthenticated(user)),
      );
    } catch (e) {
      // Если есть исключение, проверим текущего пользователя
      final currentUser = await sl<AuthRepository>().getCurrentUser();
      currentUser.fold(
        (failure) => emit(AuthError(failure)),
        (user) {
          if (user != null) {
            emit(AuthAuthenticated(user));
          } else {
            emit(AuthError(const AuthFailure(message: 'Ошибка регистрации')));
          }
        },
      );
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await sl<AuthRepository>().logout();
    emit(const AuthUnauthenticated());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await sl<AuthRepository>().getCurrentUser();

    result.fold(
      (failure) => emit(AuthError(failure)),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(const AuthUnauthenticated());
        }
      },
    );
  }

  @override
  Future<void> close() {
    // _authStateSubscription.cancel();
    return super.close();
  }
}
