// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  phonecode: convertToString(json['phonecode']),
  minDigit: (json['min_digit'] as num).toInt(),
  maxDigit: (json['max_digit'] as num).toInt(),
  isImage: json['is_image'] as String,
);

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt() ?? 0,
  firstName: json['first_name'] as String? ?? '',
  lastName: json['last_name'] as String? ?? '',
  email: json['email'] as String? ?? '',
  mobile: json['mobile'] as String? ?? '',
  step: (json['step'] as num?)?.toInt() ?? 0,
  referralCode: json['referral_code'] as String? ?? '',
  userAuthToken: json['user_auth_token'] as String? ?? '',
  isUserImage: json['is_user_image'] as String? ?? '',
  rewardPoint: json['reward_point'] as num? ?? 0.0,
  isActive: json['is_active'] as String? ?? '',
  userDefaultAddress: json['user_default_address'] == null
      ? null
      : Address.fromJson(json['user_default_address'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email': instance.email,
  'mobile': instance.mobile,
  'step': instance.step,
  'referral_code': instance.referralCode,
  'user_auth_token': instance.userAuthToken,
  'is_user_image': instance.isUserImage,
  'reward_point': instance.rewardPoint,
  'is_active': instance.isActive,
  'user_default_address': instance.userDefaultAddress?.toJson(),
};
