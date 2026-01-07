import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/message.dart';

/// Репозиторий для чата
abstract class ChatRepository {
  /// Получение сообщений чата
  Future<Either<Failure, List<Message>>> getMessages({
    required String chatId,
  });

  /// Отправка сообщения
  Future<Either<Failure, Message>> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  });

  /// Слушатель новых сообщений
  Stream<Message> get messageStream;
}
