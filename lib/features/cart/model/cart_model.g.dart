// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$AddCartRequestToJson(AddCartRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'product_id': instance.productId,
      'varient_id': instance.varientId,
      'marination_id': instance.marinationId,
      'qty': instance.qty,
    };

Map<String, dynamic> _$RemoveCartRequestToJson(RemoveCartRequest instance) =>
    <String, dynamic>{'user_id': instance.userId, 'item_id': instance.itemId};

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
  cartitems:
      (json['cartitems'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  carttotal: CartTotal.fromJson(json['carttotal'] as Map<String, dynamic>),
  relatedProducts:
      (json['related_products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  userStatus: json['user_status'] as String? ?? '',
  cancelPolicy: json['cancel_policy'] as String? ?? '',
  isCod: (json['is_cod'] as num?)?.toInt() ?? 0,
  isOnline: (json['is_online'] as num?)?.toInt() ?? 0,
);

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
  id: (json['id'] as num?)?.toInt() ?? 0,
  productId: (json['product_id'] as num?)?.toInt() ?? 0,
  varientId: (json['varient_id'] as num?)?.toInt() ?? 0,
  marinationId: (json['marination_id'] as num?)?.toInt() ?? 0,
  marinationName: json['marination_name'] as String? ?? '',
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  qty: (json['qty'] as num?)?.toInt() ?? 0,
  totalPrice: (json['total_price'] as num?)?.toDouble() ?? 0.0,
  originalPrice: (json['original_price'] as num?)?.toDouble() ?? 0.0,
  product: CartProduct.fromJson(json['product'] as Map<String, dynamic>),
  productVarient: CartProductVariant.fromJson(
    json['product_varient'] as Map<String, dynamic>,
  ),
);

CartProduct _$CartProductFromJson(Map<String, dynamic> json) => CartProduct(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  image: json['image'] as String? ?? '',
  isImage: json['is_image'] as String? ?? '',
  isFav: (json['is_fav'] as num?)?.toInt() ?? 0,
  isActive: json['is_active'] as String? ?? '',
);

CartProductVariant _$CartProductVariantFromJson(Map<String, dynamic> json) =>
    CartProductVariant(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['product_id'] as num?)?.toInt() ?? 0,
      varient: json['varient'] as String? ?? '',
      shortName: json['short_name'] as String? ?? '',
      sellingPrice: (json['selling_price'] as num?)?.toDouble() ?? 0.0,
      mrpPrice: (json['mrp_price'] as num?)?.toDouble() ?? 0.0,
      stockStatus: json['stock_status'] as String? ?? '',
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      maxStock: (json['max_stock'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      isVarientImage: json['is_varient_image'] as String? ?? '',
      cartQty: (json['cart_qty'] as num?)?.toInt() ?? 0,
      cartItemId: (json['cart_item_id'] as num?)?.toInt() ?? 0,
    );

CartTotal _$CartTotalFromJson(Map<String, dynamic> json) => CartTotal(
  id: (json['id'] as num?)?.toInt() ?? 0,
  userId: (json['user_id'] as num?)?.toInt() ?? 0,
  isAlert: (json['is_alert'] as num?)?.toInt() ?? 0,
  isAlertMsg: json['is_alert_msg'] as String? ?? '',
  isPrice: (json['is_price'] as num?)?.toDouble() ?? 0.0,
  isQty: json['is_qty'] as String? ?? '0',
  isMinOrderValue: (json['is_min_order_value'] as num?)?.toDouble() ?? 0.0,
  isMinDeliveryValue:
      (json['is_min_delivery_value'] as num?)?.toDouble() ?? 0.0,
  isDeliveryCharges: (json['is_delivery_charges'] as num?)?.toDouble() ?? 0.0,
  isDeliveryDescription: json['is_delivery_description'] as String? ?? '',
  isWalletAmount: (json['is_wallet_amount'] as num?)?.toDouble() ?? 0.0,
  isPackageFee: (json['is_package_fee'] as num?)?.toDouble() ?? 0.0,
);

OrderCalculationResponse _$OrderCalculationResponseFromJson(
  Map<String, dynamic> json,
) => OrderCalculationResponse(
  subTotal: json['sub_total'] as num? ?? 0,
  deliveryFee: json['delivery_fee'] as num? ?? 0,
  emirateFee: json['emirate_fee'] as num? ?? 0,
  discount: json['discount'] as num? ?? 0,
  usedWalletAmt: json['used_wallet_amt'] as num? ?? 0,
  usedWalletPoints: json['used_wallet_points'] as num? ?? 0,
  remainingWalletPoints: json['remaining_wallet_points'] as num? ?? 0,
  walletPointValue: json['wallet_point_value'] as num? ?? 0,
  weight: json['weight'] as num? ?? 0,
  couponId: (json['coupon_id'] as num?)?.toInt() ?? 0,
  totalAmount: json['total_amount'] as num? ?? 0,
  coupon: json['coupon'] == null
      ? null
      : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
  cashbackDescription: json['cashback_description'] as String? ?? '',
);

Map<String, dynamic> _$OrderCalculationResponseToJson(
  OrderCalculationResponse instance,
) => <String, dynamic>{
  'sub_total': instance.subTotal,
  'delivery_fee': instance.deliveryFee,
  'emirate_fee': instance.emirateFee,
  'discount': instance.discount,
  'used_wallet_amt': instance.usedWalletAmt,
  'used_wallet_points': instance.usedWalletPoints,
  'remaining_wallet_points': instance.remainingWalletPoints,
  'wallet_point_value': instance.walletPointValue,
  'weight': instance.weight,
  'coupon_id': instance.couponId,
  'total_amount': instance.totalAmount,
  'coupon': instance.coupon?.toJson(),
  'cashback_description': instance.cashbackDescription,
};

PlaceOrderRequest _$PlaceOrderRequestFromJson(Map<String, dynamic> json) =>
    PlaceOrderRequest(
      comments: json['comments'] as String? ?? '',
      totalPrice: json['total_price'] as num? ?? 0,
      subTotal: json['sub_total'] as String? ?? '',
      userPk: (json['user_pk'] as num?)?.toInt() ?? 0,
      paymentMethod: json['payment_method'] as String? ?? '',
      shippingAmount: json['shipping_amount'] as num? ?? 0,
      shippingMethod: (json['shipping_method'] as num?)?.toInt() ?? 0,
      cartId: (json['cart_id'] as num?)?.toInt() ?? 0,
      userAddressId: (json['user_address_id'] as num?)?.toInt() ?? 0,
      deliverySlotId: (json['delivery_slot_id'] as num?)?.toInt() ?? 0,
      deliveryDate: json['delivery_date'] as String? ?? '',
      deliveryInfo: json['delivery_info'] as String? ?? '',
      couponId: (json['coupon_id'] as num?)?.toInt(),
      discount: json['discount'] as num,
      usedWalletAmt: json['used_wallet_amt'] as num? ?? 0,
      usedWalletPoints: json['used_wallet_points'] as num? ?? 0,
      remainingWalletPoints: json['remaining_wallet_points'] as num? ?? 0,
      orderFrom: json['orderFrom'] as String,
    );

Map<String, dynamic> _$PlaceOrderRequestToJson(PlaceOrderRequest instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'total_price': instance.totalPrice,
      'sub_total': instance.subTotal,
      'user_pk': instance.userPk,
      'payment_method': instance.paymentMethod,
      'shipping_amount': instance.shippingAmount,
      'shipping_method': instance.shippingMethod,
      'cart_id': instance.cartId,
      'user_address_id': instance.userAddressId,
      'delivery_slot_id': instance.deliverySlotId,
      'delivery_date': instance.deliveryDate,
      'delivery_info': instance.deliveryInfo,
      'coupon_id': instance.couponId,
      'discount': instance.discount,
      'used_wallet_amt': instance.usedWalletAmt,
      'used_wallet_points': instance.usedWalletPoints,
      'remaining_wallet_points': instance.remainingWalletPoints,
      'orderFrom': instance.orderFrom,
    };

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
  id: (json['id'] as num).toInt(),
  displayTime: json['display_time'] as String? ?? '',
);
