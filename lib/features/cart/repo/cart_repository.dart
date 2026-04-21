import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/cart/model/cart_model.dart';

class CartRepository {
  static final ApiClient _apiClient = ApiClient();

  static Future addCart(AddCartRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.addCart,
      data: request.toJson(),
    );

    return response.data;
  }

  static Future removeCart(RemoveCartRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.removeCart,
      data: request.toJson(),
    );

    return response.data;
  }

  static Future<CartResponse> viewCart(UserRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.viewCart,
      data: request.toJson(),
    );

    return CartResponse.fromJson(response.data);
  }

  static Future<CartResponse> reviewCart(ReviewCartRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.reviewCart,
      data: request.toJson(),
    );

    return CartResponse.fromJson(response.data);
  }

  static Future<OrderCalculationResponse> orderCalculation(
    OrderCalculationRequest request,
  ) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.orderCalculation,
      data: request.toJson(),
    );

    return OrderCalculationResponse.fromJson(response.data['data']);
  }

  static Future<String> clearCart(UserRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.clearCart,
      data: request.toJson(),
    );

    return response.data['message']?.toString() ?? 'Cart has been cleared';
  }

  static Future<String> placeOrder(PlaceOrderRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.placeOrder,
      data: request.toJson(),
    );

    return response.data['message']?.toString() ?? 'Order has been placed';
  }

  static Future<List<Slot>> getSlots({
    required int userId,
    required String date,
  }) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.slots,
      data: {'user_id': userId, 'date': date},
    );

    return (response.data['data'] as List)
        .map((e) => Slot.fromJson(e))
        .toList();
  }
}
