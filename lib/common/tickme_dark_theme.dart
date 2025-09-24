import 'package:flutter/material.dart';

class TickMeDarkTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,

      // App background color
      scaffoldBackgroundColor: const Color(0xFF0F172A),

      // Card Theme
      cardTheme: TickmeDarkCardThemeData.regular,

      // AppBar Theme (TopBar)
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 24.0,
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF0F172A),
      ),

      // NavigationBar Theme (BottomBar)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.fromMap({
          WidgetState.selected: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF60A5FA),
          ),
          WidgetState.any: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF64748B),
          ),
        }),
        iconTheme: WidgetStateProperty.fromMap({
          WidgetState.selected:
              const IconThemeData(color: Color(0xFF60A5FA), size: 30.0),
          WidgetState.any:
              const IconThemeData(color: Color(0xFF64748B), size: 30.0),
        }),
      ),

      // Text Theme
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white60),
      ),
    );
  }
}

class TickmeDarkCardThemeData {
  static CardThemeData get regular {
    return CardThemeData(
      color: const Color(0xFF1E293B),
      surfaceTintColor: const Color(0xFF1E293B),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Color(0xFF334155),
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
    );
  }

  static CardThemeData get selected {
    return CardThemeData(
      color: const Color(0xFF1E293B),
      surfaceTintColor: const Color(0xFF1E40AF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: const BorderSide(
          color: Color(0xFF3B82F6),
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 24.0),
    );
  }
}

class EstimatedTimerTextTheme {
  static TextStyle get style {
    return const TextStyle(
      color: Color(0xFFF1F5F9),
      fontWeight: FontWeight.w600,
      fontSize: 28.0,
    );
  }
}
