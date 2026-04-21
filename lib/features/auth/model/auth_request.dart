import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class UserRequest {
  final int userId;
  @JsonKey(name: 'pag_no')
  final int? pageNo;

  const UserRequest({required this.userId, this.pageNo});

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class LoginRequest {
  final String mobile;
  final String fcmToken;
  final String deviceType;

  const LoginRequest({
    required this.mobile,
    required this.fcmToken,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class VerifyOtpRequest {
  final int userId;
  final String mobile;
  final String otp;

  const VerifyOtpRequest({
    required this.userId,
    required this.mobile,
    required this.otp,
  });

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  includeIfNull: false,
)
class UpdateProfileRequest {
  final int userId;
  final String firstName;
  final String email;
  final String? referralCode;

  const UpdateProfileRequest({
    required this.userId,
    required this.firstName,
    required this.email,
    this.referralCode,
  });

  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
