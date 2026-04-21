import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessAlert extends StatelessWidget {
  const OrderSuccessAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Get.find<DashboardController>().changeIndex(0);
        context.go(RoutePaths.home);
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sizes.cardRadius * 3),
        ),
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(sizes.spacingXl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.success,
                height: sizes.avatarLg,
                width: sizes.avatarLg,
                fit: BoxFit.cover,
              ),
              SizedBox(height: sizes.spacingLg),
              Text(
                'Order placed successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: sizes.fontXxl,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: sizes.spacingLg),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.find<DashboardController>().changeIndex(3);
                  context.go(RoutePaths.orders);
                },
                child: Text('View My Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
