import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============================================================
  // BRAND
  // ============================================================

  /// Deep red — primary brand color, app bars, active states
  static const Color primary = Color(0xFF800F02);
  static const Color primaryLight = Color(0xFFAA1A08);
  static const Color primaryDark = Color(0xFF5A0A01);

  /// Yellow — buttons, CTAs
  static const Color button = Color(0xFFFDD947);
  static const Color buttonText = Color(0xFF1C1C1C);

  /// Light green — input field fill
  static const Color inputFill = Color(0xFFF6FFF2);

  // ============================================================
  // BACKGROUNDS & SURFACES
  // ============================================================

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  // ============================================================
  // TEXT
  // ============================================================

  static const Color textPrimary = Color(0xFF1C1C1C);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFFADADAD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnButton = Color(0xFF1C1C1C);

  // ============================================================
  // BORDERS & DIVIDERS
  // ============================================================

  static const Color border = Color(0xFFE5E5E5);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color inputBorder = Color(0xFFD6EDD0);

  // ============================================================
  // SEMANTIC
  // ============================================================

  static const Color success = Color(0xFF4CAF50);
  static const Color successBg = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFFA726);
  static const Color warningBg = Color(0xFFFFF3E0);
  static const Color error = Color(0xFFE53935);
  static const Color errorBg = Color(0xFFFFEBEE);

  // ============================================================
  // FOOD TAGS
  // ============================================================

  static const Color tagVeg = Color(0xFF4CAF50);
  static const Color tagVegBg = Color(0xFFE8F5E9);
  static const Color tagNonVeg = Color(0xFFE53935);
  static const Color tagNonVegBg = Color(0xFFFFEBEE);
  static const Color tagBestseller = Color(0xFFFFA726);
  static const Color tagBestsellerBg = Color(0xFFFFF3E0);

  // ============================================================
  // ORDER STATUS
  // ============================================================

  static const Color statusPlaced = Color(0xFF2196F3);
  static const Color statusPreparing = Color(0xFFFFA726);
  static const Color statusOnTheWay = Color(0xFF7C3AED);
  static const Color statusDelivered = Color(0xFF4CAF50);
  static const Color statusCancelled = Color(0xFF9E9E9E);

  // ============================================================
  // UTILITY
  // ============================================================

  static const Color ratingFilled = Color(0xFFFFC107);
  static const Color ratingEmpty = Color(0xFFE0E0E0);

  static const Color shimmerBase = Color(0xFFEEEEEE);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x14000000);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
}
