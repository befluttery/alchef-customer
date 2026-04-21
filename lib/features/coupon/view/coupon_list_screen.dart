import 'package:alchef/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/no_data.dart';
import 'package:alchef/common/widgets/primary_loader.dart';
import 'package:alchef/features/coupon/controller/coupon_list_controller.dart';
import 'package:alchef/features/coupon/model/coupon_model.dart';
import 'package:alchef/features/coupon/view/coupon_item.dart';

class CouponListScreen extends StatefulWidget {
  const CouponListScreen({super.key, required this.onSelect});

  final Function(Coupon coupon) onSelect;

  @override
  State<CouponListScreen> createState() => _CouponListScreenState();
}

class _CouponListScreenState extends State<CouponListScreen> {
  final controller = Get.put(CouponListController());

  @override
  void initState() {
    controller.fetchCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return CustomScaffold(
      appbarTitle: 'Coupons',
      padding: EdgeInsets.zero,
      body: GetBuilder<CouponListController>(
        builder: (controller) {
          if (controller.isLoading) {
            return PrimaryLoader();
          }
          if (controller.error != null) {
            return ErrorContent(message: controller.error, onRetry: null);
          }

          final coupons = controller.coupons;

          if (coupons.isEmpty) {
            return NoData(onRetry: null);
          }
          return ListView.separated(
            padding: EdgeInsets.all(s.pagePadding),
            itemCount: coupons.length,
            separatorBuilder: (context, index) => SizedBox(height: s.spacingMd),
            itemBuilder: (context, index) =>
                CouponItem(coupon: coupons[index], onSelect: widget.onSelect),
          );
        },
      ),
    );
  }
}
