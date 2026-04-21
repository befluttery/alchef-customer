import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/auth/model/auth_response.dart';
import 'package:alchef/features/profile/model/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileRepository {
  static final _apiClient = ApiClient();

  static Future<User> updateProfileImage(
    UpdateProfileImageRequest request,
  ) async {
    final data = {
      'type': 1,
      'user_id': request.userId,
      'user_image': await MultipartFile.fromFile(request.imagePath),
    };

    final response = await _apiClient.post(
      url: ApiEndpoints.updateProfileImage,
      data: FormData.fromMap(data),
    );

    return User.fromJson(response.data['data']);
  }
}
