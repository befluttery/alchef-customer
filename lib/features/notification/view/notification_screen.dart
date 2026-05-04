import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/primary_loader.dart';
import 'package:alchef/features/notification/controller/notification_controller.dart';
import 'package:alchef/features/notification/view/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final controller = Get.put(NotificationController());

  final _scrollController = ScrollController();

  @override
  void initState() {
    controller.fetchNotifications(initialize: true);
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  void _loadMore() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.8)) {
      if (controller.canScroll) {
        controller.fetchNotifications(initialize: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appbarTitle: 'Notifications',
      body: Obx(() {
        if (controller.isLoading.value) {
          return const PrimaryLoader();
        }

        if (controller.error != null) {
          return ErrorContent(
            message: controller.error,
            onRetry: () => controller.fetchNotifications(initialize: true),
          );
        }

        final notifications = controller.notifications;

        if (notifications.isEmpty) {
          return const Center(child: Text('No Notifications'));
        }

        return ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount:
              notifications.length +
              (controller.paginationLoading.value ? 1 : 0),
          separatorBuilder: (context, index) => SizedBox(height: 20),
          itemBuilder: (context, index) {
            if (index < notifications.length) {
              return NotificationItem(notification: notifications[index]);
            } else {
              return const PrimaryLoader();
            }
          },
        );
      }),
    );
  }
}
