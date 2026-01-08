import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/widgets/bottom_nav_bar.dart';
import '../../domain/models/chat_model.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
        body: Column(
          children: [
            // _buildTabs(),
            Expanded(child: _buildChatList()),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    elevation: 0,
    leadingWidth: 60,
    leading: TextButton(
      onPressed: () {},
      child: const Text(
        'Изм.',
        style: TextStyle(color: Colors.blue),
      ),
    ),
    title: const Text(
      'Чаты',
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {},
      ),
    ],
  );
}

// Widget _buildTabs() {
//   return const TabBar(
//     isScrollable: true,
//     indicatorColor: Colors.blue,
//     tabs: [
//       Tab(text: 'Все чаты'),
//       Tab(text: 'Личные'),
//       Tab(text: 'Работа'),
//     ],
//   );
// }

Widget _buildChatList() {
  final chats = _mockChats();

  return ListView.separated(
    itemCount: chats.length,
    separatorBuilder: (_, __) => Divider(
      color: Colors.grey.withOpacity(0.2),
      height: 1,
    ),
    itemBuilder: (context, index) {
      return _ChatTile(chat: chats[index]);
    },
  );
}

class _ChatTile extends StatelessWidget {
  final ChatModel chat;

  const _ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.go('/chat/${chat.id}'),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(chat.avatar),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              chat.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (chat.isMuted)
            const Icon(Icons.volume_off, size: 16, color: Colors.grey),
        ],
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.grey.shade400),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat.time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (chat.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

List<ChatModel> _mockChats() {
  return [
    ChatModel(
      id: '1',
      title: 'Lidle Front to back',
      lastMessage: 'Взаимно.',
      time: 'ср',
      unreadCount: 0,
      avatar: 'https://i.pravatar.cc/150?img=1',
    ),
    ChatModel(
      id: '2',
      title: 'Тестировщики Google Play',
      lastMessage: '# Вопросы и ответы',
      time: '09:21',
      unreadCount: 2,
      isMuted: true,
      avatar: 'https://i.pravatar.cc/150?img=2',
    ),
    ChatModel(
      id: '3',
      title: 'Transcribe To.',
      lastMessage: 'Транскрипт с тайм-кодами',
      time: 'вс',
      avatar: 'https://i.pravatar.cc/150?img=3',
    ),
  ];
}
