import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class CategoryListRequest {
  @JsonKey(name: 'user_id')
  final int userId;

  final String? search;

  @JsonKey(name: 'pag_no')
  final int pageNo;

  CategoryListRequest({
    required this.userId,
    this.search,
    required this.pageNo,
  });

  Map<String, dynamic> toJson() => _$CategoryListRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Category {
  final int id;
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String isImage;

  const Category({required this.id, required this.name, required this.isImage});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
