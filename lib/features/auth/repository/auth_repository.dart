import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/auth/model/auth_request.dart';
import 'package:alchef/features/auth/model/auth_response.dart';

class AuthRepository {
  static final ApiClient _apiClient = ApiClient();

  static Future<List<Country>> getCountries() async {
    final response = await _apiClient.post(url: ApiEndpoints.countries);

    final data = response.data['data'] as List;

    return data.map((e) => Country.fromJson(e)).toList();
  }

  static Future<User> login(LoginRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.login,
      data: request.toJson(),
    );

    return User.fromJson(response.data['data']);
  }

  static Future<User> verifyOtp(VerifyOtpRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.verifyOtp,
      data: request.toJson(),
    );

    return User.fromJson(response.data['data']);
  }

  static Future<String> resendOtp(UserRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.resendOtp,
      data: request.toJson(),
    );

    return response.data['message']?.toString() ?? 'Otp has been re-sent';
  }

  static Future<User> updateProfile(UpdateProfileRequest request) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.updateProfile,
      data: request.toJson(),
    );

    return User.fromJson(response.data['data']);
  }

  static Future<String> logout(UserRequest request) async {
    final respone = await _apiClient.post(
      url: ApiEndpoints.logout,
      data: request.toJson(),
    );

    return respone.data['message']?.toString() ?? 'Otp has been re-sent';
  }
}
