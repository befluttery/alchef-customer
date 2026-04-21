import 'package:alchef/common/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';

class CategoryItemShimmer extends StatelessWidget {
  const CategoryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final labelWidth = width * 0.6;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LoadingShimmer(width: width, height: width, radius: width * 0.2),
            SizedBox(height: width * 0.08),
            LoadingShimmer(width: labelWidth, height: width * 0.14, radius: 6),
          ],
        );
      },
    );
  }
}
