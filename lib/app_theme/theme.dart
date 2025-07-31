import 'package:flutter/material.dart';

class AppColors {
  /// dark theme colors
  static const background = Color(0xFF121212); // Main background
  static const surface = Color(0xFF1E1E1E); // Card/Surface
  static const primary = Color(0xFFFFFFFF); // Main text/icons
  static const secondary = Color(0xFFB3E5FC); // Accent (icons, highlights)
  static const error = Color(0xFFD32F2F); // Error
  static const onPrimary = Color(0xFF121212); // Text on primary (if needed)
  static const onSecondary = Color(0xFF121212); // Text on secondary
  static const onBackground = Color(0xFFFFFFFF); // Text on background
  static const onSurface = Color(0xFFFFFFFF); // Text on surface
  static const onError = Color(0xFFFFFFFF); // Text on error
  static const secondaryText = Color(0xFFB0B0B0); // For less important text

  // Light theme colors
  static const lightBackground = Color(0xFFF5F5F5);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightPrimary = Color(0xFF121212);
  static const lightSecondary = Color(0xFF1976D2); // Blue accent
  static const lightError = Color(0xFFD32F2F);
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightOnBackground = Color(0xFF121212);
  static const lightOnSurface = Color(0xFF121212);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightSecondaryText = Color(0xFF757575);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        surface: AppColors.background,
        onSurface: AppColors.onBackground,
        error: AppColors.error,
        onError: AppColors.onError,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      cardColor: AppColors.surface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.secondary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.primary),
        bodyMedium: TextStyle(color: AppColors.secondaryText),
        titleLarge:
            TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// light theme
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.lightPrimary,
        onPrimary: AppColors.lightOnPrimary,
        secondary: AppColors.lightSecondary,
        onSecondary: AppColors.lightOnSecondary,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightOnSurface,
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBackground,
      cardColor: AppColors.lightSurface,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        foregroundColor: AppColors.lightPrimary,
        elevation: 0,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.lightSecondary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightSecondary,
        foregroundColor: AppColors.lightOnSecondary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.lightPrimary),
        bodyMedium: TextStyle(color: AppColors.lightSecondaryText),
        titleLarge: TextStyle(
            color: AppColors.lightPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
