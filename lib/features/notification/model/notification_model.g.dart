// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$NotificationListRequestToJson(
  NotificationListRequest instance,
) => <String, dynamic>{'user_id': instance.userId, 'pag_no': instance.pagNo};

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num).toInt(),
      message: json['message'] as String? ?? '',
      isCreatedAgo: json['is_created_ago'] as String? ?? '',
    );
