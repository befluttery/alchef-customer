import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/cart/controller/cart_controller.dart';
import 'package:alchef/features/cart/view/widgets/cart_item.dart';
import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:alchef/features/products/view/widgets/product_list.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = Get.find<CartController>();

  @override
  void initState() {
    controller.fetchCart();
    super.initState();
  }

  void _goHome() {
    Get.find<DashboardController>().changeIndex(0);
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _goHome();
      },
      child: CustomScaffold(
        onBack: _goHome,
        appbarTitle: 'Cart',
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return ErrorContent(
              message: controller.error,
              onRetry: controller.fetchCart,
            );
          }

          final cart = controller.cartResponse;
          if (cart == null) {
            return ErrorContent(message: 'Cart is empty', onRetry: null);
          }

          final items = cart.cartitems;
          final total = cart.carttotal;
          final itemCount = int.tryParse(total.isQty) ?? items.length;

          return Column(
            children: [
              // ── Scrollable content ──────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(s.pagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Cart items ─────────────────────────────────
                      ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return CartItemTile(
                            item: item,
                            s: s,
                            onIncrease: () {
                              controller.increaseQty(index);
                            },
                            onDecrease: () {
                              controller.decreaseQty(index);
                            },
                          );
                        },
                      ),

                      SizedBox(height: s.spacingLg),

                      // ── Suggested Products ─────────────────────────
                      if (cart.relatedProducts.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Suggested Products',
                              style: TextStyle(
                                fontSize: s.fontLg,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: s.spacingMd),
                        ProductList(products: cart.relatedProducts),
                        SizedBox(height: s.spacingMd),
                      ],
                    ],
                  ),
                ),
              ),

              // ── Checkout bar ────────────────────────────────────────
              Container(
                padding: EdgeInsets.all(s.spacingSm),
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

                    // Checkout button
                    GestureDetector(
                      onTap: () {
                        context.push(RoutePaths.checkout);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: s.spacingLg,
                          vertical: s.spacingSm + 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.button,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: s.fontMd,
                            fontWeight: FontWeight.w700,
                            color: AppColors.buttonText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
