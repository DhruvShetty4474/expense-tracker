import 'package:flutter/material.dart';

class AppColors {
  // ── Light palette ────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);
  static const Color onError = Color(0xFFFFFFFF);

  // ── AMOLED dark palette ──────────────────────────────────────────────────
  static const Color amoledBackground = Color(0xFF000000);
  static const Color surfaceDark = Color(0xFF0A0A0A);
  static const Color cardDark = Color(0xFF111111);
  static const Color dividerDark = Color(0xFF1E1E1E);

  // ── Accent colors ─────────────────────────────────────────────────────────
  static const Color accentGreen = Color(0xFF00E676);
  static const Color accentPurple = Color(0xFF7C4DFF);
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color accentAmber = Color(0xFFFFD740);
  static const Color electricBlue = Color(0xFF00B4FF);  // Solo Leveling accent

  // ── Semantic colors ──────────────────────────────────────────────────────
  static const Color income = Color(0xFF00C853);
  static const Color expense = Color(0xFFFF1744);
  static const Color warning = Color(0xFFFF9100);
  static const Color neutral = Color(0xFF90A4AE);

  // ── Category palette ─────────────────────────────────────────────────────
  static const Color catFood = Color(0xFFFF6B6B);
  static const Color catTransport = Color(0xFF4ECDC4);
  static const Color catShopping = Color(0xFF45B7D1);
  static const Color catEntertainment = Color(0xFF96CEB4);
  static const Color catHealth = Color(0xFFFF9FF3);
  static const Color catUtilities = Color(0xFFFFEAA7);
  static const Color catRent = Color(0xFFDFE6E9);
  static const Color catEmi = Color(0xFFA29BFE);
  static const Color catSalary = Color(0xFF00B894);
  static const Color catSavings = Color(0xFF00CEC9);

  // ── Glassmorphism helpers ────────────────────────────────────────────────
  static Color glassWhite(double opacity) => Colors.white.withValues(alpha: opacity);
  static Color glassBlack(double opacity) => Colors.black.withValues(alpha: opacity);
}
