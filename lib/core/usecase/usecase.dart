import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// Базовый класс для всех UseCase.
/// Использует Either для обработки ошибок (из dartz, но для простоты используем стандартный Either или просто Result).
/// В Clean Architecture UseCase возвращает Either<Failure, Result>
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Параметры для UseCase без параметров
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Параметры для UseCase с одним параметром
class Params<T> extends Equatable {
  const Params(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}
