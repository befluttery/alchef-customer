import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/auth/repository/auth_repository.dart';
import 'package:alchef/features/profile/model/profile_model.dart';
import 'package:alchef/features/profile/repo/profile_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  var selectedProfileImage = ''.obs;

  Future<void> updateProfileImage(String imagePath) async {
    try {
      UiHelper.showLoadingDialog();
      selectedProfileImage.value = imagePath;

      final request = UpdateProfileImageRequest(
        userId: AuthHelper.userId,
        imagePath: imagePath,
      );

      final updatedUser = await ProfileRepository.updateProfileImage(request);
      await AuthHelper.saveUserData(updatedUser);

      UiHelper.showToast('Profile image updated');
    } catch (e) {
      selectedProfileImage.value = '';
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String mobile,
  }) async {
    try {
      isLoading.value = true;
      final request = UpdateProfileRequest(
        userId: AuthHelper.userId,
        firstName: name,
        email: email,
      );
      final result = await AuthRepository.updateProfile(request);
      await AuthHelper.saveUserData(result);
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      isLoading.value = false;
    }
  }
}
