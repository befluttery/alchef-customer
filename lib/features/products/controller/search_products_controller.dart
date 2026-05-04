import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:alchef/features/products/repo/product_repository.dart' show ProductRepository;
import 'package:get/get.dart';

class SearchProductsController extends GetxController {
  var isLoading = false.obs;
  List<Product> products = [];
  String? error;

  int? pageNo;
  var paginationLoading = false.obs;

  Future<void> searchProducts({
    required bool initialize,
    required String search,
  }) async {
    try {
      if (initialize) {
        products.clear();
        pageNo = 0;
        isLoading.value = true;
      } else {
        paginationLoading.value = true;
      }
      error = null;
      pageNo = products.length;

      final request = SearchProductsRequest(
        userId: AuthHelper.userId,
        pageNo: pageNo ?? 0,
        keyword: search,
      );

      final result = await ProductRepository.searchProducts(request);

      products.addAll(result);
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
      pageNo != products.length &&
      !isLoading.value &&
      !paginationLoading.value;
}
