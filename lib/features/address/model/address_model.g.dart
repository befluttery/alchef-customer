// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: (json['id'] as num).toInt(),
  addressName: json['address_name'] as String? ?? '',
  address: json['address'] as String? ?? '',
  city: json['city'] as String? ?? '',
  latitude: json['latitude'] as String? ?? '',
  longitude: json['longitude'] as String? ?? '',
  streetFlat: json['street_flat'] as String? ?? '',
  isDefault: (json['is_default'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'address_name': instance.addressName,
  'address': instance.address,
  'city': instance.city,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'street_flat': instance.streetFlat,
  'is_default': instance.isDefault,
};

Map<String, dynamic> _$EditAddressRequestToJson(EditAddressRequest instance) =>
    <String, dynamic>{
      'user_address_id': ?instance.id,
      'user_id': instance.userId,
      'address_name': instance.addressName,
      'address': instance.address,
      'pincode': instance.pincode,
      'city': instance.city,
      'landmark': instance.landmark,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'street_flat': instance.streetFlat,
      'is_default': instance.isDefault,
    };

Map<String, dynamic> _$AddAddressRequestToJson(AddAddressRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'address_name': instance.addressName,
      'street_flat': instance.streetFlat,
      'address': instance.address,
      'city': instance.city,
      'emirate_id': instance.emirateId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

Emirate _$EmirateFromJson(Map<String, dynamic> json) =>
    Emirate(id: (json['id'] as num).toInt(), name: json['name'] as String);
