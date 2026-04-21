import 'package:alchef/common/widgets/loading_shimmer.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:flutter/material.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final imageHeight = width * 0.65;
        final padding = width * 0.06;

        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              LoadingShimmer(width: width, height: imageHeight, radius: 0),

              // Info section
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name line 1
                    LoadingShimmer(
                      width: width * 0.85,
                      height: width * 0.1,
                      radius: 6,
                    ),
                    SizedBox(height: padding * 0.6),

                    // Price + ADD button row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // MRP
                              LoadingShimmer(
                                width: width * 0.38,
                                height: width * 0.08,
                                radius: 5,
                              ),
                              SizedBox(height: padding * 0.4),
                              // Selling price
                              LoadingShimmer(
                                width: width * 0.5,
                                height: width * 0.09,
                                radius: 6,
                              ),
                            ],
                          ),
                        ),
                        // ADD button
                        LoadingShimmer(
                          width: width * 0.4,
                          height: width * 0.16,
                          radius: 24,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
