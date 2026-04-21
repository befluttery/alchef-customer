import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/category/model/category_model.dart';

class CategoryRepository {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<Category>> getCategories(CategoryListRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.categories,
      data: request.toJson(),
    );

    final data = response.data['data'] as List;

    return data.map((e) => Category.fromJson(e)).toList();
  }
}
