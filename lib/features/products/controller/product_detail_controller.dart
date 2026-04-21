import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/cart/controller/cart_controller.dart';
import 'package:alchef/features/cart/model/cart_model.dart';
import 'package:alchef/features/cart/repo/cart_repository.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:alchef/features/products/repo/product_repository.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final int productId;
  ProductDetailController({required this.productId});

  final cart = Get.find<CartController>();

  @override
  void onInit() {
    fetchDetail();
    super.onInit();
  }

  final isLoading = false.obs;
  final selectedVariant = Rxn<ProductVariant>();
  final selectedMarianation = Rxn<Marianation>();
  ProductDetailResponse? productDetailResponse;
  String? error;

  Future<void> fetchDetail() async {
    try {
      isLoading.value = true;
      error = null;
      final request = ProductDetailRequest(
        userId: AuthHelper.userId,
        productId: productId,
      );
      productDetailResponse = await ProductRepository.getProductDetail(request);

      final variants = productDetailResponse?.data.productVarient ?? [];
      selectedVariant.value = variants.isNotEmpty ? variants.first : null;
    } catch (e) {
      error = UiHelper.getMsgFromException(e);
    } finally {
      isLoading.value = false;
    }
  }

  void selectVariant(ProductVariant variant) {
    selectedVariant.value = variant;
  }

  void selectMarianation(Marianation marianation) {
    if (selectedMarianation.value?.id == marianation.id) {
      selectedMarianation.value = null;
    } else {
      selectedMarianation.value = marianation;
    }
  }

  //--------------- ADD TO CART ----------

  final quantity = 1.obs;

  Future<void> addToCart() async {
    try {
      if (selectedVariant.value == null) {
        UiHelper.showErrorMessage('Please select a variant');
        return;
      }

      final marinations = productDetailResponse?.marinations ?? [];

      if (marinations.isNotEmpty && selectedMarianation.value == null) {
        UiHelper.showErrorMessage('Please select a marination');
        return;
      }

      UiHelper.showLoadingDialog();

      final request = AddCartRequest(
        userId: AuthHelper.userId,
        productId: productId,
        varientId: selectedVariant.value?.id ?? 0,
        marinationId: selectedMarianation.value?.id ?? 0,
        qty: quantity.value,
      );
      await CartRepository.addCart(request);
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
      cart.fetchCart();
    }
  }
}
