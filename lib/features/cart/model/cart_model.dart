import 'package:alchef/features/coupon/model/coupon_model.dart';
import 'package:alchef/features/products/model/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class AddCartRequest {
  final int userId;
  final int productId;
  final int varientId;
  final int marinationId;
  final int qty;

  AddCartRequest({
    required this.userId,
    required this.productId,
    required this.varientId,
    required this.marinationId,
    required this.qty,
  });

  Map<String, dynamic> toJson() => _$AddCartRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createFactory: false)
class RemoveCartRequest {
  final int userId;
  final int itemId;

  const RemoveCartRequest({required this.userId, required this.itemId});

  Map<String, dynamic> toJson() => _$RemoveCartRequestToJson(this);
}

// ─────────────────────────────────────────────────────────────────────────────

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CartResponse {
  @JsonKey(defaultValue: [])
  final List<CartItem> cartitems;

  final CartTotal carttotal;

  @JsonKey(defaultValue: [])
  final List<Product> relatedProducts;

  @JsonKey(defaultValue: '')
  final String userStatus;

  @JsonKey(defaultValue: '')
  final String cancelPolicy;

  @JsonKey(defaultValue: 0)
  final int isCod;

  @JsonKey(defaultValue: 0)
  final int isOnline;

  const CartResponse({
    required this.cartitems,
    required this.carttotal,
    required this.relatedProducts,
    required this.userStatus,
    required this.cancelPolicy,
    required this.isCod,
    required this.isOnline,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CartItem {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int productId;

  @JsonKey(defaultValue: 0)
  final int varientId;

  @JsonKey(defaultValue: 0)
  final int marinationId;

  @JsonKey(defaultValue: '')
  final String marinationName;

  @JsonKey(defaultValue: 0.0)
  final double price;

  @JsonKey(defaultValue: 0)
  final int qty;

  @JsonKey(defaultValue: 0.0)
  final double totalPrice;

  @JsonKey(defaultValue: 0.0)
  final double originalPrice;

  final CartProduct product;

  final CartProductVariant productVarient;

  const CartItem({
    required this.id,
    required this.productId,
    required this.varientId,
    required this.marinationId,
    required this.marinationName,
    required this.price,
    required this.qty,
    required this.totalPrice,
    required this.originalPrice,
    required this.product,
    required this.productVarient,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CartProduct {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: '')
  final String name;

  @JsonKey(defaultValue: '')
  final String image;

  @JsonKey(defaultValue: '')
  final String isImage;

  @JsonKey(defaultValue: 0)
  final int isFav;

  @JsonKey(defaultValue: '')
  final String isActive;

  const CartProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.isImage,
    required this.isFav,
    required this.isActive,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CartProductVariant {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int productId;

  @JsonKey(defaultValue: '')
  final String varient;

  @JsonKey(defaultValue: '')
  final String shortName;

  @JsonKey(defaultValue: 0.0)
  final double sellingPrice;

  @JsonKey(defaultValue: 0.0)
  final double mrpPrice;

  @JsonKey(defaultValue: '')
  final String stockStatus;

  @JsonKey(defaultValue: 0)
  final int stock;

  @JsonKey(defaultValue: 0)
  final int maxStock;

  @JsonKey(defaultValue: '')
  final String status;

  @JsonKey(defaultValue: '')
  final String isVarientImage;

  @JsonKey(defaultValue: 0)
  final int cartQty;

  @JsonKey(defaultValue: 0)
  final int cartItemId;

  const CartProductVariant({
    required this.id,
    required this.productId,
    required this.varient,
    required this.shortName,
    required this.sellingPrice,
    required this.mrpPrice,
    required this.stockStatus,
    required this.stock,
    required this.maxStock,
    required this.status,
    required this.isVarientImage,
    required this.cartQty,
    required this.cartItemId,
  });

  factory CartProductVariant.fromJson(Map<String, dynamic> json) =>
      _$CartProductVariantFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class CartTotal {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(defaultValue: 0)
  final int userId;

  @JsonKey(defaultValue: 0)
  final int isAlert;

  @JsonKey(defaultValue: '')
  final String isAlertMsg;

  @JsonKey(defaultValue: 0.0)
  final double isPrice;

  @JsonKey(defaultValue: '0')
  final String isQty;

  @JsonKey(defaultValue: 0.0)
  final double isMinOrderValue;

  @JsonKey(defaultValue: 0.0)
  final double isMinDeliveryValue;

  @JsonKey(defaultValue: 0.0)
  final double isDeliveryCharges;

  @JsonKey(defaultValue: '')
  final String isDeliveryDescription;

  @JsonKey(defaultValue: 0.0)
  final double isWalletAmount;

  @JsonKey(defaultValue: 0.0)
  final double isPackageFee;

  const CartTotal({
    required this.id,
    required this.userId,
    required this.isAlert,
    required this.isAlertMsg,
    required this.isPrice,
    required this.isQty,
    required this.isMinOrderValue,
    required this.isMinDeliveryValue,
    required this.isDeliveryCharges,
    required this.isDeliveryDescription,
    required this.isWalletAmount,
    required this.isPackageFee,
  });

  factory CartTotal.fromJson(Map<String, dynamic> json) =>
      _$CartTotalFromJson(json);
}

class OrderCalculationRequest {
  final int userId;
  final int cartId;
  final int userAddressId;
  final int useWallet;
  final int? couponId;

  OrderCalculationRequest({
    required this.userId,
    required this.cartId,
    required this.useWallet,
    required this.couponId,
    required this.userAddressId,
  });

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'cart_id': cartId,
    'use_wallet': useWallet,
    if (couponId != null) 'coupon_id': couponId,
    'user_address_id': userAddressId,
  };
}

@JsonSerializable(explicitToJson: true)
class OrderCalculationResponse {
  @JsonKey(name: 'sub_total', defaultValue: 0)
  final num subTotal;

  @JsonKey(name: 'delivery_fee', defaultValue: 0)
  final num deliveryFee;

  @JsonKey(name: 'emirate_fee', defaultValue: 0)
  final num emirateFee;

  @JsonKey(defaultValue: 0)
  final num discount;

  @JsonKey(name: 'used_wallet_amt', defaultValue: 0)
  final num usedWalletAmt;

  @JsonKey(name: 'used_wallet_points', defaultValue: 0)
  final num usedWalletPoints;

  @JsonKey(name: 'remaining_wallet_points', defaultValue: 0)
  final num remainingWalletPoints;

  @JsonKey(name: 'wallet_point_value', defaultValue: 0)
  final num walletPointValue;

  @JsonKey(defaultValue: 0)
  final num weight;

  @JsonKey(name: 'coupon_id', defaultValue: 0)
  final int couponId;

  @JsonKey(name: 'total_amount', defaultValue: 0)
  final num totalAmount;

  @JsonKey()
  final Coupon? coupon;

  @JsonKey(name: 'cashback_description', defaultValue: '')
  final String cashbackDescription;

  OrderCalculationResponse({
    required this.subTotal,
    required this.deliveryFee,
    required this.emirateFee,
    required this.discount,
    required this.usedWalletAmt,
    required this.usedWalletPoints,
    required this.remainingWalletPoints,
    required this.walletPointValue,
    required this.weight,
    required this.couponId,
    required this.totalAmount,
    required this.coupon,
    required this.cashbackDescription,
  });

  factory OrderCalculationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderCalculationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCalculationResponseToJson(this);
}

class ReviewCartRequest {
  final int userId;
  final int cartId;

  ReviewCartRequest({required this.userId, required this.cartId});

  Map<String, dynamic> toJson() => {'user_id': userId, 'cart_id': cartId};
}

@JsonSerializable()
class PlaceOrderRequest {
  @JsonKey(defaultValue: '')
  final String comments;

  @JsonKey(name: 'total_price', defaultValue: 0)
  final num totalPrice;

  @JsonKey(name: 'sub_total', defaultValue: '')
  final String subTotal;

  @JsonKey(name: 'user_pk', defaultValue: 0)
  final int userPk;

  @JsonKey(name: 'payment_method', defaultValue: '')
  final String paymentMethod;

  @JsonKey(name: 'shipping_amount', defaultValue: 0)
  final num shippingAmount;

  @JsonKey(name: 'shipping_method', defaultValue: 0)
  final int shippingMethod;

  @JsonKey(name: 'cart_id', defaultValue: 0)
  final int cartId;

  @JsonKey(name: 'user_address_id', defaultValue: 0)
  final int userAddressId;

  @JsonKey(name: 'delivery_slot_id', defaultValue: 0)
  final int deliverySlotId;

  @JsonKey(name: 'delivery_date', defaultValue: '')
  final String deliveryDate;

  @JsonKey(name: 'delivery_info', defaultValue: '')
  final String deliveryInfo;

  @JsonKey(name: 'coupon_id')
  final int? couponId;

  @JsonKey(name: 'discount')
  final num discount;

  @JsonKey(name: 'used_wallet_amt', defaultValue: 0)
  final num usedWalletAmt;

  @JsonKey(name: 'used_wallet_points', defaultValue: 0)
  final num usedWalletPoints;

  @JsonKey(name: 'remaining_wallet_points', defaultValue: 0)
  final num remainingWalletPoints;

  final String orderFrom;

  PlaceOrderRequest({
    required this.comments,
    required this.totalPrice,
    required this.subTotal,
    required this.userPk,
    required this.paymentMethod,
    required this.shippingAmount,
    required this.shippingMethod,
    required this.cartId,
    required this.userAddressId,
    required this.deliverySlotId,
    required this.deliveryDate,
    required this.deliveryInfo,
    required this.couponId,
    required this.discount,
    required this.usedWalletAmt,
    required this.usedWalletPoints,
    required this.remainingWalletPoints,
    required this.orderFrom,
  });

  factory PlaceOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class Slot {
  final int id;

  @JsonKey(defaultValue: '')
  final String displayTime;

  const Slot({required this.id, required this.displayTime});

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
}
