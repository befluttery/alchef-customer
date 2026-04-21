import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.isLoading = false,
    required this.onPressed,
    required this.text,
  });

  final bool isLoading;
  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ElevatedButton(
        onPressed: () {},
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.4,
          ),
        ),
      );
    } else {
      return ElevatedButton(onPressed: onPressed, child: Text(text));
    }
  }
}
