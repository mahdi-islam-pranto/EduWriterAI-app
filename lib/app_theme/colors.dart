// app colors
import 'dart:ui';

class AppColors {
  // ========== PRIMARY PALETTE ==========
  /// Main brand colors based on your original palette
  static const Color primary = Color(0xFF27374D);
  static const Color secondary = Color(0xFF526D82);
  static const Color tertiary = Color(0xFF9DB2BF);
  static const Color background = Color(0xFFDDE6ED);

  // ========== PRIMARY VARIATIONS ==========
  /// Darker variations of primary colors
  static const Color primaryDark = Color(0xFF1A252E);
  static const Color primaryDarker = Color(0xFF0D1317);
  static const Color secondaryDark = Color(0xFF3E5261);
  static const Color tertiaryDark = Color(0xFF7A8E9A);

  /// Lighter variations of primary colors
  static const Color primaryLight = Color(0xFF3A4B5F);
  static const Color primaryLighter = Color(0xFF4D5F71);
  static const Color secondaryLight = Color(0xFF6B8094);
  static const Color tertiaryLight = Color(0xFFB5C7D1);

  // ========== SURFACE COLORS ==========
  /// Background and surface variations
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F8FA);
  static const Color surfaceContainer = Color(0xFFEBF1F5);
  static const Color surfaceContainerHigh = Color(0xFFE1E9ED);
  static const Color surfaceContainerHighest = Color(0xFFD7E1E5);

  // ========== TEXT COLORS ==========
  /// Text colors aligned with your dark blue-gray theme
  static const Color onPrimary =
      Color(0xFFDDE6ED); // Light text on dark primary
  static const Color onSecondary =
      Color(0xFFDDE6ED); // Light text on dark secondary
  static const Color onTertiary =
      Color(0xFF27374D); // Dark text on light tertiary
  static const Color onBackground =
      Color(0xFF27374D); // Dark text on light background
  static const Color onSurface =
      Color(0xFF27374D); // Primary dark for main text
  static const Color onSurfaceVariant =
      Color(0xFF526D82); // Secondary for subtle text

  /// Additional text hierarchy colors
  static const Color textPrimary = Color(0xFF27374D); // Main text color
  static const Color textSecondary = Color(0xFF526D82); // Secondary text color
  static const Color textTertiary = Color(0xFF9DB2BF); // Subtle/disabled text
  static const Color textOnDark = Color(0xFFDDE6ED); // Text on dark backgrounds
  static const Color textOnLight =
      Color(0xFF27374D); // Text on light backgrounds

  // ========== SEMANTIC COLORS ==========
  /// Success colors (muted green tones that complement your blue-gray palette)
  static const Color success = Color(0xFF2D5A3D); // Dark muted green
  static const Color successLight = Color(0xFF4A7C59); // Medium muted green
  static const Color successLighter = Color(0xFF7BA88A); // Light muted green
  static const Color onSuccess = Color(0xFFDDE6ED); // Your background color

  /// Warning colors (muted amber tones aligned with theme)
  static const Color warning = Color(0xFF8B6914); // Dark muted amber
  static const Color warningLight = Color(0xFFB8860B); // Medium muted amber
  static const Color warningLighter = Color(0xFFD4A574); // Light muted amber
  static const Color onWarning = Color(0xFFDDE6ED); // Your background color

  /// Error colors (muted red tones)
  static const Color error = Color(0xFF8B3A3A); // Dark muted red
  static const Color errorLight = Color(0xFFB85450); // Medium muted red
  static const Color errorLighter = Color(0xFFD48B8B); // Light muted red
  static const Color onError = Color(0xFFDDE6ED); // Your background color

  /// Info colors (using your existing blue-gray palette)
  static const Color info = Color(0xFF27374D); // Your primary color
  static const Color infoLight = Color(0xFF526D82); // Your secondary color
  static const Color infoLighter = Color(0xFF9DB2BF); // Your tertiary color
  static const Color onInfo = Color(0xFFDDE6ED); // Your background color

  // ========== EDUCATIONAL APP SPECIFIC COLORS ==========
  /// Colors for different subjects/categories (muted tones aligned with theme)
  static const Color mathematics = Color(0xFF5A4A6B); // Muted purple-gray
  static const Color science = Color(0xFF4A6B5A); // Muted green-gray
  static const Color literature = Color(0xFF6B5A4A); // Muted brown-gray
  static const Color history = Color(0xFF6B614A); // Muted tan-gray
  static const Color arts = Color(0xFF6B4A5A); // Muted rose-gray
  static const Color languages =
      Color(0xFF4A5A6B); // Muted blue-gray (similar to your palette)

  /// Achievement and progress colors (muted and theme-aligned)
  static const Color achievement = Color(0xFF8B7914); // Muted gold
  static const Color progress =
      Color(0xFF4A7C59); // Muted green (matches success)
  static const Color streak = Color(0xFF8B5A3A); // Muted orange
  static const Color milestone =
      Color(0xFF5A4A6B); // Muted purple (matches mathematics)

  // ========== UTILITY COLORS ==========
  /// Dividers and borders
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color borderLight = Color(0xFFE8E8E8);

  /// Shadows and overlays
  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  /// Disabled states
  static const Color disabled = Color(0xFF9E9E9E);
  static const Color disabledLight = Color(0xFFE0E0E0);
  static const Color onDisabled = Color(0xFF757575);

  // ========== GRADIENT COLORS ==========
  /// Gradient combinations using your palette
  static const List<Color> primaryGradient = [
    Color(0xFF27374D),
    Color(0xFF526D82),
  ];

  static const List<Color> backgroundGradient = [
    Color(0xFFDDE6ED),
    Color(0xFFFFFFFF),
  ];

  static const List<Color> cardGradient = [
    Color(0xFFF5F8FA),
    Color(0xFFEBF1F5),
  ];

  static const List<Color> successGradient = [
    Color(0xFF2E7D32),
    Color(0xFF4CAF50),
  ];

  // ========== TRANSPARENCY VARIATIONS ==========
  /// Semi-transparent versions for overlays and effects
  static const Color primaryAlpha10 = Color(0x1A27374D);
  static const Color primaryAlpha20 = Color(0x3327374D);
  static const Color primaryAlpha50 = Color(0x8027374D);
  static const Color primaryAlpha70 = Color(0xB327374D);

  static const Color secondaryAlpha10 = Color(0x1A526D82);
  static const Color secondaryAlpha20 = Color(0x33526D82);
  static const Color secondaryAlpha50 = Color(0x80526D82);

  static const Color tertiaryAlpha10 = Color(0x1A9DB2BF);
  static const Color tertiaryAlpha20 = Color(0x339DB2BF);
  static const Color tertiaryAlpha50 = Color(0x809DB2BF);
}
