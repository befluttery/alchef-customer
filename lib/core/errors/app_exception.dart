import 'package:dio/dio.dart';

class AppException implements Exception {
  final dynamic message;
  AppException(this.message);

  @override
  String toString() => message.toString();

  factory AppException.fromDioError(DioException e) {
    if (e.response != null) {
      final status = e.response?.statusCode;
      switch (status) {
        case 400:
          return AppException('Bad Request');
        case 401:
          return AppException('Session expired. Please login again.');
        case 404:
          return AppException('Not found!');
        case 500:
          return AppException('Server error, please try again');
        default:
          return AppException('Unexpected error occurred');
      }
    } else {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return AppException('Connection timeout. Please try again.');

        case DioExceptionType.connectionError:
          return AppException('Connection Error');

        default:
          return AppException('Something went wrong');
      }
    }
  }
}
