import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class NotificationListRequest {
  final int userId;
  final int pagNo;

  const NotificationListRequest({required this.userId, required this.pagNo});

  Map<String, dynamic> toJson() => _$NotificationListRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class NotificationModel {
  final int id;

  @JsonKey(defaultValue: '')
  final String message;

  @JsonKey(defaultValue: '')
  final String isCreatedAgo;

  const NotificationModel({
    required this.id,
    required this.message,
    required this.isCreatedAgo,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
