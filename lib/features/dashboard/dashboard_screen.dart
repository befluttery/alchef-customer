import 'package:alchef/features/cart/controller/cart_controller.dart';
import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/routes/route_paths.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.child});

  final Widget child;

  static const _tabs = [
    (image: AppImages.bnHome, label: 'Home', path: RoutePaths.home),
    (
      image: AppImages.bnCategories,
      label: 'Categories',
      path: RoutePaths.categories,
    ),
    (image: AppImages.bnCart, label: 'Cart', path: RoutePaths.cart),
    (image: AppImages.bnOrders, label: 'My Orders', path: RoutePaths.orders),
    (image: AppImages.bnProfile, label: 'My Profile', path: RoutePaths.profile),
  ];

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.find<DashboardController>();

  void _onTabTap(int index) {
    controller.currentIndex = index;
    controller.update();
    switch (index) {
      case 0:
        context.go(RoutePaths.home);
        break;
      case 1:
        context.go(RoutePaths.categoryProducts);
        break;
      case 2:
        context.go(RoutePaths.cart);
        break;
      case 3:
        context.go(RoutePaths.orders);
        break;
      case 4:
        context.go(RoutePaths.profile);
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    Get.find<CartController>().fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }

          _onTabTap(0);
        },
        child: Scaffold(
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            onTap: _onTabTap,
            currentIndex: controller.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: DashboardScreen._tabs
                .map(
                  (tab) => _navItem(
                    image: tab.image,
                    label: tab.label,
                    size: s.navIconSize,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem({
    required String image,
    required String label,
    required double size,
  }) {
    return BottomNavigationBarItem(
      icon: Image.asset(image, width: size, height: size),
      activeIcon: Image.asset(
        image,
        color: AppColors.primary,
        width: size,
        height: size,
      ),
      label: label,
    );
  }
}
