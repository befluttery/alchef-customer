import 'package:alchef/core/utils/common_helper.dart';
import 'package:alchef/features/address/model/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Country {
  final int id;
  final String name;

  @JsonKey(fromJson: convertToString)
  final String phonecode;

  final int minDigit;

  final int maxDigit;
  final String isImage;

  const Country({
    required this.id,
    required this.name,
    required this.phonecode,
    required this.minDigit,
    required this.maxDigit,
    required this.isImage,
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User {
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.step,
    required this.referralCode,
    required this.userAuthToken,
    required this.isUserImage,
    required this.rewardPoint,
    required this.isActive,
    required this.userDefaultAddress,
  });

  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String firstName;
  @JsonKey(defaultValue: '')
  final String lastName;

  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: '')
  final String mobile;

  @JsonKey(defaultValue: 0)
  final int step;

  @JsonKey(defaultValue: '')
  final String referralCode;

  @JsonKey(defaultValue: '')
  final String userAuthToken;

  @JsonKey(defaultValue: '')
  final String isUserImage;

  @JsonKey(defaultValue: 0.0)
  final num rewardPoint;

  @JsonKey(defaultValue: '')
  final String isActive;

  @JsonKey(name: "user_default_address")
  final Address? userDefaultAddress;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
