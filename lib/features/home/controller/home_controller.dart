import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:alchef/features/category/repo/category_repository.dart';
import 'package:alchef/features/home/model/home_model.dart';
import 'package:alchef/features/home/repo/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  void initialize(){
    Future.wait([fetchBanners(),
    fetchCategories(),
    fetchCategoryProducts(),]);
  }
  // ------------------------- BANNERS -------------------------
  final bannersLoading = false.obs;
  List<Banner> banners = [];
  String? bannersError;
  final activeBannerIndex = 0.obs;

  Future<void> fetchBanners() async {
    try {
      bannersLoading.value = true;
      bannersError = null;

      final request = UserRequest(userId: AuthHelper.userId);
      banners = await HomeRepository.getBanners(request);
    } catch (e) {
      bannersError = UiHelper.getMsgFromException(e);
    } finally {
      bannersLoading.value = false;
    }
  }

  // ------------------------- CATEGORIES -------------------------
  final categoriesLoading = false.obs;
  List<Category> categories = [];
  String? categoriesError;

  Future<void> fetchCategories() async {
    try {
      categoriesLoading.value = true;
      categoriesError = null;

      final request = CategoryListRequest(userId: AuthHelper.userId, pageNo: 0);
      categories = await CategoryRepository.getCategories(request);
    } catch (e) {
      categoriesError = UiHelper.getMsgFromException(e);
    } finally {
      categoriesLoading.value = false;
    }
  }

  // ------------------------- PRODUCTS -------------------------
  final productsLoading = false.obs;
  List<HomeCategoryProduct> homeCategoryProducts = [];
  String? productsError;

  Future<void> fetchCategoryProducts() async {
    try {
      productsLoading.value = true;
      productsError = null;

      final request = UserRequest(userId: AuthHelper.userId);
      homeCategoryProducts = await HomeRepository.getCategoryProducts(request);
    } catch (e) {
      productsError = UiHelper.getMsgFromException(e);
    } finally {
      productsLoading.value = false;
    }
  }
}
