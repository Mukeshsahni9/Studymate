import 'package:flutter/material.dart';

class AppTheme {
  // Kid-friendly colors
  static const Color primaryColor = Color(0xFF4CAF50);  // Friendly green
  static const Color secondaryColor = Color(0xFFFF9800);  // Warm orange
  static const Color accentColor = Color(0xFF2196F3);  // Bright blue
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color errorColor = Color(0xFFE57373);  // Softer red
  static const Color textColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);

  // Dark theme colors
  static const Color darkBackgroundColor = Color(0xFF1A1A1A);
  static const Color darkSurfaceColor = Color(0xFF2D2D2D);
  static const Color darkTextColor = Color(0xFFFFFFFF);
  static const Color darkTextSecondaryColor = Color(0xFFB0B0B0);

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: textColor,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: textColor,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: textColor,
  );

  static ThemeData getTheme(bool isDarkMode) {
    return isDarkMode ? _darkTheme : _lightTheme;
  }

  static final ThemeData _lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // More rounded corners
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // More rounded buttons
        ),
        elevation: 2,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: textSecondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: textSecondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.5);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.transparent;
      }),
      side: const BorderSide(color: textSecondaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return textSecondaryColor;
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryColor,
      inactiveTrackColor: primaryColor.withOpacity(0.3),
      thumbColor: primaryColor,
      overlayColor: primaryColor.withOpacity(0.2),
      valueIndicatorColor: primaryColor,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: textSecondaryColor,
      indicatorColor: primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondaryColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textColor),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textColor),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
      titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textColor),
      bodyLarge: TextStyle(fontSize: 16, color: textColor),
      bodyMedium: TextStyle(fontSize: 14, color: textColor),
      bodySmall: TextStyle(fontSize: 12, color: textColor),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: textColor),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: textColor),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: darkSurfaceColor,
      background: darkBackgroundColor,
      error: errorColor,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurfaceColor,
      foregroundColor: darkTextColor,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: darkSurfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkTextColor),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: darkTextColor),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
      headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: darkTextColor),
      headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkTextColor),
      headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: darkTextColor),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: darkTextColor),
      titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: darkTextColor),
      titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkTextColor),
      bodyLarge: TextStyle(fontSize: 16, color: darkTextColor),
      bodyMedium: TextStyle(fontSize: 14, color: darkTextColor),
      bodySmall: TextStyle(fontSize: 12, color: darkTextColor),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: darkTextColor),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkTextColor),
      labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: darkTextColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: darkTextSecondaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: darkTextSecondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor.withOpacity(0.5);
        }
        return Colors.grey.withOpacity(0.5);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return Colors.transparent;
      }),
      side: const BorderSide(color: darkTextSecondaryColor),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return darkTextSecondaryColor;
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryColor,
      inactiveTrackColor: primaryColor.withOpacity(0.3),
      thumbColor: primaryColor,
      overlayColor: primaryColor.withOpacity(0.2),
      valueIndicatorColor: primaryColor,
      valueIndicatorTextStyle: const TextStyle(color: Colors.white),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: darkTextSecondaryColor,
      indicatorColor: primaryColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: darkTextSecondaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
  );
} 