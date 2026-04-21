import 'package:alchef/common/widgets/loading_shimmer.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryVerticalList extends StatelessWidget {
  const CategoryVerticalList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategoryTap,
    this.padding,
    this.scrollController,
    this.isPaginationLoading = false,
    this.isLoading = false,
  });

  final List<Category> categories;
  final EdgeInsetsGeometry? padding;

  final int? selectedCategoryId;
  final Function(Category category) onCategoryTap;
  final ScrollController? scrollController;
  final bool isPaginationLoading;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.builder(
        padding: padding ?? EdgeInsets.zero,
        itemCount: 8,
        itemBuilder: (_, _) => const _CategoryVerticalItemShimmer(),
      );
    }

    return ListView.builder(
      padding: padding ?? EdgeInsets.zero,
      controller: scrollController,
      itemCount: categories.length + (isPaginationLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < categories.length) {
          final category = categories[index];
          final isSelected = selectedCategoryId == category.id;
          return _CategoryVerticalItem(
            category: category,
            isSelected: isSelected,
            onTap: () => onCategoryTap(category),
          );
        }
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class _CategoryVerticalItem extends StatelessWidget {
  const _CategoryVerticalItem({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: isSelected ? AppColors.button : Colors.transparent,
              width: 5,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: OnlineImage(
                link: category.isImage,
                width: 40,
                height: 40,
                radius: 0,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryVerticalItemShimmer extends StatelessWidget {
  const _CategoryVerticalItemShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LoadingShimmer(width: 56, height: 56, radius: 12),
          const SizedBox(height: 6),
          LoadingShimmer(width: 48, height: 10, radius: 4),
        ],
      ),
    );
  }
}
