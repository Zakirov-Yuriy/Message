import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/calls/presentation/pages/calls_screen.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/chat/presentation/pages/chats_screen.dart';
import '../../features/contacts/presentation/pages/contacts_screen.dart';
import '../../features/settings/presentation/pages/settings_screen.dart';
import '../widgets/auth_gate.dart';

/// Конфигурация маршрутизации приложения
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // Корневой маршрут с проверкой аутентификации
      GoRoute(
        path: '/',
        name: 'root',
        builder: (context, state) => const AuthGate(),
      ),

      // Аутентификация
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const LoginPage(),
      ),

      // Главная страница с чатами
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const ChatsScreen();
            } else {
              // Если состояние не AuthAuthenticated, перенаправляем на логин
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('/auth');
              });
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),

      // Контакты
      GoRoute(
        path: '/contacts',
        name: 'contacts',
        builder: (context, state) => const ContactsScreen(),
      ),

      // Звонки
      GoRoute(
        path: '/calls',
        name: 'calls',
        builder: (context, state) => const CallsScreen(),
      ),

      // Чат с конкретным пользователем
      GoRoute(
        path: '/chat/:userId',
        name: 'chat',
        builder: (context, state) => const ChatScreen(),
      ),

      // Настройки
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Профиль пользователя
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Profile Page')),
    );
  }
}

