// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
  id: (json['id'] as num?)?.toInt() ?? 0,
  code: json['code'] as String? ?? '',
  couponName: json['coupon_name'] as String? ?? '',
  couponCode: json['coupon_code'] as String? ?? '',
  couponPercentage: json['coupon_percentage'] as num? ?? 0,
  couponAmount: json['coupon_amount'] as num? ?? 0,
  orderAbove: json['order_above'] as num? ?? 0,
  maxAmount: json['max_amount'] as num? ?? 0,
  isValidFrom: json['is_valid_from'] as String? ?? '',
  isExpire: json['is_expire'] as String? ?? '',
  couponCount: (json['coupon_count'] as num?)?.toInt() ?? 0,
  usedCouponCount: (json['used_coupon_count'] as num?)?.toInt() ?? 0,
  userCount: (json['user_count'] as num?)?.toInt() ?? 0,
  usedCountPerDay: (json['used_count_per_day'] as num?)?.toInt() ?? 0,
  couponType: json['coupon_type'] as String? ?? '',
  type: json['type'] as String? ?? '',
  status: json['status'] as String? ?? '',
  image: json['image'] as String? ?? '',
  description: json['description'] as String? ?? '',
  displayCouponType: json['display_coupon_type'] as String? ?? '',
  createdAt: json['created_at'] as String? ?? '',
  updatedAt: json['updated_at'] as String? ?? '',
  isActive: json['is_active'] as String? ?? '',
  isImage: json['is_image'] as String? ?? '',
  isStartDate: json['is_start_date'] as String? ?? '',
  isEndDate: json['is_end_date'] as String? ?? '',
  isUsed: (json['is_used'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'coupon_name': instance.couponName,
  'coupon_code': instance.couponCode,
  'coupon_percentage': instance.couponPercentage,
  'coupon_amount': instance.couponAmount,
  'order_above': instance.orderAbove,
  'max_amount': instance.maxAmount,
  'is_valid_from': instance.isValidFrom,
  'is_expire': instance.isExpire,
  'coupon_count': instance.couponCount,
  'used_coupon_count': instance.usedCouponCount,
  'user_count': instance.userCount,
  'used_count_per_day': instance.usedCountPerDay,
  'coupon_type': instance.couponType,
  'type': instance.type,
  'status': instance.status,
  'image': instance.image,
  'description': instance.description,
  'display_coupon_type': instance.displayCouponType,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'is_active': instance.isActive,
  'is_image': instance.isImage,
  'is_start_date': instance.isStartDate,
  'is_end_date': instance.isEndDate,
  'is_used': instance.isUsed,
};
