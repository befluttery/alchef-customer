import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.focusNode,
    this.label,
    required this.hintText,
    this.readyOnly = false,
    this.filled = false,
    this.showHint = false,
    this.onTap,
    this.onChanged,
    this.onSubmit,
    this.onEditingComplete,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.maxLength,
    this.inputFormatters,
    this.bgColor,
    this.searchIconBgColor,
  });

  final FocusNode? focusNode;
  final String? label;
  final String hintText;
  final bool readyOnly;
  final bool filled;
  final bool showHint;
  final Function()? onTap;
  final Function(String v)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onSubmit;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final Widget? suffixIcon;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Color? bgColor;
  final Color? searchIconBgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          clipBehavior: Clip.hardEdge,
          focusNode: focusNode,
          readOnly: readyOnly,
          onTap: onTap,
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: showHint ? null : label,
            labelStyle: Theme.of(context).textTheme.labelMedium,
            hintText: hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Colors.black,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            suffixIcon: InkWell(
              onTap: onSubmit,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: searchIconBgColor ?? AppColors.button,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.all(14),
                child: Image.asset(AppImages.searchIcon, height: 12, width: 12),
              ),
            ),
            suffixIconConstraints: BoxConstraints(maxHeight: 48, maxWidth: 60),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.divider, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 1,
              ),
            ),
          ),
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          validator: validator,
        ),
      ],
    );
  }
}
