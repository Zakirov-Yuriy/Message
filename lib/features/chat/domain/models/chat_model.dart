class ChatModel {
  final String id;
  final String title;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isMuted;
  final bool isPinned;
  final String avatar;

  ChatModel({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isMuted = false,
    this.isPinned = false,
    required this.avatar,
  });
}
