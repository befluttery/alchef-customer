import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:alchef/features/category/view/widgets/category_item.dart';
import 'package:alchef/features/category/view/widgets/category_item_shimmer.dart';
import 'package:flutter/material.dart';

class CategoryHorizontalList extends StatelessWidget {
  const CategoryHorizontalList({
    super.key,
    required this.categories,
    this.listHeight,
    this.padding,
    this.scrollController,
    this.isPaginationLoading = false,
    this.shrinkWrap = false,
    this.canScroll = true,
    this.isLoading = false,
    this.onTap,
  });

  final List<Category> categories;
  final double? listHeight;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;
  final bool isPaginationLoading;
  final bool shrinkWrap;
  final bool canScroll;
  final bool isLoading;
  final void Function(Category category)? onTap;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);
    final screenWidth = DeviceHelper.screenWidth(context);
    final itemWidth = screenWidth * 0.18;
    final height = listHeight ?? itemWidth * 1.64;

    if (isLoading) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: padding ?? EdgeInsets.all(s.spacingSm),
          itemCount: 6,
          separatorBuilder: (_, _) => SizedBox(width: s.spacingMd),
          itemBuilder: (_, _) =>
              SizedBox(width: itemWidth, child: const CategoryItemShimmer()),
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
        itemCount: categories.length + (isPaginationLoading ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(width: s.spacingMd),
        itemBuilder: (context, index) {
          if (index < categories.length) {
            return SizedBox(
              width: itemWidth,
              child: CategoryItem(
                category: categories[index],
                onTap: onTap != null ? () => onTap!(categories[index]) : null,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
