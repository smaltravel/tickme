import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

/// TickMe Dark Theme Configuration
///
/// Provides a complete ThemeData with MoonTheme as an extension,
/// following Moon Design System best practices.
class TickMeDarkTheme {
  // Dark theme color palette
  static const Color backgroundColor = Color(0xFF0F172A); // slate-900
  static const Color surfaceColor = Color(0xFF1E293B); // slate-800
  static const Color primaryColor = Color(0xFF3B82F6); // blue-500
  static const Color borderColor = Color(0xFF334155); // slate-700
  static const Color inactiveColor = Color(0xFF64748B); // slate-500
  static const Color selectedSurfaceColor = Color(0xFF1E3A5F);
  static const Color selectedBorderColor = Color(0xFF2563EB);
  static const Color textColor = Color(0xFFE2E8F0); // slate-200
  static const Color textSecondaryColor = Color(0xFF94A3B8); // slate-400

  /// Dark theme tokens for Moon Design System
  static final darkTokens = MoonTokens.dark.copyWith(
    colors: MoonColors.dark.copyWith(
      gohan: backgroundColor,
      goku: surfaceColor,
      piccolo: primaryColor,
      krillin: borderColor,
    ),
  );

  /// Complete Material theme with MoonTheme extension
  static ThemeData get theme {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      extensions: <ThemeExtension<dynamic>>[
        MoonTheme(tokens: darkTokens),
      ],
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
        ),
        centerTitle: false,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textSecondaryColor),
        titleLarge: TextStyle(color: textColor),
        titleMedium: TextStyle(color: textColor),
        titleSmall: TextStyle(color: textColor),
      ),
      iconTheme: const IconThemeData(color: textColor),
    );
  }
}

/// Estimated Timer Text Theme for Dark Mode
/// Used for displaying the active timer countdown
class EstimatedTimerDarkTextTheme {
  static TextStyle get style {
    return const TextStyle(
      color: Color(0xFFE2E8F0), // slate-200
      fontWeight: FontWeight.w600,
      fontSize: 28.0,
    );
  }
}
