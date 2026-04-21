import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final variant = product.productVarient.isNotEmpty
        ? product.productVarient.first
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final imageHeight = width * 0.65;
        final padding = width * 0.06;
        final nameFontSize = width * 0.075;
        final priceFontSize = width * 0.072;
        final labelFontSize = width * 0.06;

        return GestureDetector(
          onTap: () {
            context.push(RoutePaths.productDetail, extra: product.id);
          },
          child: Container(
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
                // Product image
                OnlineImage(
                  link: product.isImage,
                  width: width,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  radius: 16,
                ),

                // Info section
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name + variant
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: nameFontSize,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: padding * 0.5),

                      // Prices + ADD button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (variant != null &&
                                    variant.mrpPrice > variant.sellingPrice)
                                  Text(
                                    'Dhs. ${variant.mrpPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: labelFontSize,
                                      color: AppColors.textTertiary,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  )
                                else
                                  SizedBox(height: padding * 0.6),
                                SizedBox(height: padding * 0.5),
                                Text(
                                  variant != null
                                      ? 'Dhs. ${variant.sellingPrice.toStringAsFixed(2)}'
                                      : '',
                                  style: TextStyle(
                                    fontSize: priceFontSize,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ADD button
                          Container(
                            margin: EdgeInsets.only(top: padding * 0.5),
                            padding: EdgeInsets.symmetric(
                              horizontal: padding * 1.6,
                              vertical: padding * 0.72,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.button,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                fontSize: labelFontSize,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
