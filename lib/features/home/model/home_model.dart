import 'package:alchef/features/products/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Banner {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String isImage;

  final int productId;

  const Banner({
    required this.id,
    required this.isImage,
    required this.productId,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => _$BannerFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class HomeCategoryProduct {
  @JsonKey(defaultValue: 0)
  final int categoryId;

  @JsonKey(defaultValue: '')
  final String categoryName;

  @JsonKey(defaultValue: [])
  final List<Product> products;

  const HomeCategoryProduct({
    required this.categoryId,
    required this.categoryName,
    required this.products,
  });

  factory HomeCategoryProduct.fromJson(Map<String, dynamic> json) =>
      _$HomeCategoryProductFromJson(json);
}
