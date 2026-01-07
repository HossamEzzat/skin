import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ================= Colors =================
  static const Color primary = Color(0xFF0F766E); // Teal 700
  static const Color secondary = Color(0xFFD97706); // Amber 600
  static const Color background = Color(0xFFF3F4F6); // Cool Gray 100
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFDC2626);

  static const Color textPrimary = Color(0xFF111827); // Gray 900
  static const Color textSecondary = Color(0xFF6B7280); // Gray 500
  static const Color textDisabled = Color(0xFF9CA3AF); // Gray 400

  // ================= Radius =================
  static const double radiusSM = 8;
  static const double radiusMD = 12;
  static const double radiusLG = 16;

  // ================= Spacing =================
  static const double spaceXS = 8;
  static const double spaceSM = 12;
  static const double spaceMD = 16;
  static const double spaceLG = 24;
  static const double spaceXL = 32;

  // ================= Light Theme =================
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // ---------- Color Scheme ----------
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      primary: primary,
      secondary: secondary,
      surface: background,
      onSurface: textPrimary,
      surfaceContainerHighest: background,
      onSurfaceVariant: textSecondary, // Use for secondary text
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      outline: Colors.black12, // For borders
    ),

    scaffoldBackgroundColor: background,
    cardColor: surface,
    dividerColor: Colors.black12,

    // ---------- Typography ----------
    fontFamily: GoogleFonts.outfit().fontFamily,
    textTheme: GoogleFonts.outfitTextTheme().copyWith(
      displayLarge: _bold(32),
      displayMedium: _bold(28),
      displaySmall: _bold(24),
      headlineMedium: _semiBold(20),
      headlineSmall: _semiBold(18),
      titleLarge: _semiBold(18),
      titleMedium: _medium(16),
      bodyLarge: _regular(16, textPrimary),
      bodyMedium: _regular(14, textSecondary),
      bodySmall: _regular(12, textSecondary),
      labelLarge: _medium(14),
    ),

    // ---------- AppBar ----------
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: textPrimary),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
    ),

    // ---------- Card ----------
    cardTheme: CardThemeData(
      color: surface,
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLG),
      ),
    ),

    // ---------- Input ----------
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spaceMD,
        vertical: spaceMD,
      ),
      labelStyle: const TextStyle(color: textSecondary),
      floatingLabelStyle: const TextStyle(color: primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: const BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMD),
        borderSide: const BorderSide(color: error),
      ),
    ),

    // ---------- Elevated Button ----------
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: spaceLG,
          vertical: spaceMD,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMD),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    // ---------- Checkbox ----------
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? primary : Colors.white,
      ),
    ),

    // ---------- SnackBar ----------
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimary,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMD),
      ),
    ),

    // ---------- BottomSheet ----------
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLG)),
      ),
    ),

    // ---------- Icon ----------
    iconTheme: const IconThemeData(color: primary, size: 24),
  );

  // ================= Text Helpers =================
  static TextStyle _bold(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static TextStyle _semiBold(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle _medium(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: textPrimary,
  );

  static TextStyle _regular(double size, Color color) =>
      TextStyle(fontSize: size, fontWeight: FontWeight.w400, color: color);
}
