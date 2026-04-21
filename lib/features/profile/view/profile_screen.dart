import 'dart:io';

import 'package:alchef/common/widgets/custom_button.dart';
import 'package:alchef/common/widgets/custom_text_field.dart';
import 'package:alchef/common/widgets/image_upload_options.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/core/utils/validation_helper.dart';
import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:alchef/features/profile/controller/profile_controller.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    _prefillData();
    super.initState();
  }

  void _prefillData() {
    _nameController.text = AuthHelper.user.firstName;
    _emailController.text = AuthHelper.user.email;
    _mobileController.text = AuthHelper.user.mobile;
    _locationController.text =
        AuthHelper.user.userDefaultAddress?.address ?? '';
  }

  void _onSave() {
    if (_formKey.currentState?.validate() == true) {
      controller.updateProfile(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
      );
    }
  }

  void _goHome() {
    Get.find<DashboardController>().changeIndex(0);
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _goHome();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(height: DeviceHelper.screenHeight(context)),
              Stack(
                children: [
                  Image.asset(
                    AppImages.curvedDoodle,
                    height: DeviceHelper.screenHeight(context) * 0.38,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: DeviceHelper.statusbarHeight(context),
                      bottom: 12,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _goHome,
                          icon: Image.asset(AppImages.backIcon, height: 36),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'My Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 8,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => ImageUploadOptions(
                              onSelectImage: (selectedImagePath) {
                                controller.selectedProfileImage.value =
                                    selectedImagePath;

                                controller.updateProfileImage(
                                  selectedImagePath,
                                );
                              },
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            SizedBox(height: 120, width: 112),
                            Positioned(
                              top: 0,
                              child: Center(
                                child: Image.asset(
                                  AppImages.hat,
                                  height: s.avatarLg + 8,
                                  width: s.avatarLg + 16,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Center(
                                child: Obx(() {
                                  if (controller
                                      .selectedProfileImage
                                      .value
                                      .isEmpty) {
                                    return OnlineImage(
                                      link: AuthHelper.user.isUserImage,
                                      height: s.avatarLg + 20,
                                      width: s.avatarLg + 20,
                                      shape: BoxShape.circle,
                                    );
                                  }

                                  return Container(
                                    height: s.avatarLg + 20,
                                    width: s.avatarLg + 20,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(
                                            controller
                                                .selectedProfileImage
                                                .value,
                                          ),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 36,
                              child: CircleAvatar(
                                backgroundColor: AppColors.button,
                                radius: 12,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 14,
                                  color: AppColors.buttonText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(s.pagePadding + 8),
                  height: DeviceHelper.screenHeight(context) * 0.66,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          label: '',
                          hintText: 'Name',
                          keyboardType: TextInputType.name,
                          isFloatingLabel: false,
                          validator: ValidationHelper.validateName,
                        ),
                        SizedBox(height: s.spacingMd),

                        CustomTextField(
                          readOnly: true,
                          controller: _emailController,
                          label: '',
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          isFloatingLabel: false,
                          validator: ValidationHelper.validateEmail,
                        ),
                        SizedBox(height: s.spacingMd),

                        CustomTextField(
                          readOnly: true,
                          controller: _mobileController,
                          label: '',
                          hintText: 'Mobile number',
                          keyboardType: TextInputType.number,
                          isFloatingLabel: false,
                        ),
                        SizedBox(height: s.spacingMd),

                        CustomTextField(
                          readOnly: true,
                          // onTap: _chooseLocation,
                          controller: _locationController,
                          label: '',
                          hintText: 'Location',
                          keyboardType: TextInputType.emailAddress,
                          isFloatingLabel: false,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(16),
                            child: Image.asset(
                              AppImages.searchIcon,
                              height: s.iconSm,
                            ),
                          ),
                          validator: ValidationHelper.validateRequired,
                        ),

                        SizedBox(height: s.spacingLg),

                        Obx(
                          () => CustomButton(
                            // isLoading: state is UpdateProfileLoading,
                            isLoading: controller.isLoading.value,
                            onPressed: _onSave,
                            text: 'Update Profile',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
