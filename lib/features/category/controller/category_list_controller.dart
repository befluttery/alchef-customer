import 'package:get/get.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:alchef/features/category/repo/category_repository.dart';

class CategoryListController extends GetxController {
  var isLoading = false.obs;
  int? pageNo;
  String? error;
  var categories = <Category>[];
  var paginationLoading = false.obs;

  Future<void> fetchCategories({
    required bool initialize,
    String? search,
  }) async {
    try {
      if (initialize) {
        pageNo = 0;
        categories.clear();
        isLoading.value = true;
      } else {
        paginationLoading.value = true;
      }
      error = null;
      pageNo = categories.length;

      final request = CategoryListRequest(
        userId: AuthHelper.userId,
        pageNo: pageNo ?? 0,
        search: (search != null && search.isNotEmpty) ? search : null,
      );

      final result = await CategoryRepository.getCategories(request);

      categories.addAll(result);
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
      pageNo != categories.length &&
      !isLoading.value &&
      !paginationLoading.value;
}
