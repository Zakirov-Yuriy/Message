import 'package:flutter/material.dart';

import '../../domain/models/message_model.dart';
import 'audio_message.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isMe ? Alignment.centerRight : Alignment.centerLeft;

    final color = message.isMe
        ? const Color(0xFF9C5AFF) // фиолетовый Telegram
        : const Color(0xFF2A2A2A);

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildContent(),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: const TextStyle(color: Colors.white),
        );
      case MessageType.audio:
        return AudioMessageWidget(fileName: message.content);
    }
  }
}