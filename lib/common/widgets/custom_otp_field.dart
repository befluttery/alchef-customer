import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({
    super.key,
    required this.length,
    required this.boxHeight,
    required this.boxWidth,
    required this.controller,
    this.validator,
  });

  final int length;
  final double boxHeight;
  final double boxWidth;
  final TextEditingController controller;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    final baseDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(s.inputRadius),
    );

    final baseTextStyle = TextStyle(
      fontSize: s.fontXl,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );

    final baseMargin = EdgeInsets.symmetric(horizontal: s.spacingXs);

    return Pinput(
      length: length,
      controller: controller,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      autofocus: false,
      validator: validator,
      defaultPinTheme: PinTheme(
        width: boxWidth,
        height: boxHeight,
        margin: baseMargin,
        decoration: baseDecoration.copyWith(
          color: AppColors.inputFill,
          border: Border.all(width: 1.5, color: AppColors.inputBorder),
        ),
        textStyle: baseTextStyle,
      ),
      focusedPinTheme: PinTheme(
        width: boxWidth,
        height: boxHeight,
        margin: baseMargin,
        decoration: baseDecoration.copyWith(
          color: AppColors.inputFill,
          border: Border.all(width: 2, color: AppColors.primary),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        textStyle: baseTextStyle,
      ),
      submittedPinTheme: PinTheme(
        width: boxWidth,
        height: boxHeight,
        margin: baseMargin,
        decoration: baseDecoration.copyWith(
          color: AppColors.inputFill,
          border: Border.all(width: 1.5, color: AppColors.inputBorder),
        ),
        textStyle: baseTextStyle,
      ),
      errorPinTheme: PinTheme(
        width: boxWidth,
        height: boxHeight,
        margin: baseMargin,
        decoration: baseDecoration.copyWith(
          color: AppColors.errorBg,
          border: Border.all(width: 1.5, color: AppColors.error),
        ),
        textStyle: baseTextStyle.copyWith(color: AppColors.error),
      ),
    );
  }
}
