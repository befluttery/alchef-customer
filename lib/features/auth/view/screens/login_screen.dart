import 'package:alchef/common/widgets/custom_button.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/auth/controller/auth_controller.dart';
import 'package:alchef/features/auth/view/screens/otp_screen.dart';
import 'package:alchef/features/auth/view/screens/policy_screen.dart';
import 'package:alchef/features/auth/view/widgets/countries_dialog.dart';
import 'package:alchef/features/auth/view/widgets/logo_header.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(AuthController());
  final _phoneController = TextEditingController();

  @override
  void initState() {
    controller.fetchCountries();
    super.initState();
  }

  void _onLogin() async {
    UiHelper.unfocus();
    final mobile = _phoneController.text.trim();
    final selectedCountry = controller.selectedCountry.value;
    if (selectedCountry == null) {
      UiHelper.showSnackbar('Please select country');
      return;
    }
    if (mobile.isEmpty) {
      UiHelper.showSnackbar('Please enter mobile number');
      return;
    }
    if (mobile.length < selectedCountry.minDigit) {
      UiHelper.showSnackbar(
        'For ${selectedCountry.name}, the mobile number should be ${selectedCountry.minDigit} digits}',
      );
      return;
    }
    final user = await controller.handleLogin(mobile: mobile);

    if (user != null && mounted) {
      context.push(
        RoutePaths.otp,
        extra: OtpScreenArgs(userId: user.id, mobile: user.mobile),
      );
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(height: DeviceHelper.screenHeight(context)),
            const LogoHeader(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(s.pagePadding + 8),
                height: DeviceHelper.screenHeight(context) * 0.66,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: s.fontXxl,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: s.spacingXs),
                    Text(
                      'Please enter your mobile number',
                      style: TextStyle(
                        fontSize: s.fontMd,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: s.spacingLg),

                    // Phone input
                    Container(
                      height: s.inputHeight,
                      decoration: BoxDecoration(
                        color: AppColors.inputFill,
                        borderRadius: BorderRadius.circular(s.inputRadius),
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                      child: Obx(() {
                        final selectedCountry =
                            controller.selectedCountry.value;
                        return Row(
                          children: [
                            SizedBox(width: s.spacingXs),
                            InkWell(
                              onTap: () {
                                controller.fetchCountries();
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      CountriesDialog(controller: controller),
                                );
                              },
                              child: selectedCountry == null
                                  ? Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(Icons.arrow_drop_down),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OnlineImage(
                                          link: selectedCountry.isImage,
                                          width: s.avatarSm,
                                          height: 16,
                                          radius: 0,
                                        ),
                                        SizedBox(width: s.spacingXs),
                                        Text(
                                          selectedCountry.phonecode,
                                          style: TextStyle(
                                            fontSize: s.inputFontSize,
                                          ),
                                        ),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                            ),
                            SizedBox(width: s.spacingXs),
                            VerticalDivider(color: Colors.grey.shade500),
                            SizedBox(width: s.spacingMd),
                            Expanded(
                              child: TextField(
                                maxLength:
                                    controller.selectedCountry.value?.maxDigit,
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                style: TextStyle(
                                  fontSize: s.inputFontSize,
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: 'Enter Mobile Number',
                                  hintStyle: TextStyle(
                                    fontSize: s.inputFontSize,
                                    color: AppColors.textTertiary,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: false,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: s.spacingLg),

                    Obx(
                      () => CustomButton(
                        isLoading: controller.isLoading.value,
                        onPressed: _onLogin,
                        text: 'Login',
                      ),
                    ),

                    SizedBox(height: s.spacingMd),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text:
                              'By clicking on the Login button, you agree to\nthe ',
                          style: TextStyle(
                            fontSize: s.fontSm,
                            color: AppColors.textTertiary,
                            height: 1.6,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: const TextStyle(
                                color: Color(0xFF002F61),
                                fontWeight: FontWeight.w500,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTerms,
                            ),
                          ],
                        ),

                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
