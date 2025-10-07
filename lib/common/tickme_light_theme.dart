import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

/// TickMe Light Theme Configuration
///
/// Provides a complete ThemeData with MoonTheme as an extension,
/// following Moon Design System best practices.
class TickMeLightTheme {
  // Light theme color palette
  static const Color backgroundColor = Color(0xFFF1F5F9);
  static const Color surfaceColor = Colors.white;
  static const Color primaryColor = Color(0xFF2563EB);
  static const Color borderColor = Color(0xFFE2E8F0);
  static const Color inactiveColor = Color(0xFF9CA3AF);
  static const Color selectedSurfaceColor = Color(0xFFB3E5FC);
  static const Color selectedBorderColor = Color(0xFF0091EA);
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Color(0xFF1F2937);

  /// Light theme tokens for Moon Design System
  static final lightTokens = MoonTokens.light.copyWith(
    colors: MoonColors.light.copyWith(
      gohan: backgroundColor,
      goku: surfaceColor,
      piccolo: primaryColor,
      krillin: borderColor,
    ),
  );

  /// Complete Material theme with MoonTheme extension
  static ThemeData get theme {
    return ThemeData.light().copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundColor,
      extensions: <ThemeExtension<dynamic>>[
        MoonTheme(tokens: lightTokens),
      ],
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
        ),
        centerTitle: false,
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textPrimary),
        bodySmall: TextStyle(color: inactiveColor),
        titleLarge: TextStyle(color: textPrimary),
        titleMedium: TextStyle(color: textPrimary),
        titleSmall: TextStyle(color: textPrimary),
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    );
  }
}

/// Estimated Timer Text Theme
/// Used for displaying the active timer countdown
class EstimatedTimerTextTheme {
  static TextStyle get style {
    return const TextStyle(
      color: Color(0xFF1F2937), // text-gray-700
      fontWeight: FontWeight.w600,
      fontSize: 28.0,
    );
  }
}
