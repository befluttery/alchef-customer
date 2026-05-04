import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class ProductListRequest {
  @JsonKey(name: 'user_id')
  final int userId;

  final String? search;

  @JsonKey(name: 'pag_no')
  final int pageNo;

  @JsonKey(name: 'category_id')
  final int? categoryId;

  ProductListRequest({
    required this.userId,
    this.search,
    this.categoryId,
    required this.pageNo,
  });

  Map<String, dynamic> toJson() => _$ProductListRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Product {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String name;

  @JsonKey(defaultValue: '')
  final String isImage;

  @JsonKey(defaultValue: [])
  final List<ProductVariant> productVarient;

  const Product({
    required this.id,
    required this.name,
    required this.isImage,
    required this.productVarient,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProductVariant {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int productId;

  @JsonKey(defaultValue: '')
  final String varient;

  @JsonKey(defaultValue: 0.0)
  final double sellingPrice;

  @JsonKey(defaultValue: 0.0)
  final double mrpPrice;

  @JsonKey(defaultValue: '')
  final String isVarientImage;

  @JsonKey(defaultValue: '')
  final String stockStatus;

  @JsonKey(defaultValue: 0)
  int cartQty;

  @JsonKey(defaultValue: 0)
  final int cartItemId;

  ProductVariant({
    required this.id,
    required this.productId,
    required this.varient,
    required this.sellingPrice,
    required this.mrpPrice,
    required this.isVarientImage,
    required this.stockStatus,
    required this.cartQty,
    required this.cartItemId,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantFromJson(json);

  bool get inStock => stockStatus.toLowerCase() == 'in_stock';
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class ProductDetailRequest {
  final int userId;
  final int productId;

  const ProductDetailRequest({required this.userId, required this.productId});

  Map<String, dynamic> toJson() => _$ProductDetailRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProductDetailResponse {
  final ProductData data;

  @JsonKey(defaultValue: [])
  final List<Marianation> marinations;

  ProductDetailResponse({required this.data, required this.marinations});

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProductData {
  final int id;

  @JsonKey(defaultValue: '')
  final String name;

  @JsonKey(defaultValue: '')
  final String description;

  @JsonKey(defaultValue: '')
  final String isImage;

  @JsonKey(defaultValue: [])
  final List<ProductVariant> productVarient;

  ProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.isImage,
    required this.productVarient,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Marianation {
  final int id;
  @JsonKey(defaultValue: '')
  final String name;

  @JsonKey(defaultValue: '')
  final String description;

  const Marianation({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Marianation.fromJson(Map<String, dynamic> json) =>
      _$MarianationFromJson(json);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class SearchProductsRequest {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'pag_no')
  final int pageNo;
  final String keyword;

  SearchProductsRequest({
    required this.userId,
    required this.pageNo,
    required this.keyword,
  });

  Map<String, dynamic> toJson() => _$SearchProductsRequestToJson(this);
}
