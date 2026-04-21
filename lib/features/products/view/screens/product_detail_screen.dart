import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/cart/view/widgets/cart_info_bar.dart';
import 'package:alchef/features/products/controller/product_detail_controller.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return GetBuilder<ProductDetailController>(
      init: ProductDetailController(productId: productId),
      builder: (controller) => CustomScaffold(
        appbarTitle: 'View Details',
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error != null) {
                  return ErrorContent(
                    message: controller.error,
                    onRetry: controller.fetchDetail,
                  );
                }
                final detail = controller.productDetailResponse;
                if (detail == null) return const SizedBox.shrink();

                final data = detail.data;

                final variants = data.productVarient;

                final selectedVariant = controller.selectedVariant.value;

                return ColoredBox(
                  color: AppColors.background,
                  child: Padding(
                    padding: EdgeInsets.all(s.spacingSm),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(s.pagePadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Product image ──────────────────────────────────────
                            OnlineImage(
                              link: selectedVariant?.isVarientImage ?? '',
                              width: double.infinity,
                              height: DeviceHelper.screenWidth(context) * 0.64,
                              radius: 16,
                            ),
                            SizedBox(height: s.spacingMd),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ── Name ────────────────────────────────────────
                                Text(
                                  data.name,
                                  style: TextStyle(
                                    fontSize: s.fontXl,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                    height: 1.3,
                                  ),
                                ),
                                SizedBox(height: s.spacingSm),

                                // ── Prices ──────────────────────────────────────
                                Obx(() {
                                  final v = controller.selectedVariant.value;
                                  if (v == null) return const SizedBox.shrink();
                                  final hasMrp = v.mrpPrice > v.sellingPrice;
                                  return Row(
                                    children: [
                                      if (hasMrp) ...[
                                        Text(
                                          'Dhs. ${v.mrpPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: s.fontMd,
                                            color: AppColors.textTertiary,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        SizedBox(width: s.spacingSm),
                                      ],
                                      Text(
                                        'Dhs. ${v.sellingPrice.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: s.fontXl,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                                SizedBox(height: s.spacingSm),

                                // ── Shipping & meta ─────────────────────────────
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Shipping ',
                                        style: TextStyle(
                                          fontSize: s.fontSm,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' calculated at checkout.',
                                        style: TextStyle(
                                          fontSize: s.fontSm,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: s.spacingMd),
                                Obx(() {
                                  final v = controller.selectedVariant.value;
                                  return Row(
                                    children: [
                                      // Text(
                                      //   'Type : ',
                                      //   style: TextStyle(
                                      //     fontSize: s.fontSm,
                                      //     color: AppColors.textSecondary,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   'Raw Meat',
                                      //   style: TextStyle(
                                      //     fontSize: s.fontSm,
                                      //     fontWeight: FontWeight.w600,
                                      //     color: AppColors.textPrimary,
                                      //   ),
                                      // ),
                                      // SizedBox(width: s.spacingMd),
                                      // Container(
                                      //   width: 1,
                                      //   height: 12,
                                      //   color: AppColors.border,
                                      // ),
                                      // SizedBox(width: s.spacingMd),
                                      Text(
                                        'Availability : ',
                                        style: TextStyle(
                                          fontSize: s.fontSm,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      Text(
                                        v?.inStock == true
                                            ? 'In Stock'
                                            : 'Sold out',
                                        style: TextStyle(
                                          fontSize: s.fontSm,
                                          fontWeight: FontWeight.w600,
                                          color: v?.inStock == true
                                              ? AppColors.success
                                              : AppColors.error,
                                        ),
                                      ),
                                    ],
                                  );
                                }),

                                SizedBox(height: s.spacingMd),
                                Divider(color: AppColors.divider, height: 1),
                                SizedBox(height: s.spacingMd),

                                // ── Choose Weight ────────────────────────────────
                                Text(
                                  'Choose Weight',
                                  style: TextStyle(
                                    fontSize: s.fontLg,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: s.spacingMd),

                                GridView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: variants.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 12,
                                        crossAxisSpacing: 12,
                                        childAspectRatio: 2.6,
                                      ),
                                  itemBuilder: (context, index) {
                                    final v = variants[index];
                                    return _VariantChip(
                                      variant: v,
                                      isSelected:
                                          controller
                                              .selectedVariant
                                              .value
                                              ?.id ==
                                          v.id,
                                      onTap: () => controller.selectVariant(v),
                                      s: s,
                                    );
                                  },
                                ),
                                SizedBox(height: s.spacingLg),
                                Divider(color: AppColors.divider, height: 1),
                                SizedBox(height: s.spacingLg),

                                // ── Description ──────────────────────────────────
                                Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: s.fontLg,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: s.spacingSm),
                                Text(
                                  data.description,
                                  style: TextStyle(
                                    fontSize: s.fontMd,
                                    color: AppColors.textSecondary,
                                    height: 1.6,
                                  ),
                                ),

                                // ── Marination Style ──────────────────────────────────
                                Obx(() {
                                  final mariantion =
                                      controller.selectedMarianation.value;

                                  if (mariantion == null) {
                                    return SizedBox();
                                  }

                                  return Column(
                                    children: [
                                      SizedBox(height: s.spacingLg),
                                      Divider(
                                        color: AppColors.divider,
                                        height: 1,
                                      ),
                                      SizedBox(height: s.spacingLg),

                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '${mariantion.name} - ',
                                              style: TextStyle(
                                                fontSize: s.fontLg,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            TextSpan(
                                              text: mariantion.description,
                                              style: TextStyle(
                                                fontSize: s.fontMd,
                                                color: AppColors.textSecondary,
                                                height: 1.6,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),

                                // ── Marination Option ────────────────────────────
                                if (detail.marinations.isNotEmpty) ...[
                                  SizedBox(height: s.spacingLg),
                                  Divider(color: AppColors.divider, height: 1),
                                  SizedBox(height: s.spacingLg),
                                  Text(
                                    'Marination Option',
                                    style: TextStyle(
                                      fontSize: s.fontLg,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: s.spacingMd),
                                  Wrap(
                                    spacing: s.spacingSm,
                                    runSpacing: s.spacingSm,
                                    children: detail.marinations.map((m) {
                                      final isSelected =
                                          controller
                                              .selectedMarianation
                                              .value
                                              ?.id ==
                                          m.id;
                                      return GestureDetector(
                                        onTap: () =>
                                            controller.selectMarianation(m),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: s.spacingMd,
                                            vertical: s.spacingSm,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? AppColors.primary
                                                : Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              s.cardRadius,
                                            ),
                                            border: Border.all(
                                              color: isSelected
                                                  ? AppColors.primary
                                                  : AppColors.border,
                                            ),
                                          ),
                                          child: Text(
                                            m.name,
                                            style: TextStyle(
                                              fontSize: s.fontMd,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                              color: isSelected
                                                  ? AppColors.textOnPrimary
                                                  : AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],

                                SizedBox(height: s.spacingXl),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            // ── Quantity + Add to Cart ──────────────────────────────
            Obx(() {
              final detail = controller.productDetailResponse;
              if (controller.isLoading.value ||
                  controller.error != null ||
                  detail == null) {
                return const SizedBox.shrink();
              }
              final v = controller.selectedVariant.value;
              final price = (v?.sellingPrice ?? 0) * controller.quantity.value;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CartInfoBar(),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s.pagePadding,
                      vertical: s.spacingMd,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: AppColors.divider)),
                    ),
                    child: Row(
                      children: [
                        // Quantity stepper
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _StepperButton(
                                icon: Icons.remove,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                ),
                                onTap: () {
                                  if (controller.quantity.value > 1) {
                                    controller.quantity.value--;
                                  }
                                },
                                s: s,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: s.spacingMd,
                                ),
                                child: Text(
                                  '${controller.quantity.value}',
                                  style: TextStyle(
                                    fontSize: s.fontLg,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              _StepperButton(
                                icon: Icons.add,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  bottomRight: Radius.circular(40),
                                ),
                                onTap: () => controller.quantity.value++,
                                s: s,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: s.spacingMd),

                        // Add Items button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: v?.inStock == true
                                ? controller.addToCart
                                : null,
                            child: Text(
                              v?.inStock == true
                                  ? 'Add Items Dhs. ${price.toStringAsFixed(2)}'
                                  : 'Sold out',
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
          ],
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.onTap,
    required this.s,
    required this.borderRadius,
  });

  final IconData icon;
  final VoidCallback onTap;
  final AppSizes s;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: s.buttonHeight * 0.75,
        height: s.buttonHeight * 0.75,
        decoration: BoxDecoration(
          color: AppColors.errorBg,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: s.iconSm, color: AppColors.primary),
      ),
    );
  }
}

class _VariantChip extends StatelessWidget {
  const _VariantChip({
    required this.variant,
    required this.isSelected,
    required this.onTap,
    required this.s,
  });

  final ProductVariant variant;
  final bool isSelected;
  final VoidCallback onTap;
  final AppSizes s;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: s.spacingMd,
          vertical: s.spacingSm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.05)
              : Colors.white,
          borderRadius: BorderRadius.circular(s.cardRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  variant.varient,
                  style: TextStyle(
                    fontSize: s.fontMd,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (variant.mrpPrice > variant.sellingPrice)
                        Text(
                          'Dhs. ${variant.mrpPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: s.fontXs,
                            color: AppColors.textTertiary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

                      Text(
                        'Dhs. ${variant.sellingPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: s.fontSm,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
