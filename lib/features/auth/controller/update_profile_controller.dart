import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/address/repo/address_repository.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/auth/repository/auth_repository.dart';
import 'package:get/state_manager.dart';

class UpdateProfileController extends GetxController {
  final isLoading = false.obs;

  AddAddressRequest? addAddressRequest;

  Future<bool> addAddress() async {
    try {
      if (addAddressRequest == null) {
        return false;
      }

      final result = await AddressRepository.addAddress(addAddressRequest!);

      if (result.isNotEmpty) {
        UiHelper.showToast(result);
      }
      return true;
    } catch (e) {
      UiHelper.showErrorMessage(e);
      return false;
    }
  }

  Future<bool> updateProfile({
    required String firstName,
    required String email,
    required String referralCode,
  }) async {
    try {
      final request = UpdateProfileRequest(
        userId: AuthHelper.userId,
        firstName: firstName,
        email: email,
        referralCode: referralCode.isEmpty ? null : referralCode,
      );

      final result = await AuthRepository.updateProfile(request);

      await AuthHelper.saveUserData(result);
      return true;
    } catch (e) {
      UiHelper.showErrorMessage(e);
      return false;
    } finally {}
  }



}
