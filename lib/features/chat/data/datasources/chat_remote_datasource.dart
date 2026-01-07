import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../models/message_model.dart';

/// Абстракция для удаленного источника данных чата
abstract class ChatRemoteDataSource {
  /// Получение сообщений чата
  Future<List<MessageModel>> getMessages({
    required String chatId,
  });

  /// Отправка сообщения
  Future<MessageModel> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  });

  /// Слушатель новых сообщений
  Stream<MessageModel> get messageStream;
}

/// Реализация с Firestore
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final Logger logger;

  ChatRemoteDataSourceImpl({
    required this.firestore,
    required this.logger,
  });

  @override
  Future<List<MessageModel>> getMessages({
    required String chatId,
  }) async {
    try {
      final querySnapshot = await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .get();

      return querySnapshot.docs
          .map((doc) => MessageModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      logger.e('Get messages error: $e');
      throw Exception('Get messages failed: $e');
    }
  }

  @override
  Future<MessageModel> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    try {
      final docRef = firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc();

      final messageModel = MessageModel(
        id: docRef.id,
        senderId: senderId,
        text: text,
        timestamp: DateTime.now(),
        chatId: chatId,
      );

      await docRef.set(messageModel.toFirestore());

      return messageModel;
    } catch (e) {
      logger.e('Send message error: $e');
      throw Exception('Send message failed: $e');
    }
  }

  @override
  Stream<MessageModel> get messageStream {
    // Для простоты, слушаем все сообщения, в реальности фильтровать по chatId
    return firestore
        .collectionGroup('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          // Возвращаем последнее сообщение или null, но для простоты
          if (snapshot.docs.isNotEmpty) {
            return MessageModel.fromFirestore(snapshot.docs.last);
          }
          throw Exception('No messages');
        });
  }
}
