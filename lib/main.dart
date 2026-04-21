import 'package:alchef/core/service/hive_service.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/cart/controller/cart_controller.dart';
import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:alchef/config/app_theme.dart';
import 'package:alchef/routes/app_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await HiveService.init();
  Get.put(DashboardController(), permanent: true);
  Get.put(CartController(), permanent: true);
  runApp(const MyApp());
  UiHelper.configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: MaterialApp.router(
        title: 'Al Chef To Home',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: appRouter,
        builder: EasyLoading.init(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!,
          ),
        ),
      ),
    );
  }
}
