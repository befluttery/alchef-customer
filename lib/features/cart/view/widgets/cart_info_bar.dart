import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/cart/controller/cart_controller.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CartInfoBar extends StatelessWidget {
  CartInfoBar({super.key});

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return Obx(() {
      final cart = controller.cartResponse;
      if (controller.isLoading.value ||
          controller.error != null ||
          cart == null) {
        return SizedBox();
      }

      final items = cart.cartitems;
      final total = cart.carttotal;
      final itemCount = int.tryParse(total.isQty) ?? items.length;

      return InkWell(
        onTap: () {
          context.go(RoutePaths.cart);
          controller.fetchCart();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: s.spacingLg,
            vertical: s.spacingSm,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              // Cart summary
              Expanded(
                child: IntrinsicHeight(
                  child: Row(
                    spacing: s.spacingSm,
                    children: [
                      Image.asset(AppImages.cartIcon, height: s.iconSm),
                      Text(
                        '$itemCount ${itemCount == 1 ? 'item' : 'items'} Added',
                        style: TextStyle(
                          fontSize: s.fontSm,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      VerticalDivider(color: Colors.grey.shade400),
                      Text(
                        'Dhs. ${total.isPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: s.fontMd,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Text(
                  'View',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: s.spacingSm),
              // Checkout button
              InkWell(
                onTap: () async {
                  // await controller.clearCart();
                  // if (afterClearCart != null) {
                  //   afterClearCart!();
                  // }

                  await controller.clearCart();
                },
                child: Image.asset(AppImages.deleteIcon, height: 32),
              ),
            ],
          ),
        ),
      );
    });
  }
}
