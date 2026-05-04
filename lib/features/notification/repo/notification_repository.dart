import 'package:alchef/core/network/api_client.dart';
import 'package:alchef/core/network/api_endpoints.dart';
import 'package:alchef/features/notification/model/notification_model.dart';

class NotificationRepository {
  static final _apiClient = ApiClient();

  static Future<List<NotificationModel>> getNotifications(
    NotificationListRequest request,
  ) async {
    final response = await _apiClient.post(
      url: ApiEndpoints.notifications,
      data: request.toJson(),
    );

    return (response.data['data'] as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }
}
