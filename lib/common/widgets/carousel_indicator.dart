import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    super.key,
    required this.length,
    required this.activeIndex,
    this.color,
    this.activeColor,
  });
  final int length;
  final int activeIndex;
  final Color? color;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        bool isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 6,
          width: isActive ? 24 : 6,
          decoration: BoxDecoration(
            color: isActive
                ? (activeColor ?? Theme.of(context).colorScheme.secondary)
                : (color ?? Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
