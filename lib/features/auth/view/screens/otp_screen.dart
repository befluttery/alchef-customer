import 'dart:async';
import 'package:alchef/common/widgets/custom_button.dart';
import 'package:alchef/common/widgets/custom_otp_field.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/core/utils/validation_helper.dart';
import 'package:alchef/features/auth/controller/auth_controller.dart';
import 'package:alchef/features/auth/view/widgets/logo_header.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OtpScreenArgs {
  final int userId;
  final String mobile;

  const OtpScreenArgs({required this.userId, required this.mobile});
}

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.args});

  final OtpScreenArgs args;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  static const _timerDuration = 60;
  int _secondsRemaining = _timerDuration;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsRemaining = _timerDuration);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsRemaining == 0) {
        t.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String get _maskedPhone {
    final m = widget.args.mobile;
    if (m.length < 4) return m;
    return '***** *${m.substring(m.length - 4)}';
  }

  void _onVerify() async {
    UiHelper.unfocus();
    if (_formKey.currentState?.validate() == true) {
      final success = await controller.verifyOtp(
        userId: widget.args.userId,
        mobile: widget.args.mobile,
        otp: _otpController.text.trim(),
      );
      if (success && mounted) {
        context.replace(
          AuthHelper.isProfileUpdated
              ? RoutePaths.home
              : RoutePaths.updateProfile,
        );
      }
    }
  }

  void _onResend() {
    if (_secondsRemaining > 0) return;
    controller.resendOtp(userId: widget.args.userId);
    _startTimer();
    _otpController.clear();
  }

  String get _timerLabel {
    final mins = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final secs = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);
    final screenHeight = DeviceHelper.screenHeight(context);
    final boxSize =
        (DeviceHelper.screenWidth(context) -
            s.pagePadding * 2 -
            s.spacingMd * 8) /
        4;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verification',
                      style: TextStyle(
                        fontSize: s.fontXxl,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: s.spacingXs),
                    Text(
                      'We have sent OTP on $_maskedPhone',
                      style: TextStyle(
                        fontSize: s.fontMd,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: s.spacingLg),

                    Form(
                      key: _formKey,
                      child: CustomOtpField(
                        length: 4,
                        boxHeight: boxSize,
                        boxWidth: boxSize,
                        controller: _otpController,
                        validator: ValidationHelper.validateOtp,
                      ),
                    ),
                    SizedBox(height: s.spacingMd),

                    if (_secondsRemaining > 0)
                      // Timer + Resend
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: s.spacingMd),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                value: _secondsRemaining / _timerDuration,
                                strokeWidth: 3,
                                color: AppColors.primary,
                                backgroundColor: AppColors.border,
                              ),
                            ),
                            SizedBox(width: s.spacingMd),
                            Text(
                              _timerLabel,
                              style: TextStyle(
                                fontSize: s.fontMd,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Center(
                        child: TextButton(
                          onPressed: _onResend,
                          child: Text('Resend OTP'),
                        ),
                      ),
                    SizedBox(height: s.spacingMd),

                    Obx(
                      () => CustomButton(
                        isLoading: controller.isLoading.value,
                        onPressed: _onVerify,
                        text: 'Verify',
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
