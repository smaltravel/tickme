import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

/// Semantic color extension for Moon Design System
///
/// Provides meaningful color names instead of Moon's character-based naming.
/// Automatically adapts to light/dark theme based on the current context.
///
/// Usage:
/// ```dart
/// final colors = context.semanticColors;
/// Container(
///   color: colors.background,
///   child: Text('Hello', style: TextStyle(color: colors.textPrimary)),
/// )
/// ```
extension SemanticMoonColorsExtension on BuildContext {
  /// Get semantic Moon Design colors from the current theme context
  TickMeColors get colors {
    final moonTheme = Theme.of(this).extension<MoonTheme>();
    final brightness = Theme.of(this).brightness;
    return TickMeColors._(moonTheme!.tokens.colors, brightness);
  }
}

/// Semantic color wrapper for Moon Design System
///
/// Maps Moon's character-based color names to semantic, developer-friendly names.
/// All colors automatically adapt to the current theme (light/dark).
class TickMeColors {
  final MoonColors _moonColors;
  final Brightness _brightness;

  TickMeColors._(this._moonColors, this._brightness);

  // ============================================================================
  // BACKGROUND COLORS
  // ============================================================================

  /// Main app background color
  /// Light: Slate-50 (#F1F5F9), Dark: Slate-900 (#0F172A)
  Color get background => _moonColors.gohan;

  /// Surface/card background color
  /// Light: White, Dark: Slate-800 (#1E293B)
  Color get surface => _moonColors.goku;

  // ============================================================================
  // PRIMARY/ACCENT COLORS
  // ============================================================================

  /// Primary brand/accent color
  /// Light: Blue-600 (#2563EB), Dark: Blue-500 (#3B82F6)
  Color get primary => _moonColors.piccolo;

  /// Secondary/alternative accent color
  Color get secondary => _moonColors.bulma;

  // ============================================================================
  // BORDER COLORS
  // ============================================================================

  /// Standard border color
  /// Light: Slate-200 (#E2E8F0), Dark: Slate-700 (#334155)
  Color get border => _moonColors.krillin;

  /// Subtle border color for less emphasis
  Color get borderSubtle => _moonColors.beerus;

  // ============================================================================
  // TEXT COLORS
  // ============================================================================

  /// Primary text color (high contrast)
  /// Light: Black/Gray-900, Dark: Slate-200 (#E2E8F0)
  Color get textPrimary => _moonColors.bulma;

  /// Secondary text color (medium contrast)
  /// Light: Gray-700 (#1F2937), Dark: Slate-400 (#94A3B8)
  Color get textSecondary => _moonColors.trunks;

  /// Disabled/inactive text color (low contrast)
  /// Light: Gray-400 (#9CA3AF), Dark: Slate-500 (#64748B)
  Color get textDisabled =>
      _brightness == Brightness.dark ? const Color(0xFF64748B) : const Color(0xFF9CA3AF);

  // ============================================================================
  // STATE COLORS
  // ============================================================================

  /// Success/positive state color (green)
  Color get success => _brightness == Brightness.dark
      ? const Color(0xFF10B981) // green-500
      : const Color(0xFF059669); // green-600

  /// Error/danger state color (red)
  Color get error => _brightness == Brightness.dark
      ? const Color(0xFFEF4444) // red-500
      : const Color(0xFFDC2626); // red-600

  /// Warning state color (amber/orange)
  Color get warning => _brightness == Brightness.dark
      ? const Color(0xFFF59E0B) // amber-500
      : const Color(0xFFD97706); // amber-600

  /// Info state color (uses primary color)
  Color get info => _moonColors.piccolo;

  // ============================================================================
  // INTERACTIVE STATES
  // ============================================================================

  /// Hover state overlay color
  Color get hoverOverlay => _moonColors.heles;

  /// Active/pressed state color
  Color get activeOverlay => _moonColors.whis;

  // ============================================================================
  // SPECIAL PURPOSE COLORS
  // ============================================================================

  /// Selected item surface color
  /// Light: Light Blue-100, Dark: Dark Blue-900
  Color get selectedSurface =>
      _brightness == Brightness.dark ? const Color(0xFF1E3A5F) : const Color(0xFFB3E5FC);

  /// Selected item border color
  /// Light: Light Blue-600, Dark: Blue-600
  Color get selectedBorder =>
      _brightness == Brightness.dark ? const Color(0xFF2563EB) : const Color(0xFF0091EA);

  /// Inactive/disabled UI element color
  /// Light: Gray-400 (#9CA3AF), Dark: Slate-500 (#64748B)
  Color get inactive => _brightness == Brightness.dark ? const Color(0xFF64748B) : const Color(0xFF9CA3AF);

  // ============================================================================
  // DIRECT ACCESS TO MOON COLORS (for advanced usage)
  // ============================================================================

  /// Access the underlying MoonColors object if needed
  MoonColors get raw => _moonColors;
}

/// Helper function to get colors from BuildContext
/// Alternative to using the extension
TickMeColors getThemeColors(BuildContext context) {
  return context.colors;
}
