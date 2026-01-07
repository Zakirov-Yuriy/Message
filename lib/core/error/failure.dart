/// Базовый класс для всех ошибок в приложении.
/// Следует принципу Fail Fast и типизированных ошибок.
abstract class Failure {
  const Failure({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Ошибка сети
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

/// Ошибка аутентификации
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

/// Ошибка сервера
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

/// Ошибка валидации
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
  });
}

/// Неизвестная ошибка
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
  });
}
