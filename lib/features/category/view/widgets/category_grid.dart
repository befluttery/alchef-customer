import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:alchef/features/category/view/widgets/category_item.dart';
import 'package:alchef/features/category/view/widgets/category_item_shimmer.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    super.key,
    required this.categories,
    required this.onCategoryTap,
    this.scrollController,
    this.isPaginationLoading = false,
    this.shrinkWrap = false,
    this.canScroll = true,
    this.padding,
    this.isLoading = false,
    this.crossAxisCount = 4,
  });

  final List<Category> categories;
  final Function(Category category) onCategoryTap;
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
    final itemWidth = (screenWidth - 32) / crossAxisCount;
    final childAspectRatio = itemWidth / (itemWidth * 1.35);

    final delegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: screenWidth * 0.03,
      crossAxisSpacing: screenWidth * 0.02,
    );

    if (isLoading) {
      return GridView.builder(
        padding: padding ?? EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: crossAxisCount * 2,
        gridDelegate: delegate,
        itemBuilder: (_, _) => const CategoryItemShimmer(),
      );
    }

    return GridView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding ?? EdgeInsets.zero,
      controller: scrollController,
      physics: canScroll ? null : const NeverScrollableScrollPhysics(),
      itemCount: categories.length + (isPaginationLoading ? 1 : 0),
      gridDelegate: delegate,
      itemBuilder: (context, index) {
        if (index < categories.length) {
          final category = categories[index];
          return CategoryItem(
            category: category,
            onTap: () => onCategoryTap(category),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
