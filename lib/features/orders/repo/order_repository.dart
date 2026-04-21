import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/orders/model/order_model.dart';

class OrderRepository {
  static final _apiClient = ApiClient();

  static Future<List<Order>> getOrders(OrderListRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.orders,
      data: request.toJson(),
    );

    return (response.data['data'] as List)
        .map((e) => Order.fromJson(e))
        .toList();
  }

  static Future<OrderDetailResponse> getOrderDetail(
    OrderDetailRequest request,
  ) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.orderDetail,
      data: request.toJson(),
    );

    return OrderDetailResponse.fromJson(response.data['data']);
  }
}
