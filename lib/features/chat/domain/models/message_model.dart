enum MessageType { text, audio }

class MessageModel {
  final bool isMe;
  final MessageType type;
  final String content;
  final String time;
  final DateTime date;

  MessageModel({
    required this.isMe,
    required this.type,
    required this.content,
    required this.time,
    required this.date,
  });
}