import 'package:flutter/material.dart';

import '../../../../app/widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      body: const Center(
        child: Text(
          'Настройки',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
