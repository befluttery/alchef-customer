import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/products/model/product_model.dart';

class ProductRepository {
  static final ApiClient _apiClient = ApiClient();

  static Future<ProductDetailResponse> getProductDetail(
    ProductDetailRequest request,
  ) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.productDetail,
      data: request.toJson(),
    );

    return ProductDetailResponse.fromJson(response.data);
  }

  static Future<List<Product>> getProducts(ProductListRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.products,
      data: request.toJson(),
    );

    return (response.data['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }

  static Future<List<Product>> searchProducts(
    SearchProductsRequest request,
  ) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.searchProducts,
      data: request.toJson(),
    );

    return (response.data['data'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }
}
