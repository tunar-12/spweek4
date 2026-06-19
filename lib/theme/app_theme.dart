import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color background = Color(0xFFF5F5F7);
  static const Color surface = Colors.white;
  static const Color primary = Color(0xFF111111);
  static const Color accent = Color(0xFF0A84FF);
  static const Color priceColor = Color(0xFF0A84FF);
  static const Color muted = Color(0xFF8E8E93);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: accent,
        primary: primary,
      ),
      scaffoldBackgroundColor: background,
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: primary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: primary,
        displayColor: primary,
      ),
    );
  }
}
