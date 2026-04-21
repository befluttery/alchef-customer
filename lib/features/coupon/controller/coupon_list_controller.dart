import 'package:get/get.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/coupon/model/coupon_model.dart';
import 'package:alchef/features/coupon/repo/coupon_repository.dart';

class CouponListController extends GetxController {
  bool isLoading = false;
  List<Coupon> coupons = [];
  String? error;

  Future<void> fetchCoupons() async {
    try {
      isLoading = true;
      error = null;
      update();

      final request = UserRequest(userId: AuthHelper.userId);

      coupons = await CouponRepository.getCoupons(request);
    } catch (e) {
      error = UiHelper.getMsgFromException(e);
    } finally {
      isLoading = false;
      update();
    }
  }
}
