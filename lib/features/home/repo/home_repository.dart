import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/home/model/home_model.dart';

class HomeRepository {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<Banner>> getBanners(UserRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.banners,
      data: request.toJson(),
    );

    final data = response.data['data'] as List;

    return data.map((e) => Banner.fromJson(e)).toList();
  }

  static Future<List<HomeCategoryProduct>> getCategoryProducts(
    UserRequest request,
  ) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.homeCategoryProducts,
      data: request.toJson(),
    );

    final data = response.data['data'] as List;

    return data.map((e) => HomeCategoryProduct.fromJson(e)).toList();
  }
}
