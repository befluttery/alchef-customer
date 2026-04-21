// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{'user_id': instance.userId, 'pag_no': instance.pageNo};

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
      'fcm_token': instance.fcmToken,
      'device_type': instance.deviceType,
    };

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'mobile': instance.mobile,
      'otp': instance.otp,
    };

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'first_name': instance.firstName,
  'email': instance.email,
  'referral_code': ?instance.referralCode,
};
