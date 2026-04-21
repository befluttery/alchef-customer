// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart' as syspath;

class DeviceHelper {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double statusbarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottombarHeight(BuildContext context) =>
      MediaQuery.of(context).padding.bottom + 10;

  // static Future<Device> getDeviceInfo() async {
  //   final deviceInfoPlugin = DeviceInfoPlugin();

  //   if (Platform.isIOS) {
  //     var iosInfo = await deviceInfoPlugin.iosInfo;

  //     return Device(
  //       id: iosInfo.identifierForVendor ?? '',
  //       type: 'IOS',
  //       name: iosInfo.name,
  //     );
  //   } else {
  //     var androidInfo = await deviceInfoPlugin.androidInfo;

  //     return Device(
  //       id: androidInfo.id,
  //       type: 'ANDROID',
  //       name: androidInfo.brand,
  //     );
  //   }
  // }

  // static Future<String> getFCM() async {
  //   try {
  //     final fcm = FirebaseMessaging.instance;
  //     String? token = Platform.isIOS
  //         ? await fcm.getAPNSToken()
  //         : await fcm.getToken();
  //     if (kDebugMode) {
  //       print(token);
  //     }
  //     return token ?? 'fcmtoken';
  //   } catch (e) {
  //     return 'fcmtoken';
  //   }
  // }
}

class Device {
  final String id;
  final String type;
  final String name;

  Device({required this.id, required this.type, required this.name});
}
