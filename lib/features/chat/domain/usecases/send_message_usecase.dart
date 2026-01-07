import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

/// Параметры для отправки сообщения
class SendMessageParams extends Equatable {
  const SendMessageParams({
    required this.chatId,
    required this.senderId,
    required this.text,
  });

  final String chatId;
  final String senderId;
  final String text;

  @override
  List<Object?> get props => [chatId, senderId, text];
}

/// UseCase для отправки сообщения
class SendMessageUseCase extends UseCase<Message, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      chatId: params.chatId,
      senderId: params.senderId,
      text: params.text,
    );
  }
}
