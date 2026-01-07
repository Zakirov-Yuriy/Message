import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/message.dart';

/// Модель сообщения для работы с данными
class MessageModel {
  const MessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.chatId,
  });

  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final String? chatId;

  /// Создание из Firestore документа
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      timestamp: data['timestamp']?.toDate() ?? DateTime.now(),
      chatId: data['chatId'],
    );
  }

  /// Преобразование в Map для Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': timestamp.toUtc(),
      'chatId': chatId,
    };
  }

  /// Преобразование в Entity
  Message toEntity() {
    return Message(
      id: id,
      senderId: senderId,
      text: text,
      timestamp: timestamp,
      chatId: chatId,
    );
  }
}
