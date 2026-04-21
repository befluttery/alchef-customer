// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Banner _$BannerFromJson(Map<String, dynamic> json) => Banner(
  id: (json['id'] as num?)?.toInt() ?? 0,
  isImage: json['is_image'] as String? ?? '',
  productId: (json['product_id'] as num).toInt(),
);

HomeCategoryProduct _$HomeCategoryProductFromJson(Map<String, dynamic> json) =>
    HomeCategoryProduct(
      categoryId: (json['category_id'] as num?)?.toInt() ?? 0,
      categoryName: json['category_name'] as String? ?? '',
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
