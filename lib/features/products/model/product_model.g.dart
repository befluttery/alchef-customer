// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ProductListRequestToJson(ProductListRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'search': ?instance.search,
      'pag_no': instance.pageNo,
      'category_id': ?instance.categoryId,
    };

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  isImage: json['is_image'] as String? ?? '',
  productVarient:
      (json['product_varient'] as List<dynamic>?)
          ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

ProductVariant _$ProductVariantFromJson(Map<String, dynamic> json) =>
    ProductVariant(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['product_id'] as num?)?.toInt() ?? 0,
      varient: json['varient'] as String? ?? '',
      sellingPrice: (json['selling_price'] as num?)?.toDouble() ?? 0.0,
      mrpPrice: (json['mrp_price'] as num?)?.toDouble() ?? 0.0,
      isVarientImage: json['is_varient_image'] as String? ?? '',
      stockStatus: json['stock_status'] as String? ?? '',
      cartQty: (json['cart_qty'] as num?)?.toInt() ?? 0,
      cartItemId: (json['cart_item_id'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProductDetailRequestToJson(
  ProductDetailRequest instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'product_id': instance.productId,
};

ProductDetailResponse _$ProductDetailResponseFromJson(
  Map<String, dynamic> json,
) => ProductDetailResponse(
  data: ProductData.fromJson(json['data'] as Map<String, dynamic>),
  marinations:
      (json['marinations'] as List<dynamic>?)
          ?.map((e) => Marianation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  isImage: json['is_image'] as String? ?? '',
  productVarient:
      (json['product_varient'] as List<dynamic>?)
          ?.map((e) => ProductVariant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Marianation _$MarianationFromJson(Map<String, dynamic> json) => Marianation(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$SearchProductsRequestToJson(
  SearchProductsRequest instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'pag_no': instance.pageNo,
  'keyword': instance.keyword,
};
