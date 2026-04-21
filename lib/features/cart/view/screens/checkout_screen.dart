import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/loading_shimmer.dart';
import 'package:alchef/common/widgets/primary_loader.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/date_helper.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/address/view/screens/address_list_screen.dart';
import 'package:alchef/features/cart/controller/cart_controller.dart';
import 'package:alchef/features/cart/model/cart_model.dart';
import 'package:alchef/features/cart/view/widgets/cart_item.dart';
import 'package:alchef/features/coupon/view/coupon_list_screen.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final controller = Get.find<CartController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.selectedAddress ??= AuthHelper.user.userDefaultAddress;
      if (controller.selectedAddress == null) {
        // context.go(RoutePaths.address);
      }
      controller.fetchSlots();
      controller.calculateAmount();
    });
    super.initState();
  }

  void _applyCoupon() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CouponListScreen(
          onSelect: (coupon) {
            Navigator.pop(context);
            controller.selectedCoupon.value = coupon;
            controller.isWalletIncluded.value = false;
            controller.update();
            controller.calculateAmount();
          },
        ),
      ),
    );
  }

  void _removeCoupon() {
    controller.selectedCoupon.value = null;
    controller.update();
    controller.calculateAmount();
  }

  void _placeOrder() async {
    final isOrderPlaced = await controller.reviewAndPlaceOrder();

    if (mounted && isOrderPlaced) {
      context.go(RoutePaths.orders);
    }
  }

  void _increaseQty(int index) {
    controller.increaseQty(index, onCheckOut: true);
  }

  void _decreaseQty(int index) async {
    await controller.decreaseQty(index, onCheckOut: true);

    if (controller.cartResponse == null && mounted) {
      context.go(RoutePaths.cart);
    }
  }

  void _changeLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressListScreen(
          onSelectAddress: (address) {
            Navigator.pop(context);
            controller.selectedAddress = address;
            controller.calculateAmount();
          },
        ),
      ),
    );
  }

  void _changeSlotDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: controller.selectedDate.value,
      lastDate: DateTime(2100),
    );

    if (date != null) {
      controller.selectedDate.value = date;
      controller.fetchSlots();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);
    final theme = Theme.of(context);

    return CustomScaffold(
      appbarTitle: 'Checkout',
      body: Obx(() {
        if (controller.isLoading.value) {
          return PrimaryLoader();
        }

        final cart = controller.cartResponse;
        if (cart == null) return const SizedBox.shrink();

        final items = cart.cartitems;

        final isSlotsLoading = controller.slotsLoading.value;
        final slots = controller.slots;
        final slotId = controller.selectedSlotId.value;

        return Column(
          children: [
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
                          onIncrease: () => _increaseQty(index),
                          onDecrease: () => _decreaseQty(index),
                        );
                      },
                    ),

                    // ── Slots ─────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery Time Slot',
                                style: TextStyle(
                                  fontSize: s.fontSm + 2,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: s.spacingXs),
                              Text(
                                DateHelper.formatDate(
                                  controller.selectedDate.value
                                      .toIso8601String(),
                                ),

                                style: TextStyle(
                                  fontSize: s.fontMd,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: _changeSlotDate,
                          icon: Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                    SizedBox(height: s.spacingMd),
                    if (isSlotsLoading)
                      GridView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 3.6,
                            ),
                        itemBuilder: (context, index) {
                          return LoadingShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            radius: 8,
                          );
                        },
                      )
                    else
                      GridView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: slots.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 3.6,
                            ),
                        itemBuilder: (context, index) {
                          return _SlotChip(
                            slot: slots[index],
                            isSelected: slotId == slots[index].id,
                            onTap: () {
                              controller.selectedSlotId.value = slots[index].id;
                            },
                            s: s,
                          );
                        },
                      ),

                    Obx(() {
                      final isWalletIncluded =
                          controller.isWalletIncluded.value;
                      final selectedCoupon = controller.selectedCoupon.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          if (!isWalletIncluded)
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.percentageIcon,
                                    height: 24,
                                  ),
                                  SizedBox(width: 20),
                                  if (selectedCoupon != null)
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              selectedCoupon.couponCode,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),

                                          SizedBox(
                                            height: 38,
                                            width: 116,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    theme.colorScheme.primary,
                                              ),
                                              onPressed: _removeCoupon,
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Apply Coupon',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                            width: 100,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                foregroundColor: Colors.white,
                                                backgroundColor:
                                                    Colors.green.shade600,
                                              ),
                                              onPressed: _applyCoupon,
                                              child: Text('Apply'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          if (selectedCoupon == null &&
                              AuthHelper.user.rewardPoint > 0)
                            Row(
                              children: [
                                Checkbox(
                                  value: controller.isWalletIncluded.value,
                                  onChanged: (v) {
                                    if (controller.calculationLoading.value) {
                                      return;
                                    }

                                    controller.isWalletIncluded.value = v!;
                                    if (controller.isWalletIncluded.value) {
                                      controller.selectedCoupon.value = null;
                                    }
                                    controller.calculateAmount();
                                  },
                                ),
                                Text(
                                  'Redeem Points (${AuthHelper.user.rewardPoint} points)',
                                  style: TextStyle(fontSize: s.fontMd),
                                ),
                              ],
                            )
                          else
                            SizedBox(height: 16),

                          SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade200),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Obx(() {
                              final data = controller.orderCalculationResponse;

                              if (controller.calculationLoading.value) {
                                return PrimaryLoader();
                              }

                              if (controller.calculationError != null) {
                                return ErrorContent(
                                  message: controller.calculationError,
                                  onRetry: controller.calculateAmount,
                                );
                              }

                              if (data == null) {
                                return const SizedBox();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bill Summary',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  _row('Price', 'Dhs. ${data.subTotal}'),

                                  if (data.discount > 0)
                                    _row(
                                      'Coupon Discount (${data.coupon?.couponPercentage ?? 0}%)',
                                      '-Dhs. ${data.discount}',
                                      valueColor: Colors.red,
                                    ),

                                  _row(
                                    'Delivery Charge',
                                    'Dhs. ${data.deliveryFee}',
                                  ),

                                  _row(
                                    'Emirate Free',
                                    'Dhs. ${data.emirateFee}',
                                  ),

                                  Divider(height: 24),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Text(
                                        'Dhs. ${data.totalAmount}',
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    '*inclusive of GST',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 11,
                                        ),
                                  ),
                                ],
                              );
                            }),
                          ),

                          SizedBox(height: s.spacingMd),
                          Divider(thickness: 3.2, color: Colors.grey.shade200),
                          SizedBox(height: s.spacingMd),
                          Text(
                            'Payment Method',
                            style: TextStyle(
                              fontSize: s.fontMd,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          for (final method in controller.paymentMethods)
                            RadioListTile(
                              contentPadding: EdgeInsets.all(0),
                              onChanged: (value) {
                                controller.selectedPaymentMethod.value = value!;
                              },
                              groupValue:
                                  controller.selectedPaymentMethod.value,
                              value: method.$2,
                              title: Text(method.$1),
                            ),

                          SizedBox(height: s.spacingMd),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            //Confirm section
            Container(
              decoration: BoxDecoration(
                border: BorderDirectional(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: _changeLocation,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: s.pagePadding,
                        vertical: s.pagePadding,
                      ),
                      child: Row(
                        spacing: s.spacingMd,
                        children: [
                          Image.asset(AppImages.marker, height: s.iconSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Delivery Address'),
                                    SizedBox(width: s.spacingSm),
                                    Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2),
                                Text(controller.selectedAddress?.address ?? ''),
                              ],
                            ),
                          ),

                          Text(
                            'Change',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: s.fontSm,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: DeviceHelper.screenWidth(context) * 0.76,
                    child: ElevatedButton(
                      onPressed:
                          controller.slots.isEmpty ||
                              controller.selectedSlotId.value == null ||
                              controller.calculationLoading.value ||
                              controller.orderCalculationResponse == null
                          ? null
                          : _placeOrder,
                      child: Text('Place Order'),
                    ),
                  ),

                  SizedBox(height: s.spacingMd),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _row(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.slot,
    required this.isSelected,
    required this.onTap,
    required this.s,
  });

  final Slot slot;
  final bool isSelected;
  final VoidCallback onTap;
  final AppSizes s;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(s.cardRadius),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(
            slot.displayTime,
            style: TextStyle(
              fontSize: s.fontSm,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
