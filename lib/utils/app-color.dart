import 'package:flutter/material.dart';

class AppColor {
  static bool get isDark {
    try {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    } catch (_) {
      return false;
    }
  }

  static Color get titleTextColor => isDark ? const Color(0xFFFAE8C2) : const Color(0xFF4C3100);
  static Color get subTextColor => isDark ? const Color(0xFFE0C491) : const Color(0xFF4C3100);
  static Color get btnTextColor => isDark ? const Color(0xFFFFCC33) : const Color(0xFF9F6904);
  static Color get btnSubTextColor => isDark ? const Color(0xFFECA315) : const Color(0xFFC98405);
  static Color get accentColor => isDark ? const Color(0xFFF5B925) : const Color(0xFFF9C855);
  static Color get borderDarkColor => isDark ? const Color(0xFF8B6B08) : const Color(0xFFF5D33B);
  static Color get borderLightColor => isDark ? const Color(0xFF3B2F0B) : const Color(0xFFFFF5C9);
  static Color get bgColor => isDark ? const Color(0xFF1A1405) : const Color(0xFFFFFCF6);
  static Color get cardColor => isDark ? const Color(0xFF241C0A) : Colors.white;
  static Color get iconBgColor => isDark ? const Color(0x40F8BB2B) : const Color(0x6CF8BB2B);
  
  // Table colors
  static Color get tableRowColor1 => isDark ? const Color(0xFF1E1A11).withOpacity(0.5) : Colors.white.withOpacity(0.6);
  static Color get tableRowColor2 => isDark ? const Color(0xFF2A241A).withOpacity(0.5) : const Color(0xFFF9F3E6).withOpacity(0.6);
  static Color get tableBorderColor => isDark ? const Color(0xFF332B1A).withOpacity(0.5) : Colors.grey.withOpacity(0.3);
  static Color get tableHeaderColor => isDark ? const Color(0xFF3B2F0B).withOpacity(0.7) : const Color(0xFFFFCC33).withOpacity(0.8);
  static Color get tableHeaderTextColor => isDark ? const Color(0xFFFFCC33) : Colors.white;
}

