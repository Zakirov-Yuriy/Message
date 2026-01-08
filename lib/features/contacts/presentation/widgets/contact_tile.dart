import 'package:flutter/material.dart';

import '../../domain/models/contact_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;

  const ContactTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        backgroundImage:
            contact.avatarUrl != null ? NetworkImage(contact.avatarUrl!) : null,
        child: contact.avatarUrl == null
            ? Text(
                contact.name[0],
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
      title: Text(
        contact.name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        contact.status,
        style: TextStyle(
          color: contact.isOnline ? Colors.blue : Colors.grey,
          fontSize: 13,
        ),
      ),
      onTap: () {
        // открыть чат или профиль
      },
    );
  }
}