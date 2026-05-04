import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/notification/model/notification_model.dart';
import 'package:alchef/features/notification/repo/notification_repository.dart';
import 'package:get/state_manager.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  List<NotificationModel> notifications = [];
  String? error;

  int? pageNo;
  var paginationLoading = false.obs;

  Future<void> fetchNotifications({
    required bool initialize,
  }) async {
    try {
      if (initialize) {
        notifications.clear();
        pageNo = 0;
        isLoading.value = true;
      } else {
        paginationLoading.value = true;
      }
      error = null;
      pageNo = notifications.length;

      final request = NotificationListRequest(
        userId: AuthHelper.userId,
        pagNo: pageNo ?? 0,
      );

      final result = await NotificationRepository.getNotifications(request);

      notifications.addAll(result);
    } catch (e) {
      if (initialize) {
        error = UiHelper.getMsgFromException(e);
      }
    } finally {
      if (initialize) {
        isLoading.value = false;
      } else {
        paginationLoading.value = false;
      }
    }
  }

  bool get canScroll =>
      pageNo != null &&
      pageNo != notifications.length &&
      !isLoading.value &&
      !paginationLoading.value;
}
