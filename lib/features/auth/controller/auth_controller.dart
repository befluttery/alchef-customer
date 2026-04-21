import 'dart:io';

import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/auth/model/auth_response.dart';
import 'package:alchef/features/auth/repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // ------------------------- COUNTRIES -------------------------
  var countriesLoading = false.obs;
  var countries = <Country>[].obs;
  var selectedCountry = Rxn<Country>();
  String? countriesError;

  Future<void> fetchCountries({bool showLoadingDialog = true}) async {
    try {
      countriesLoading.value = true;
      countriesError = null;

      final result = await AuthRepository.getCountries();

      countries.value = result;

      if (selectedCountry.value == null && result.isNotEmpty) {
        selectedCountry.value = result.first;
      }
    } catch (e) {
      countriesError = UiHelper.getMsgFromException(e);
    } finally {
      countriesLoading.value = false;
    }
  }

  Future<User?> handleLogin({required String mobile}) async {
    try {
      isLoading.value = true;

      final request = LoginRequest(
        mobile: mobile,
        fcmToken: 'fcmToken',
        deviceType: Platform.isIOS ? 'IOS' : 'ANDROID',
      );
      final result = await AuthRepository.login(request);
      return result;
    } catch (e) {
      UiHelper.showErrorMessage(e);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  //-------------------- OTP FLOW -------------------------
  Future<bool> verifyOtp({
    required int userId,
    required String mobile,
    required String otp,
  }) async {
    try {
      isLoading.value = true;

      final request = VerifyOtpRequest(
        userId: userId,
        mobile: mobile,
        otp: otp,
      );

      final result = await AuthRepository.verifyOtp(request);
      await AuthHelper.saveUserData(result);
      return true;
    } catch (e) {
      UiHelper.showErrorMessage(e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resendOtp({required int userId}) async {
    try {
      final request = UserRequest(userId: userId);
      final result = await AuthRepository.resendOtp(request);
      UiHelper.showSnackbar(result);
    } catch (e) {
      UiHelper.showErrorMessage(e);
    }
  }

  Future<void> handleLogout() async {
    try {
      UiHelper.showLoadingDialog();
      final request = UserRequest(userId: AuthHelper.userId);

      final result = await AuthRepository.logout(request);

      UiHelper.showToast(result);
      AuthHelper.logoutUser();
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
    }
  }
}
