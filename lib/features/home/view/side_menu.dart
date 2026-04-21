import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alchef/common/widgets/logout_dialog.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/features/auth/controller/auth_controller.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                top: DeviceHelper.statusbarHeight(context) + 16,
                left: 16,
                right: 16,
                bottom: 12,
              ),
              child: Row(
                children: [
                  OnlineImage(
                    link: AuthHelper.user.isUserImage,
                    height: 48,
                    width: 48,
                    radius: 0,
                    shape: BoxShape.circle,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AuthHelper.user.firstName,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          AuthHelper.user.email,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMenuItem(
                    context,
                    imagePath: AppImages.smMyorders,
                    title: 'My Orders',
                    onTap: () {
                      context.go(RoutePaths.orders);
                    },
                  ),

                  _buildMenuItem(
                    context,
                    imagePath: AppImages.smNotification,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    imagePath: AppImages.smCoupon,
                    title: 'Coupon',
                    onTap: () {
                      context.push(RoutePaths.coupons);
                    },
                  ),
                  _buildMenuItem(
                    context,
                    imagePath: AppImages.smWallet,
                    title: 'Wallet',
                    onTap: () {},
                  ),

                  _buildMenuItem(
                    context,
                    imagePath: AppImages.smHelp,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    imagePath: AppImages.smLogout,
                    title: 'Logout',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => LogoutDialog(
                          onLogout: () {
                            final controller =
                                Get.isRegistered<AuthController>()
                                ? Get.find<AuthController>()
                                : Get.put(AuthController());
                            controller.handleLogout();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: () {
      Navigator.pop(context);
      onTap();
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Image.asset(imagePath, height: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    ),
  );
}
