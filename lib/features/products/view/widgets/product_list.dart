import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:alchef/features/products/view/widgets/product_item.dart';
import 'package:alchef/features/products/view/widgets/product_item_shimmer.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required this.products,
    this.listHeight,
    this.padding,
    this.scrollController,
    this.isPaginationLoading = false,
    this.shrinkWrap = false,
    this.canScroll = true,
    this.isLoading = false,
  });

  final List<Product> products;
  final double? listHeight;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;
  final bool isPaginationLoading;
  final bool shrinkWrap;
  final bool canScroll;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);
    final screenWidth = DeviceHelper.screenWidth(context);
    final itemWidth = screenWidth * 0.4;
    final height = listHeight ?? itemWidth * 1.24;

    if (isLoading) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: padding ?? EdgeInsets.all(s.spacingSm),
          itemCount: 6,
          separatorBuilder: (_, _) => SizedBox(width: s.spacingMd),
          itemBuilder: (_, _) =>
              SizedBox(width: itemWidth, child: const ProductItemShimmer()),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: ListView.separated(
        shrinkWrap: shrinkWrap,
        physics: canScroll ? null : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: padding ?? EdgeInsets.all(s.spacingSm),
        controller: scrollController,
        itemCount: products.length + (isPaginationLoading ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(width: s.spacingMd),
        itemBuilder: (context, index) {
          if (index < products.length) {
            return SizedBox(
              width: itemWidth,
              child: ProductItem(product: products[index]),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
