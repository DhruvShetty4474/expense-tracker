import 'package:flutter/material.dart';
import 'app_colors.dart';

// ─── Glassmorphism Design Tokens ──────────────────────────────────────────

extension GlassThemeExtension on ThemeData {
  Color get glassBackground => Colors.white.withValues(alpha: 0.08);
  Color get glassBorderColor => Colors.white.withValues(alpha: 0.15);
  double get glassBorderRadius => 20.0;
  double get glassBlurSigma => 12.0;

  BoxDecoration glassDecoration({double? radius, Color? bgColor}) => BoxDecoration(
    color: bgColor ?? glassBackground,
    borderRadius: BorderRadius.circular(radius ?? glassBorderRadius),
    border: Border.all(color: glassBorderColor, width: 1),
  );
}

// ─── App Theme ────────────────────────────────────────────────────────────

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        error: AppColors.error,
        onError: AppColors.onError,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        iconTheme: const IconThemeData(color: AppColors.onPrimary),
      ),
      textTheme: _buildTextTheme(AppColors.onBackground),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.surface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.amoledBackground,
      colorScheme: ColorScheme.dark(
        primary: AppColors.accentPurple,
        onPrimary: Colors.white,
        secondary: AppColors.accentGreen,
        onSecondary: Colors.black,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.surfaceDark,
        onSurface: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: _buildTextTheme(Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: AppColors.cardDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: AppColors.surfaceDark,
      ),
    );
  }

  static TextTheme _buildTextTheme(Color color) => TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.bold, color: color),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: color),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: color),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: color),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: color),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: color),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: color),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: color),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: color),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
  );

  // Keep the old getter name as alias to avoid breaking existing call sites
  // ignore: non_constant_identifier_names
  static ThemeData get LightTheme => lightTheme;
}
