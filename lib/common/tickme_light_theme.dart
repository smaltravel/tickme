import 'package:flutter/material.dart';

class TickMeLightTheme {
  static ThemeData get theme {
    return ThemeData(
      // App background color
      scaffoldBackgroundColor: const Color(0xFFF1F5F9),

      // Card Theme
      cardTheme: TickmeCardThemeData.regular,

      // AppBar Theme (TopBar)
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black, // text-black
          fontWeight: FontWeight.w700, // font-bold
          fontSize: 24.0, // text-2xl
        ),
        centerTitle: false,
        backgroundColor: Color(0xFFF1F5F9),
      ),

      // NavigationBar Theme (BottomBar)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white, // bg-white
        elevation: 0, // No shadow specified, border takes care of separation
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.fromMap({
          WidgetState.selected: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF2563EB),
          ),
          WidgetState.any: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF9CA3AF),
          ),
        }),
        iconTheme: WidgetStateProperty.fromMap({
          WidgetState.selected:
              IconThemeData(color: Color(0xFF2563EB), size: 30.0),
          WidgetState.any: IconThemeData(color: Color(0xFF9CA3AF), size: 30.0),
        }),
      ),
    );
  }
}

class TickmeCardThemeData {
  static CardThemeData get regular {
    return CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // rounded-2xl is 16px
        side: const BorderSide(
          color: Color(0xFFE2E8F0),
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
    );
  }

  static CardThemeData get selected {
    return CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.lightBlueAccent.shade100,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // rounded-2xl is 16px
        side: const BorderSide(
          color: Color(0xFF0091EA),
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
      color: Color(0xFF1F2937), // text-gray-700
      fontWeight: FontWeight.w600,
      fontSize: 28.0,
    );
  }
}
