import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_theme.dart';
import '../../domain/models/message_model.dart';
import '../widgets/chat_input.dart';
import '../widgets/date_divider.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.chatBackground,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(child: _buildMessages()),
              const ChatInput(),
            ],
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: AppTheme.backgroundDark,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: AppTheme.accentBlue),
      onPressed: () => context.go('/home'),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Yurok Zakirov',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          'был(а) 04.01.26',
          style: TextStyle(fontSize: 12, color: AppTheme.textGray),
        ),
      ],
    ),
    actions: [
      const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://i.pravatar.cc/150?img=5',
        ),
      ),
      const SizedBox(width: 12),
    ],
  );
}

Widget _buildMessages() {
  final messages = _mockMessages();

  return ListView.builder(
    padding: const EdgeInsets.symmetric(vertical: 12),
    itemCount: messages.length,
    itemBuilder: (context, index) {
      final msg = messages[index];

      final isNewDate = index == 0 ||
          messages[index - 1].date.day != msg.date.day;

      return Column(
        children: [
          if (isNewDate)
            DateDivider(
              dateText: _formatDate(msg.date),
            ),
          MessageBubble(message: msg),
        ],
      );
    },
  );
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final messageDate = DateTime(date.year, date.month, date.day);

  if (messageDate == today) {
    return 'Сегодня';
  } else if (messageDate == today.subtract(const Duration(days: 1))) {
    return 'Вчера';
  } else {
    return DateFormat('d MMMM', 'ru').format(date);
  }
}

List<MessageModel> _mockMessages() {
  return [
    MessageModel(
      isMe: true,
      type: MessageType.text,
      content: 'бот понимал какой пользователь оплатил',
      time: '11:43',
      date: DateTime(2026, 1, 4),
    ),
    MessageModel(
      isMe: true,
      type: MessageType.text,
      content: 'Бумага\nКола\nБаранки',
      time: '17:26',
      date: DateTime(2026, 1, 4),
    ),
    MessageModel(
      isMe: false,
      type: MessageType.audio,
      content: 'audio1275674294.m4a • 4,1 МБ',
      time: '19:06',
      date: DateTime(2026, 1, 7),
    ),
    MessageModel(
      isMe: true,
      type: MessageType.audio,
      content: 'GMT20260107-103142_Recording.m4a • 17,3 МБ',
      time: '17:03',
      date: DateTime(2026, 1, 7),
    ),
  ];
}