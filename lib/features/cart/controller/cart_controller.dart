import 'dart:io';

import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/date_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/cart/model/cart_model.dart';
import 'package:alchef/features/cart/repo/cart_repository.dart';
import 'package:alchef/features/coupon/model/coupon_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartController extends GetxController {
  final isLoading = false.obs;
  CartResponse? cartResponse;
  String? error;

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      error = null;
      cartResponse = null;

      final request = UserRequest(userId: AuthHelper.userId);

      cartResponse = await CartRepository.viewCart(request);
    } catch (e) {
      error = UiHelper.getMsgFromException(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> increaseQty(int index, {bool onCheckOut = false}) async {
    try {
      final item = cartResponse?.cartitems[index];
      if (item == null) return;
      UiHelper.showLoadingDialog();
      final request = AddCartRequest(
        userId: AuthHelper.userId,
        productId: item.productId,
        varientId: item.varientId,
        marinationId: item.marinationId,
        qty: item.qty + 1,
      );
      await CartRepository.addCart(request);
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
      await fetchCart();

      if (onCheckOut) {
        await calculateAmount();
      }
    }
  }

  Future<void> decreaseQty(int index, {bool onCheckOut = false}) async {
    try {
      final item = cartResponse?.cartitems[index];
      if (item == null) return;
      UiHelper.showLoadingDialog();

      if (item.qty == 1) {
        final request = RemoveCartRequest(
          userId: AuthHelper.userId,
          itemId: item.id,
        );

        await CartRepository.removeCart(request);
      } else {
        final request = AddCartRequest(
          userId: AuthHelper.userId,
          productId: item.productId,
          varientId: item.varientId,
          marinationId: item.marinationId,
          qty: item.qty - 1,
        );
        await CartRepository.addCart(request);
      }
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
      await fetchCart();

      if (onCheckOut) {
        await calculateAmount();
      }
    }
  }

  Future<void> removeCart(int index, {bool onCheckOut = false}) async {
    try {
      final item = cartResponse?.cartitems[index];
      if (item == null) return;
      UiHelper.showLoadingDialog();
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
      await fetchCart();

      if (onCheckOut) {
        calculateAmount();
      }
    }
  }

  Future<void> clearCart() async {
    try {
      if (cartResponse == null) {
        return;
      }

      UiHelper.showLoadingDialog();
      final request = UserRequest(userId: AuthHelper.userId);

      final result = await CartRepository.clearCart(request);
      cartResponse = null;
      refresh();
      UiHelper.showToast(result);
    } catch (e) {
      UiHelper.showErrorMessage(e);
    } finally {
      UiHelper.closeLoadingDialog();
      isLoading.refresh();
    }
  }

  // --------------- SLOTS ---------------------
  var slotsLoading = false.obs;
  List<Slot> slots = [];
  String? slotsError;

  var selectedDate = DateTime.now().obs;
  var selectedSlotId = RxnInt();

  Future<void> fetchSlots() async {
    try {
      if (cartResponse == null) {
        return;
      }

      slotsLoading.value = true;
      selectedSlotId.value = null;
      slotsError = null;
      slots.clear();
      update();
      slots = await CartRepository.getSlots(
        userId: AuthHelper.userId,
        date: DateFormat('dd-MM-yyyy').format(selectedDate.value),
      );
    } catch (e) {
      slotsError = UiHelper.getMsgFromException(e);
    } finally {
      slotsLoading.value = false;
    }
  }

  // --------------- CALCULATION/CHECKOUT ---------------------

  var calculationLoading = false.obs;
  OrderCalculationResponse? orderCalculationResponse;

  String? calculationError;
  var isWalletIncluded = false.obs;
  Address? selectedAddress = AuthHelper.user.userDefaultAddress;
  var selectedCoupon = Rxn<Coupon>();

  Future<void> calculateAmount() async {
    try {
      if (cartResponse == null) {
        return;
      }

      calculationLoading.value = true;
      orderCalculationResponse = null;
      calculationError = null;
      update();

      final request = OrderCalculationRequest(
        userId: AuthHelper.userId,
        cartId: cartResponse!.carttotal.id,
        useWallet: isWalletIncluded.value ? 1 : 0,
        couponId: selectedCoupon.value?.id,
        userAddressId: selectedAddress?.id ?? 0,
      );

      orderCalculationResponse = await CartRepository.orderCalculation(request);
    } catch (e) {
      calculationError = UiHelper.getMsgFromException(e);
    } finally {
      calculationLoading.value = false;
    }
  }

  List<(String, String)> paymentMethods = [
    ('Online', 'CC'),
    ('Cash on Delivery', 'COD'),
  ];

  // --------------- PLACE ORDER ---------------------

  var selectedPaymentMethod = 'CC'.obs;

  Future<bool> reviewAndPlaceOrder() async {
    try {
      final calculationData = orderCalculationResponse;

      if (cartResponse == null || calculationData == null) {
        return false;
      }

      if (selectedAddress == null) {
        UiHelper.showToast('Please add address');
        return false;
      }

      UiHelper.showLoadingDialog();

      // final reviewRequest = ReviewCartRequest(
      //   userId: AuthHelper.userId,
      //   cartId: cartResponse!.cartTotal.id,
      // );

      // final reviewResult = await CartRepository.reviewCart(reviewRequest);

      // if (reviewResult.status == 1) {
      final placeOrderRequest = PlaceOrderRequest(
        comments: '',
        totalPrice: calculationData.totalAmount,
        subTotal: calculationData.subTotal.toString(),
        userPk: AuthHelper.userId,
        paymentMethod: selectedPaymentMethod.value,
        shippingAmount: calculationData.deliveryFee,
        shippingMethod: 1,
        cartId: cartResponse!.carttotal.id,
        userAddressId: selectedAddress?.id ?? 0,
        deliverySlotId: 0,
        deliveryDate: DateHelper.formatString(DateTime.now()),
        deliveryInfo: '',
        couponId: calculationData.coupon?.id,
        discount: calculationData.discount,
        usedWalletAmt: calculationData.usedWalletAmt,
        usedWalletPoints: calculationData.usedWalletPoints,
        remainingWalletPoints: calculationData.remainingWalletPoints,
        orderFrom: Platform.isIOS ? 'IOS' : 'ANDROID',
      );

      final result = await CartRepository.placeOrder(placeOrderRequest);

      UiHelper.showSnackbar(result);
      return true;
      // }
    } catch (e) {
      UiHelper.showErrorMessage(e);

      return false;
    } finally {
      UiHelper.closeLoadingDialog();
    }
  }
}
