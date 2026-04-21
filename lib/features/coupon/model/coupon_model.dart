import 'package:json_annotation/json_annotation.dart';

part 'coupon_model.g.dart';

@JsonSerializable()
class Coupon {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String code;

  @JsonKey(name: 'coupon_name', defaultValue: '')
  final String couponName;

  @JsonKey(name: 'coupon_code', defaultValue: '')
  final String couponCode;

  @JsonKey(name: 'coupon_percentage', defaultValue: 0)
  final num couponPercentage;

  @JsonKey(name: 'coupon_amount', defaultValue: 0)
  final num couponAmount;

  @JsonKey(name: 'order_above', defaultValue: 0)
  final num orderAbove;

  @JsonKey(name: 'max_amount', defaultValue: 0)
  final num maxAmount;

  @JsonKey(name: 'is_valid_from', defaultValue: '')
  final String isValidFrom;

  @JsonKey(name: 'is_expire', defaultValue: '')
  final String isExpire;

  @JsonKey(name: 'coupon_count', defaultValue: 0)
  final int couponCount;

  @JsonKey(name: 'used_coupon_count', defaultValue: 0)
  final int usedCouponCount;

  @JsonKey(name: 'user_count', defaultValue: 0)
  final int userCount;

  @JsonKey(name: 'used_count_per_day', defaultValue: 0)
  final int usedCountPerDay;

  @JsonKey(name: 'coupon_type', defaultValue: '')
  final String couponType;

  @JsonKey(defaultValue: '')
  final String type;

  @JsonKey(defaultValue: '')
  final String status;

  @JsonKey(defaultValue: '')
  final String image;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(name: 'display_coupon_type', defaultValue: '')
  final String displayCouponType;

  @JsonKey(name: 'created_at', defaultValue: '')
  final String createdAt;

  @JsonKey(name: 'updated_at', defaultValue: '')
  final String updatedAt;

  @JsonKey(name: 'is_active', defaultValue: '')
  final String isActive;

  @JsonKey(name: 'is_image', defaultValue: '')
  final String isImage;

  @JsonKey(name: 'is_start_date', defaultValue: '')
  final String isStartDate;

  @JsonKey(name: 'is_end_date', defaultValue: '')
  final String isEndDate;
  

  @JsonKey(name: 'is_used', defaultValue: 0)
  final int isUsed;

  Coupon({
    required this.id,
    required this.code,
    required this.couponName,
    required this.couponCode,
    required this.couponPercentage,
    required this.couponAmount,
    required this.orderAbove,
    required this.maxAmount,
    required this.isValidFrom,
    required this.isExpire,
    required this.couponCount,
    required this.usedCouponCount,
    required this.userCount,
    required this.usedCountPerDay,
    required this.couponType,
    required this.type,
    required this.status,
    required this.image,
    required this.description,
    required this.displayCouponType,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.isImage,
    required this.isStartDate,
    required this.isEndDate,
    required this.isUsed,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
