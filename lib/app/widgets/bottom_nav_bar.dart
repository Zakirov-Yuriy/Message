import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50, left: 16, right: 16),
      height: 57,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Container(
          color: AppTheme.inputBackground.withOpacity(0.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, Image.asset('assets/icons/bottom_nav/person.png', width: 24, height: 24), 'Контакты'),
              _buildNavItem(context, 1, Icon(Icons.call, size: 24), 'Звонки'),
              _buildNavItem(context, 2, Image.asset('assets/icons/bottom_nav/chat.png', width: 24, height: 24), 'Чаты'),
              _buildNavItem(context, 3, Image.asset('assets/icons/bottom_nav/settings.png', width: 24, height: 24), 'Настройки'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, Widget icon, String label) {
    final isSelected = index == currentIndex;
    return Expanded(
      child: InkWell(
        onTap: () {
          switch (index) {
            case 0:
              context.go('/contacts');
              break;
            case 1:
              context.go('/calls');
              break;
            case 2:
              context.go('/home');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.blue : Colors.grey,
                BlendMode.srcIn,
              ),
              child: icon,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
