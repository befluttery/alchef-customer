import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/coupon/model/coupon_model.dart';

class CouponRepository {
  static final _apiClient = ApiClient();

  static Future<List<Coupon>> getCoupons(UserRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.coupons,
      data: request.toJson(),
    );

    return (response.data['data'] as List)
        .map((e) => Coupon.fromJson(e))
        .toList();
  }
}
