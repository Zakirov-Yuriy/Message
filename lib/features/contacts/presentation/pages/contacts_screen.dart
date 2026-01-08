import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../app/widgets/bottom_nav_bar.dart';
import '../../domain/models/contact_model.dart';
import '../widgets/contact_tile.dart';
import '../widgets/invite_tile.dart';
import '../widgets/search_field.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
      body: Column(
        children: [
          const SearchField(),
          const InviteTile(),
          Expanded(child: _buildContacts()),
        ],
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    elevation: 0,
    leading: TextButton(
      onPressed: () {},
      child: const Text(
        'Сортировка',
        style: TextStyle(color: Colors.blue),
      ),
    ),
    centerTitle: true,
    title: const Text(
      'Контакты',
      style: TextStyle(fontWeight: FontWeight.w600),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.add, color: Colors.blue),
        onPressed: () {},
      ),
    ],
  );
}

Widget _buildContacts() {
  final contacts = _mockContacts();

  return ListView.separated(
    itemCount: contacts.length,
    separatorBuilder: (_, __) => Divider(
      color: Colors.grey.withOpacity(0.15),
      height: 1,
    ),
    itemBuilder: (context, index) {
      return ContactTile(contact: contacts[index]);
    },
  );
}



List<ContactModel> _mockContacts() {
  return [
    ContactModel(
      name: 'Виталик Яки',
      status: 'в сети',
      isOnline: true,
    ),
    ContactModel(
      name: 'Андрей Техник',
      status: 'был(а) 8 минут назад',
    ),
    ContactModel(
      name: 'Руслан Прескурант',
      status: 'был(а) 9 минут назад',
    ),
    ContactModel(
      name: 'Yurok Zakirov',
      status: 'был(а) 18 минут назад',
    ),
    ContactModel(
      name: 'Бабуля',
      status: 'был(а) 19 минут назад',
    ),
  ];
}
