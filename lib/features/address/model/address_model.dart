import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Address {
  final int id;

  @JsonKey(name: "address_name", defaultValue: "")
  final String addressName;

  @JsonKey(defaultValue: "")
  final String address;

  // @JsonKey(defaultValue: "")
  // final String pincode;

  @JsonKey(defaultValue: "")
  final String city;

  // @JsonKey(defaultValue: "")
  // final String landmark;

  @JsonKey(defaultValue: "")
  final String latitude;

  @JsonKey(defaultValue: "")
  final String longitude;

  @JsonKey(name: "street_flat", defaultValue: "")
  final String streetFlat;

  @JsonKey(name: "is_default", defaultValue: 0)
  int isDefault;

  Address({
    required this.id,
    required this.addressName,
    required this.address,
    // required this.pincode,
    required this.city,
    // required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.streetFlat,
    required this.isDefault,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable(
  explicitToJson: true,
  includeIfNull: false,
  createFactory: false,
)
class EditAddressRequest {
  @JsonKey(name: "user_address_id")
  final int? id;

  @JsonKey(name: "user_id", defaultValue: 0)
  int userId;

  @JsonKey(name: "address_name", defaultValue: "")
  final String addressName;

  @JsonKey(defaultValue: "")
  final String address;

  @JsonKey(defaultValue: "")
  final String pincode;

  @JsonKey(defaultValue: "")
  final String city;

  @JsonKey(defaultValue: "")
  final String landmark;

  @JsonKey(defaultValue: "")
  final String latitude;

  @JsonKey(defaultValue: "")
  final String longitude;

  @JsonKey(name: "street_flat", defaultValue: "")
  final String streetFlat;

  @JsonKey(name: "is_default", defaultValue: 0)
  int isDefault;

  EditAddressRequest({
    required this.id,
    required this.userId,
    required this.addressName,
    required this.address,
    required this.pincode,
    required this.city,
    required this.landmark,
    required this.latitude,
    required this.longitude,
    required this.streetFlat,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() => _$EditAddressRequestToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  createFactory: false,
  explicitToJson: true,
  includeIfNull: false,
)
class AddAddressRequest {
  final int userId;

  @JsonKey(name: "address_name", defaultValue: "")
  final String addressName;

  @JsonKey(name: "street_flat", defaultValue: "")
  final String streetFlat;

  @JsonKey(defaultValue: "")
  final String address;

  // @JsonKey(defaultValue: "")
  // final String landmark;

  @JsonKey(defaultValue: "")
  final String city;

  final int emirateId;

  @JsonKey(defaultValue: "")
  final String latitude;

  @JsonKey(defaultValue: "")
  final String longitude;

  AddAddressRequest({
    required this.userId,
    required this.addressName,
    required this.address,
    required this.streetFlat,
    // required this.landmark,
    required this.emirateId,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => _$AddAddressRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Emirate {
  final int id;
  final String name;

  Emirate({required this.id, required this.name});

  factory Emirate.fromJson(Map<String, dynamic> json) =>
      _$EmirateFromJson(json);
}
