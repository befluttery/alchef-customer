import 'package:dio/dio.dart';
import 'package:alchef/core/utils/auth_helper.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AuthHelper.authToken.isNotEmpty == true) {
      options.headers['Authorization'] = AuthHelper.authToken;
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      AuthHelper.logoutUser();
    }
    super.onError(err, handler);
  }
}
