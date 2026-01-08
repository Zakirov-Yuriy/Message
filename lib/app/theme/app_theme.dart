import 'package:flutter/material.dart';

/// Тема приложения
class AppTheme {
  static const Color primaryPurple = Color(0xFF7B39FD);
  static const Color backgroundDark = Color(0xFF1D2733);
  static const Color inputBackground = Color(0xFF242F3D);
  static const Color textGray = Color(0xFF7E8B98);
  static const Color accentBlue = Color(0xFF3390EC);

  // Chat colors
  static const Color chatBackground = Color(0xFF0E1216);
  static const Color myMessageColor = Color(0xFF7B39FD);
  static const Color otherMessageColor = Color(0xFF212D3B);
  static const Color dateDividerColor = Color(0xFF1D2733);

  static ThemeData get lightTheme {
    return _baseTheme(Brightness.light);
  }

  static ThemeData get darkTheme {
    return _baseTheme(Brightness.dark);
  }

  static ThemeData _baseTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryPurple,
      scaffoldBackgroundColor: isDark ? backgroundDark : Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? backgroundDark : Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? inputBackground : Colors.grey[200],
        hintStyle: const TextStyle(color: textGray),
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryPurple, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: textGray,
          fontSize: 16,
        ),
      ),
    );
  }
}
