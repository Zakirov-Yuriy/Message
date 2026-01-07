/// Entity сообщения
class Message {
  const Message({
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

  Message copyWith({
    String? id,
    String? senderId,
    String? text,
    DateTime? timestamp,
    String? chatId,
  }) {
    return Message(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      chatId: chatId ?? this.chatId,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.id == id &&
        other.senderId == senderId &&
        other.text == text &&
        other.timestamp == timestamp &&
        other.chatId == chatId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        senderId.hashCode ^
        text.hashCode ^
        timestamp.hashCode ^
        chatId.hashCode;
  }

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, text: $text, timestamp: $timestamp, chatId: $chatId)';
  }
}
