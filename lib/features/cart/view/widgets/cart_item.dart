import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/cart/model/cart_model.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.s,
    required this.onIncrease,
    required this.onDecrease,
  });

  final CartItem item;
  final AppSizes s;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    final v = item.productVarient;
    final hasMrp = v.mrpPrice > v.sellingPrice;

    return Container(
      margin: EdgeInsets.only(bottom: s.spacingMd),
      padding: EdgeInsets.all(s.cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(s.cardRadius),
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
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(s.cardRadius - 2),
            child: OnlineImage(
              link: item.product.isImage,
              width: s.avatarLg,
              height: s.avatarLg,
              radius: 0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: s.spacingMd),

          // Name + price
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.product.name} - ${v.varient}',
                  style: TextStyle(
                    fontSize: s.fontMd,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: s.spacingXs),
                if (item.marinationName.isNotEmpty) ...[
                  Text(
                    item.marinationName,
                    style: TextStyle(
                      fontSize: s.fontSm,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: s.spacingXs),
                ],
                Wrap(
                  children: [
                    if (hasMrp) ...[
                      Text(
                        'Dhs. ${v.mrpPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: s.fontSm,
                          color: AppColors.textTertiary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: s.spacingXs),
                    ],
                    Text(
                      'Dhs. ${v.sellingPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: s.fontMd,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: s.spacingSm),

          // Quantity stepper
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StepBtn(
                  icon: Icons.remove,
                  s: s,
                  onTap: onDecrease,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.spacingSm + 4),
                  child: Text(
                    '${item.qty}',
                    style: TextStyle(
                      fontSize: s.fontMd,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                _StepBtn(
                  icon: Icons.add,
                  s: s,
                  onTap: onIncrease,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  const _StepBtn({
    required this.icon,
    required this.s,
    required this.onTap,
    required this.borderRadius,
  });

  final IconData icon;
  final AppSizes s;
  final VoidCallback onTap;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.errorBg,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: s.iconSm - 2, color: AppColors.primary),
      ),
    );
  }
}
