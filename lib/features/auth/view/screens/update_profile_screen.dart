import 'package:alchef/common/widgets/custom_button.dart';
import 'package:alchef/common/widgets/custom_text_field.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/core/utils/validation_helper.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/address/view/screens/set_location_screen.dart';
import 'package:alchef/features/auth/controller/update_profile_controller.dart';
import 'package:alchef/features/auth/view/screens/policy_screen.dart';
import 'package:alchef/features/auth/view/widgets/logo_header.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final controller = Get.put(UpdateProfileController());
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _referralCodeController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onUpdateProfile() async {
    if (_formKey.currentState?.validate() == true) {
      controller.isLoading.value = true;
      final isAddressAdded = await controller.addAddress();
      if (isAddressAdded) {
        final isProfileUpdated = await controller.updateProfile(
          firstName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          referralCode: _referralCodeController.text.trim(),
        );
        if (mounted && isProfileUpdated) {
          controller.isLoading.value = false;
          context.go(RoutePaths.home);
        } else {
          controller.isLoading.value = false;
        }
      } else {
        controller.isLoading.value = false;
      }
    }
  }

  void _chooseLocation() async {
    UiHelper.unfocus();
    final args = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetLocationScreen(fromSignup: true),
      ),
    );

    if (mounted && args is AddAddressRequest) {
      _locationController.text = args.address;
      controller.addAddressRequest = args;
    }
  }

  void _onTerms() {
    UiHelper.unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PolicyScreen(
          title: 'Terms and Conditions',
          url: ApiEndpoints.termsAndConditions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);
    final screenHeight = DeviceHelper.screenHeight(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(height: screenHeight),
            const LogoHeader(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(s.pagePadding + 8),
                height: screenHeight * 0.66,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: s.fontXxl,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: s.spacingLg),

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
                        onTap: _chooseLocation,
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
                      SizedBox(height: s.spacingMd),

                      CustomTextField(
                        controller: _referralCodeController,
                        label: '',
                        hintText: 'Referral Code',
                        keyboardType: TextInputType.text,
                        isFloatingLabel: false,
                      ),
                      SizedBox(height: s.spacingLg),

                      // Terms checkbox
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _agreedToTerms,
                              onChanged: (v) =>
                                  setState(() => _agreedToTerms = v ?? false),
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              side: const BorderSide(
                                color: AppColors.border,
                                width: 1.5,
                              ),
                            ),
                          ),
                          SizedBox(width: s.spacingXs),
                          Text.rich(
                            TextSpan(
                              text: 'I Agree ',
                              style: TextStyle(
                                fontSize: s.fontMd,
                                color: AppColors.textPrimary,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTerms,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: s.spacingLg),

                      CustomButton(
                        // isLoading: state is UpdateProfileLoading,
                        isLoading: controller.isLoading.value,
                        onPressed: _agreedToTerms ? _onUpdateProfile : null,
                        text: 'Update Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
