import 'package:alchef/config/app_images.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.appbarTitle,
    required this.body,
    this.onBack,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  final String appbarTitle;
  final Widget body;
  final VoidCallback? onBack;
  final EdgeInsets? padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: DeviceHelper.statusbarHeight(context) + 12,
                left: 8,
                right: 16,
                bottom: 16,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.doodleBg),
                  fit: BoxFit.fitWidth,
                ),
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                ),
              ),

              child: Row(
                children: [
                  IconButton(
                    onPressed:
                        onBack ??
                        () {
                          Navigator.pop(context);
                        },
                    icon: Image.asset(AppImages.backIcon, height: 36),
                  ),
                  SizedBox(width: 8),
                  Text(
                    appbarTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  padding: padding,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: body,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
