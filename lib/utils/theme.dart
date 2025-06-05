import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Custom Colors
  static const Color primary = Color(0xFF6C63FF); // Vibrant Purple
  static const Color secondary = Color(0xFFFF6B6B); // Coral Red
  static const Color accent = Color(0xFF4ECDC4); // Turquoise
  static const Color background = Color(0xFFF7F7F7); // Light Gray
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFFF5252);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF8B80FF);
  static const Color darkSecondary = Color(0xFFFF8585);
  static const Color darkAccent = Color(0xFF6EE7DE);
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2D2D2D);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF8B80FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8585)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Text Styles
  static TextStyle get headlineLarge => GoogleFonts.nunito(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  static TextStyle get headlineMedium => GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );

  static TextStyle get titleLarge => GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle get bodyLarge => GoogleFonts.nunito(
        fontSize: 16,
        color: Colors.black87,
      );

  static TextStyle get bodyMedium => GoogleFonts.nunito(
        fontSize: 14,
        color: Colors.black87,
      );

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        background: background,
        error: error,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: titleLarge.copyWith(color: primary),
        iconTheme: const IconThemeData(color: primary),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: surface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: TextTheme(
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        titleLarge: titleLarge,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkSecondary,
        surface: darkSurface,
        background: darkBackground,
        error: error,
      ),
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: titleLarge.copyWith(color: darkPrimary),
        iconTheme: const IconThemeData(color: darkPrimary),
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        color: darkSurface,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: TextTheme(
        headlineLarge: headlineLarge.copyWith(color: Colors.white),
        headlineMedium: headlineMedium.copyWith(color: Colors.white),
        titleLarge: titleLarge.copyWith(color: Colors.white),
        bodyLarge: bodyLarge.copyWith(color: Colors.white70),
        bodyMedium: bodyMedium.copyWith(color: Colors.white70),
      ),
    );
  }
} 