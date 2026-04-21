import 'package:alchef/config/app_images.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.curvedDoodle,
          height: DeviceHelper.screenHeight(context) * 0.4,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 32,
          child: Center(child: Image.asset(AppImages.logo, height: 120)),
        ),
      ],
    );
  }
}
