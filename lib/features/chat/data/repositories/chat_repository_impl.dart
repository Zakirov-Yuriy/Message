import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

/// Реализация репозитория чата
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Message>>> getMessages({
    required String chatId,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'Нет подключения к интернету'));
    }

    try {
      final messageModels = await remoteDataSource.getMessages(chatId: chatId);
      final messages = messageModels.map((model) => model.toEntity()).toList();
      return Right(messages);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'Нет подключения к интернету'));
    }

    try {
      final messageModel = await remoteDataSource.sendMessage(
        chatId: chatId,
        senderId: senderId,
        text: text,
      );
      return Right(messageModel.toEntity());
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Stream<Message> get messageStream {
    return remoteDataSource.messageStream.map((messageModel) {
      return messageModel.toEntity();
    });
  }

  /// Преобразование исключений в Failure
  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    // Можно добавить специфические ошибки для чата
    if (message.contains('permission-denied')) {
      return const AuthFailure(message: 'Нет доступа к чату');
    } else if (message.contains('not-found')) {
      return const ServerFailure(message: 'Чат не найден');
    } else {
      return ServerFailure(message: message);
    }
  }
}
