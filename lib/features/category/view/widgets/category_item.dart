import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category, this.onTap});

  final Category category;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final padding = width * 0.12;
        final imageSize = width - padding * 2;
        final fontSize = width * 0.14;

        return GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: AppColors.inputFill,
                  borderRadius: BorderRadius.circular(width * 0.2),
                ),
                child: OnlineImage(
                  link: category.isImage,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.fill,
                  radius: 0,
                ),
              ),
              SizedBox(height: width * 0.08),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
