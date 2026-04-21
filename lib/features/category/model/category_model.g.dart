// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CategoryListRequestToJson(
  CategoryListRequest instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'search': ?instance.search,
  'pag_no': instance.pageNo,
};

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  isImage: json['is_image'] as String? ?? '',
);
