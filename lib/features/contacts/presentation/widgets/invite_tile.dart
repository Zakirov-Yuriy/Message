import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class InviteTile extends StatelessWidget {
  const InviteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1C6EF2),
        ),
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
      title: const Text(
        'Пригласить',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        _inviteUser();
      },
    );
  }

  void _inviteUser() {
    Share.share('Присоединяйся к massege 👉 https://massege.app/invite');
  }
}