import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/features/notification/model/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        spacing: 20,
        children: [
          Image.asset(AppImages.notificationBell, height: 32),
          Expanded(
            child: Column(
              children: [
                Text(
                  notification.message,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    notification.isCreatedAgo,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
