import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:alchef/core/errors/app_exception.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/core/network/auth_interceptor.dart';
import 'package:alchef/core/utils/auth_helper.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.apiEndPoint,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 20),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(AuthInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
        ),
      );
    }
  }

  Future<Response> get({required String url}) async {
    try {
      final response = await _dio.get(url);

      if (response.data['status']?.toString() == '1') {
        return response;
      } else if (response.data['status']?.toString() == '5') {
        await AuthHelper.logoutUser();
        throw AppException(
          response.data['message']?.toString() ?? 'Session expired',
        );
      } else {
        throw AppException(
          response.data['message']?.toString() ?? 'Something went wrong',
        );
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  Future<Response> post({required String url, dynamic data}) async {
    try {
      final response = await _dio.post(url, data: data);

      if (response.data['status']?.toString() == '1') {
        return response;
      } else if (response.data['status']?.toString() == '5') {
        await AuthHelper.logoutUser();
        throw AppException(
          response.data['message']?.toString() ?? 'Session expired',
        );
      } else {
        throw AppException(
          response.data['message']?.toString() ?? 'Something went wrong',
        );
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
