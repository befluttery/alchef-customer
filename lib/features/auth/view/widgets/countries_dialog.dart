import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountriesDialog extends StatelessWidget {
  const CountriesDialog({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(s.cardRadius * 2),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 400,
        margin: EdgeInsets.symmetric(horizontal: s.spacingMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(s.cardRadius * 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.fromLTRB(
                s.spacingLg,
                s.spacingLg,
                s.spacingMd,
                s.spacingMd,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(s.cardRadius * 2),
                  topRight: Radius.circular(s.cardRadius * 2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.public,
                    color: Colors.blue.shade600,
                    size: s.iconMd,
                  ),
                  SizedBox(width: s.spacingMd - 4),
                  Text(
                    'Select Country',
                    style: TextStyle(
                      fontSize: s.fontLg,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey.shade600,
                      size: s.fontXl,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.all(s.spacingSm),
                      minimumSize: Size(s.spacingXl, s.spacingXl),
                    ),
                  ),
                ],
              ),
            ),

            // Countries list
            Expanded(
              child: Obx(() {
                if (controller.countries.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(s.spacingXl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.public_off,
                          color: Colors.grey.shade400,
                          size: s.iconLg + 16,
                        ),
                        SizedBox(height: s.spacingMd),
                        Text(
                          'No Countries Found',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: s.fontLg,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: s.pagePadding),

                  itemCount: controller.countries.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    thickness: 05,
                    color: Colors.grey.shade200,
                  ),
                  itemBuilder: (context, index) {
                    final country = controller.countries[index];
                    return InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        controller.selectedCountry.value = country;
                      },
                      borderRadius: BorderRadius.circular(s.spacingSm),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: s.cardPadding,
                          vertical: s.spacingMd,
                        ),
                        child: Row(
                          children: [
                            OnlineImage(
                              link: country.isImage,
                              width: s.avatarSm,
                              height: 20,
                              radius: 0,
                            ),
                            SizedBox(width: s.spacingMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    country.name,
                                    style: TextStyle(
                                      fontSize: s.fontMd,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    country.phonecode,
                                    style: TextStyle(
                                      fontSize: s.fontSm,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey.shade400,
                              size: s.fontXl,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
