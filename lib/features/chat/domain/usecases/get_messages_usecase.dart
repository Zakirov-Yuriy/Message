import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

/// Параметры для получения сообщений
class GetMessagesParams extends Equatable {
  const GetMessagesParams({
    required this.chatId,
  });

  final String chatId;

  @override
  List<Object?> get props => [chatId];
}

/// UseCase для получения сообщений чата
class GetMessagesUseCase extends UseCase<List<Message>, GetMessagesParams> {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Message>>> call(GetMessagesParams params) async {
    return await repository.getMessages(
      chatId: params.chatId,
    );
  }
}
