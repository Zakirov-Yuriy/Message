import 'package:flutter/material.dart';

import '../../../../app/widgets/bottom_nav_bar.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Звонки'),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      body: const Center(
        child: Text(
          'Звонки',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
