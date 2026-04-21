import 'package:flutter/material.dart';
import 'package:alchef/config/app_breakpoints.dart';

/// Provides layout-aware sizes for fonts, buttons, inputs, spacing, etc.
/// Use [AppSizes.of(context)] to get the correct set for the current screen.
class AppSizes {
  const AppSizes._({
    // Font sizes
    required this.fontXs,
    required this.fontSm,
    required this.fontMd,
    required this.fontLg,
    required this.fontXl,
    required this.fontXxl,

    // Icon sizes
    required this.iconSm,
    required this.iconMd,
    required this.iconLg,

    // Button
    required this.buttonHeight,
    required this.buttonFontSize,
    required this.buttonRadius,

    // Input field
    required this.inputHeight,
    required this.inputFontSize,
    required this.inputRadius,

    // Spacing
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.spacingXl,

    // Padding
    required this.pagePadding,
    required this.cardPadding,

    // Card
    required this.cardRadius,

    // Avatar / image
    required this.avatarSm,
    required this.avatarMd,
    required this.avatarLg,

    // Bottom nav icon
    required this.navIconSize,

    // Appbar
    required this.appbarHeight,
    required this.appbarFontSize,
  });

  //<-------------------------- FONT SIZES -------------------------->
  final double fontXs; // captions, badges
  final double fontSm; // secondary text
  final double fontMd; // body / default
  final double fontLg; // subtitles
  final double fontXl; // titles
  final double fontXxl; // hero / display

  //<-------------------------- ICON SIZES -------------------------->
  final double iconSm;
  final double iconMd;
  final double iconLg;

  //<-------------------------- BUTTON -------------------------->
  final double buttonHeight;
  final double buttonFontSize;
  final double buttonRadius;

  //<-------------------------- INPUT FIELD -------------------------->
  final double inputHeight;
  final double inputFontSize;
  final double inputRadius;

  //<-------------------------- SPACING -------------------------->
  final double spacingXs; // 4
  final double spacingSm; // 8
  final double spacingMd; // 16
  final double spacingLg; // 24
  final double spacingXl; // 32

  //<-------------------------- PADDING -------------------------->
  final double pagePadding;
  final double cardPadding;

  //<-------------------------- CARD -------------------------->
  final double cardRadius;

  //<-------------------------- AVATAR / IMAGE -------------------------->
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;

  //<-------------------------- BOTTOM NAV -------------------------->
  final double navIconSize;

  //<-------------------------- APPBAR -------------------------->
  final double appbarHeight;
  final double appbarFontSize;

  // -------------------------------------------------------------------------
  // Presets
  // -------------------------------------------------------------------------

  static const AppSizes mobile = AppSizes._(
    fontXs: 11,
    fontSm: 13,
    fontMd: 15,
    fontLg: 17,
    fontXl: 20,
    fontXxl: 26,

    iconSm: 18,
    iconMd: 24,
    iconLg: 32,

    buttonHeight: 48,
    buttonFontSize: 15,
    buttonRadius: 12,

    inputHeight: 48,
    inputFontSize: 14,
    inputRadius: 12,

    spacingXs: 4,
    spacingSm: 8,
    spacingMd: 16,
    spacingLg: 24,
    spacingXl: 32,

    pagePadding: 16,
    cardPadding: 12,

    cardRadius: 12,

    avatarSm: 28,
    avatarMd: 36,
    avatarLg: 56,

    navIconSize: 24,

    appbarHeight: 56,
    appbarFontSize: 18,
  );

  static const AppSizes _tablet = AppSizes._(
    fontXs: 12,
    fontSm: 14,
    fontMd: 16,
    fontLg: 18,
    fontXl: 22,
    fontXxl: 28,

    iconSm: 20,
    iconMd: 26,
    iconLg: 36,

    buttonHeight: 52,
    buttonFontSize: 16,
    buttonRadius: 14,

    inputHeight: 52,
    inputFontSize: 15,
    inputRadius: 14,

    spacingXs: 6,
    spacingSm: 12,
    spacingMd: 20,
    spacingLg: 28,
    spacingXl: 40,

    pagePadding: 24,
    cardPadding: 16,

    cardRadius: 16,

    avatarSm: 32,
    avatarMd: 44,
    avatarLg: 64,

    navIconSize: 26,

    appbarHeight: 64,
    appbarFontSize: 20,
  );

  static const AppSizes _desktop = AppSizes._(
    fontXs: 12,
    fontSm: 14,
    fontMd: 16,
    fontLg: 19,
    fontXl: 24,
    fontXxl: 32,

    iconSm: 20,
    iconMd: 28,
    iconLg: 40,

    buttonHeight: 52,
    buttonFontSize: 16,
    buttonRadius: 14,

    inputHeight: 52,
    inputFontSize: 15,
    inputRadius: 14,

    spacingXs: 8,
    spacingSm: 16,
    spacingMd: 24,
    spacingLg: 32,
    spacingXl: 48,

    pagePadding: 32,
    cardPadding: 20,

    cardRadius: 16,

    avatarSm: 32,
    avatarMd: 48,
    avatarLg: 72,

    navIconSize: 28,

    appbarHeight: 68,
    appbarFontSize: 22,
  );

  // -------------------------------------------------------------------------
  // Factory
  // -------------------------------------------------------------------------

  /// Returns the correct [AppSizes] for the current screen width.
  static AppSizes of(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (AppBreakpoints.isDesktop(width)) return _desktop;
    if (AppBreakpoints.isTablet(width)) return _tablet;
    return mobile;
  }
}
