import 'package:alchef/core/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/routes/route_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        if (AuthHelper.isLoggedIn && AuthHelper.isProfileUpdated) {
          context.go(RoutePaths.home);
        } else {
          context.go(RoutePaths.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.doodleBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo
              Image.asset(AppImages.logo, width: s.avatarLg * 3),

              SizedBox(height: s.spacingSm),

              // App name
              Text(
                'Al Chef To Home',
                style: TextStyle(
                  fontSize: s.fontXl,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
