import 'package:get/get.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/orders/model/order_model.dart';
import 'package:alchef/features/orders/repo/order_repository.dart';

class OrderController extends GetxController {
  var isLoading = false.obs;
  OrderDetailResponse? orderDetailResponse;
  String? error;

  Future<void> fetchDetail(int orderId) async {
    try {
      isLoading.value = true;
      error = null;

      final request = OrderDetailRequest(
        userId: AuthHelper.userId,
        orderId: orderId,
      );

      orderDetailResponse = await OrderRepository.getOrderDetail(request);
    } catch (e) {
      error = UiHelper.getMsgFromException(e);
    } finally {
      isLoading.value = false;
    }
  }
}
