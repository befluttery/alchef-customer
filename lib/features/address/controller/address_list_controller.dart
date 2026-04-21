import 'package:get/get.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/address/repo/address_repository.dart';
import 'package:alchef/features/auth/model/auth_request.dart';

class AddressListController extends GetxController {
  var isLoading = false.obs;
  List<Address> addressList = [];
  String? error;

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      final request = UserRequest(userId: AuthHelper.userId);
      addressList = await AddressRepository.getAddress(request);
    } catch (e) {
      error = UiHelper.getMsgFromException(e);
    } finally {
      isLoading.value = false;
    }
  }
}
