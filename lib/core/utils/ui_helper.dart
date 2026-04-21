import 'package:alchef/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class UiHelper {
  static void configLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withValues(alpha: 0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void showLoadingDialog() => EasyLoading.show();

  static void closeLoadingDialog() => EasyLoading.dismiss();

  static void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

  static void showToast(String message, {Color bgColor = Colors.black}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 14,
    );
  }

  static void showSnackbar(String message, {Color? bgColor}) {
    final currentCtx = appNavigatorKey.currentContext;
    if (currentCtx != null) {
      ScaffoldMessenger.of(currentCtx).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: bgColor),
      );
    }
  }

  static String getMsgFromException(dynamic e) {
    final message = e.toString().replaceFirst('Exception: ', '');
    return message;
  }

  static void showErrorMessage(dynamic e) {
    if (e != null) {
      final message = getMsgFromException(e.toString());
      // showToast(message);
      showSnackbar(message);
    }
  }

  static void showCameraRestrictedAlert(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: const Text('Camera Permission Required'),
      content: const Text('We need access to the camera to take pictures'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            openAppSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );

  static void showGalleryRestrictedAlert(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog.adaptive(
      title: const Text('Photo Permission Required'),
      content: const Text('We need access to the gallery to take pictures'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            openAppSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}
