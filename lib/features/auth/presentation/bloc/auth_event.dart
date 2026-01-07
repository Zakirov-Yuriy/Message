import 'package:equatable/equatable.dart';

/// События для AuthBloc
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Событие входа в систему
class LoginEvent extends AuthEvent {
  const LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

/// Событие регистрации
class RegisterEvent extends AuthEvent {
  const RegisterEvent({
    required this.email,
    required this.password,
    this.displayName,
  });

  final String email;
  final String password;
  final String? displayName;

  @override
  List<Object?> get props => [email, password, displayName];
}

/// Событие выхода из системы
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// Событие проверки состояния аутентификации
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}
