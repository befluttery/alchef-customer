import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:alchef/features/products/view/widgets/product_item.dart';
import 'package:alchef/features/products/view/widgets/product_item_shimmer.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    this.scrollController,
    this.isPaginationLoading = false,
    this.shrinkWrap = false,
    this.canScroll = true,
    this.padding,
    this.isLoading = false,
    this.crossAxisCount = 2,
  });

  final List<Product> products;
  final ScrollController? scrollController;
  final bool isPaginationLoading;
  final bool shrinkWrap;
  final bool canScroll;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = DeviceHelper.screenWidth(context);
    final spacing = screenWidth * 0.036;
    final itemWidth =
        (screenWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
    final childAspectRatio = itemWidth / (itemWidth * 1.18);

    final delegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
    );

    if (isLoading) {
      return GridView.builder(
        padding: padding ?? EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: crossAxisCount * 3,
        gridDelegate: delegate,
        itemBuilder: (_, _) => const ProductItemShimmer(),
      );
    }

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding ?? EdgeInsets.zero,
      controller: scrollController,
      physics: canScroll ? null : const NeverScrollableScrollPhysics(),
      itemCount: products.length + (isPaginationLoading ? 1 : 0),
      gridDelegate: delegate,
      itemBuilder: (context, index) {
        if (index < products.length) {
          return ProductItem(product: products[index]);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
