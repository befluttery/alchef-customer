import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTheme {
  AppTheme._();

  static const String _fontFamily = 'Inter';

  // Mobile sizes used as the theme baseline.
  // At widget level, use AppSizes.of(context) for layout-aware sizing.
  static const _s = AppSizes.mobile;

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    brightness: Brightness.light,

    // ── Color Scheme ────────────────────────────────────────
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textOnPrimary,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.textOnPrimary,
      secondary: AppColors.button,
      onSecondary: AppColors.textOnButton,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceVariant,
      error: AppColors.error,
      onError: AppColors.white,
      outline: AppColors.border,
      outlineVariant: AppColors.divider,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // ── AppBar ───────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.appbarFontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      iconTheme: const IconThemeData(color: AppColors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryDark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),

    // ── Elevated Button ──────────────────────────────────────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,
        foregroundColor: AppColors.buttonText,
        elevation: 0,
        minimumSize: Size(double.infinity, _s.buttonHeight),
        shape: StadiumBorder(),
        textStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _s.buttonFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ── Outlined Button ──────────────────────────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        minimumSize: Size(double.infinity, _s.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_s.buttonRadius),
        ),
        textStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _s.buttonFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ── Text Button ──────────────────────────────────────────
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: _s.fontMd,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    // ── Input Decoration ─────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.inputFill,
      contentPadding: EdgeInsets.symmetric(
        horizontal: _s.spacingMd,
        vertical: _s.spacingSm + 6,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_s.inputRadius),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_s.inputRadius),
        borderSide: const BorderSide(color: AppColors.inputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_s.inputRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_s.inputRadius),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_s.inputRadius),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      hintStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.inputFontSize,
        color: AppColors.textTertiary,
      ),
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.inputFontSize,
        color: AppColors.textSecondary,
      ),
      errorStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.fontXs,
        color: AppColors.error,
      ),
    ),

    // ── Card ─────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_s.cardRadius),
        side: const BorderSide(color: AppColors.border),
      ),
      margin: EdgeInsets.zero,
    ),

    // ── Bottom Navigation Bar ────────────────────────────────
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      selectedLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.fontXs,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.fontXs,
        fontWeight: FontWeight.w400,
      ),
    ),

    // ── Chip ─────────────────────────────────────────────────
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceVariant,
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.fontXs,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_s.spacingXl),
      ),
      side: BorderSide.none,
    ),

    // ── Divider ──────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    // ── Snackbar Theme ──────────────────────────────────────────────
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey.shade800,
      contentTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: _s.fontSm,
        color: AppColors.white,
      ),
      behavior: SnackBarBehavior.floating,
    ),

    // ── Text Theme ───────────────────────────────────────────
    textTheme: TextTheme(
      // Display
      displayLarge: TextStyle(
        fontSize: _s.fontXxl + 6,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: _s.fontXxl + 2,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: _s.fontXxl,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      // Headline
      headlineLarge: TextStyle(
        fontSize: _s.fontXl + 2,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: _s.fontXl,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: _s.fontLg + 1,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      // Title
      titleLarge: TextStyle(
        fontSize: _s.fontLg,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: _s.fontMd,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: _s.fontSm,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      // Body
      bodyLarge: TextStyle(
        fontSize: _s.fontMd,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: _s.fontSm,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: _s.fontXs,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      // Label
      labelLarge: TextStyle(
        fontSize: _s.fontSm + 1,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: _s.fontXs + 1,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: _s.fontXs - 1,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      ),
    ),
  );
}
