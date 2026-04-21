import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.focusNode,
    required this.label,
    required this.hintText,
    this.readOnly = false,
    this.obscureText = false,
    this.filled = true,
    this.showHint = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.fillColor,
    this.marginBottom = 16,
    this.isFloatingLabel = true,
    this.noBorder = false,
  });

  final FocusNode? focusNode;
  final String label;
  final String hintText;
  final bool readOnly;
  final bool obscureText;
  final bool filled;
  final bool showHint;
  final Function()? onTap;
  final Function(String v)? onChanged;
  final Function()? onEditingComplete;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final double? marginBottom;
  final bool isFloatingLabel;
  final bool noBorder;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFloatingLabel && label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: s.fontMd,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: s.spacingXs),
        ],
        TextFormField(
          focusNode: focusNode,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          style: TextStyle(
            fontSize: s.inputFontSize,
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            filled: filled,
            fillColor: fillColor ?? AppColors.inputFill,
            counterText: '',
            labelText: (isFloatingLabel || showHint) && label.isNotEmpty
                ? label
                : null,
            labelStyle: TextStyle(
              fontSize: s.inputFontSize,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: s.inputFontSize,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
            ),
            suffixIcon: suffixIcon,
            border: noBorder ? InputBorder.none : null,
            enabledBorder: noBorder ? InputBorder.none : null,
            focusedBorder: noBorder ? InputBorder.none : null,
            errorBorder: noBorder ? InputBorder.none : null,
          ),
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validator: validator,
        ),
        SizedBox(height: marginBottom),
      ],
    );
  }
}
