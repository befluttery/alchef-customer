import 'package:get/get.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/orders/model/order_model.dart';
import 'package:alchef/features/orders/repo/order_repository.dart';

class OrderListController extends GetxController {
  var isLoading = false.obs;
  int? pageNo;
  String? error;
  var orders = <Order>[];
  var paginationLoading = false.obs;

  Future<void> fetchOrders({required bool initialize}) async {
    try {
      if (initialize) {
        orders.clear();
        pageNo = 0;
        isLoading.value = true;
      } else {
        paginationLoading.value = true;
      }
      error = null;
      pageNo = orders.length;

      final request = OrderListRequest(
        userId: AuthHelper.userId,
        pageNo: pageNo ?? 0,
      );

      final result = await OrderRepository.getOrders(request);

      orders.addAll(result);
    } catch (e) {
      if (initialize) {
        error = UiHelper.getMsgFromException(e);
      }
    } finally {
      if (initialize) {
        isLoading.value = false;
      } else {
        paginationLoading.value = false;
      }
    }
  }

  bool get canScroll =>
      pageNo != null &&
      pageNo != orders.length &&
      !isLoading.value &&
      !paginationLoading.value;
}
