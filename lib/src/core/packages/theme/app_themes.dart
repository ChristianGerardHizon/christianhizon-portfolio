import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

/// App theme definitions for light and dark modes.
///
/// Uses Material 3 with seed-based color schemes and Inter font.
class AppThemes {
  AppThemes._();

  /// Light theme ID.
  static const String lightId = 'light_theme';

  /// Dark theme ID.
  static const String darkId = 'dark_theme';

  /// Default seed color for the app.
  static const Color seedColor = Colors.blue;

  /// Light theme definition.
  static AppTheme light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
    return AppTheme(
      id: lightId,
      description: 'Light Theme',
      data: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.light).textTheme,
        ),
        useMaterial3: true,
      ),
    );
  }

  /// Dark theme definition.
  static AppTheme dark() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    return AppTheme(
      id: darkId,
      description: 'Dark Theme',
      data: ThemeData(
        colorScheme: colorScheme,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
      ),
    );
  }

  /// All available themes.
  static List<AppTheme> get all => [light(), dark()];
}
