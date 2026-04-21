import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class OrderListRequest {
  @JsonKey(name: 'user_id')
  final int userId;

  @JsonKey(name: 'pag_no')
  final int pageNo;

  OrderListRequest({required this.userId, required this.pageNo});

  Map<String, dynamic> toJson() => _$OrderListRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Order {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(name: 'order_id', defaultValue: '')
  final String orderId;

  @JsonKey(name: 'invoice_no', defaultValue: '')
  final String invoiceNo;

  @JsonKey(name: 'user_id', defaultValue: 0)
  final int userId;

  @JsonKey(name: 'delivery_date', defaultValue: '')
  final String deliveryDate;

  @JsonKey(name: 'payment_status', defaultValue: '')
  final String paymentStatus;

  @JsonKey(name: 'no_of_product', defaultValue: 0)
  final int noOfProduct;

  @JsonKey(defaultValue: '')
  final String status;

  @JsonKey(name: 'order_date', defaultValue: '')
  final String orderDate;

  @JsonKey(name: 'sub_total', defaultValue: 0)
  final num subTotal;

  @JsonKey(name: 'discount', defaultValue: 0)
  final num discount;

  @JsonKey(name: 'delivery_fee', defaultValue: 0, fromJson: stringToNum)
  final num deliveryFee;

  @JsonKey(name: 'grand_total', defaultValue: 0)
  final num grandTotal;

  @JsonKey(name: 'is_order_date', defaultValue: '')
  final String isOrderDate;

  @JsonKey(name: 'customer_name', defaultValue: '')
  final String customerName;

  @JsonKey(name: 'is_delivery_type', defaultValue: '')
  final String isDeliveryType;

  @JsonKey(name: 'is_delivery_date', defaultValue: '')
  final String isDeliveryDate;

  @JsonKey(name: 'is_order_type', defaultValue: '')
  final String isOrderType;

  @JsonKey(name: 'status_indicator_count', defaultValue: 0)
  final int statusIndicatorCount;

  @JsonKey(name: 'current_status_image', defaultValue: '')
  final String currentStatusImage;

  @JsonKey(name: 'current_status_description', defaultValue: '')
  final String currentStatusDescription;

  @JsonKey(name: 'delivery_boy_name', defaultValue: '')
  final String deliveryBoyName;

  @JsonKey(name: 'delivery_boy_mobile', defaultValue: '')
  final String deliveryBoyMobile;

  @JsonKey(name: 'display_status', defaultValue: '')
  final String displayStatus;

  @JsonKey(name: 'is_slot', defaultValue: '')
  final String isSlot;

  @JsonKey(name: 'customer_mobile', defaultValue: '')
  final String customerMobile;

  @JsonKey(name: 'is_saved_amount', defaultValue: '')
  final String isSavedAmount;

  @JsonKey(name: 'order_shipping_address')
  final OrderShippingAddress? orderShippingAddress;

  Order({
    required this.id,
    required this.orderId,
    required this.invoiceNo,
    required this.userId,
    required this.deliveryDate,
    required this.paymentStatus,
    required this.noOfProduct,
    required this.status,
    required this.orderDate,
    required this.subTotal,
    required this.discount,
    required this.deliveryFee,
    required this.grandTotal,
    required this.isOrderDate,
    required this.customerName,
    required this.isDeliveryType,
    required this.isDeliveryDate,
    required this.isOrderType,
    required this.statusIndicatorCount,
    required this.currentStatusImage,
    required this.currentStatusDescription,
    required this.deliveryBoyName,
    required this.deliveryBoyMobile,
    required this.displayStatus,
    required this.isSlot,
    required this.customerMobile,
    required this.isSavedAmount,
    required this.orderShippingAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderShippingAddress {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(name: 'order_id', defaultValue: 0)
  final int orderId;

  @JsonKey(name: 'address_name', defaultValue: '')
  final String name;

  @JsonKey(defaultValue: '')
  final String address;

  @JsonKey(defaultValue: '')
  final String city;

  @JsonKey(defaultValue: '')
  final String pincode;

  @JsonKey(defaultValue: '')
  final String landmark;

  @JsonKey(name: 'street_flat', defaultValue: '')
  final String streetFlat;

  OrderShippingAddress({
    required this.id,
    required this.orderId,
    required this.name,
    required this.address,
    required this.city,
    required this.pincode,
    required this.landmark,
    required this.streetFlat,
  });

  factory OrderShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$OrderShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$OrderShippingAddressToJson(this);
}

// <

class OrderDetailRequest {
  final int userId;
  final int orderId;

  OrderDetailRequest({required this.userId, required this.orderId});

  Map<String, dynamic> toJson() => {'user_id': userId, 'order_id': orderId};
}

@JsonSerializable(explicitToJson: true)
class OrderDetailResponse {
  @JsonKey(name: 'order_detail', defaultValue: [])
  final List<OrderItem> orderDetail;

  final Order order;

  @JsonKey(name: 'address')
  final OrderShippingAddress? address;

  @JsonKey(name: 'status_details', defaultValue: [])
  final List<OrderStatus> statusDetails;

  OrderDetailResponse({
    required this.orderDetail,
    required this.order,
    required this.address,
    required this.statusDetails,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailResponseToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(defaultValue: 0)
  final int id;

  @JsonKey(name: 'order_id', defaultValue: '')
  final String orderId;

  @JsonKey(name: 'product_id', defaultValue: 0)
  final int productId;

  @JsonKey(name: 'varient_id', defaultValue: 0)
  final int varientId;

  @JsonKey(defaultValue: 0)
  final int price;

  @JsonKey(defaultValue: 0)
  final int qty;

  @JsonKey(name: 'net_total', defaultValue: 0)
  final int netTotal;

  @JsonKey(name: 'is_varient_name', defaultValue: '')
  final String variantName;

  @JsonKey(name: 'is_product_name', defaultValue: '')
  final String productName;

  @JsonKey(name: 'is_product_image', defaultValue: '')
  final String productImage;

  @JsonKey(name: 'is_total_mrp_price', defaultValue: 0)
  final int totalMrpPrice;

  final OrderItemProduct product;

  @JsonKey(name: 'product_varient')
  final OrderItemVariant productVarient;

  @JsonKey(name: 'variant_colors')
  final OrderItemColorVariant? colorVarient;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.varientId,
    required this.price,
    required this.qty,
    required this.netTotal,
    required this.variantName,
    required this.productName,
    required this.productImage,
    required this.totalMrpPrice,
    required this.product,
    required this.productVarient,
    required this.colorVarient,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class OrderItemProduct {
  final int id;
  final String name;

  @JsonKey(name: 'is_image', defaultValue: '')
  final String isImage;

  OrderItemProduct({
    required this.id,
    required this.name,
    required this.isImage,
  });

  factory OrderItemProduct.fromJson(Map<String, dynamic> json) =>
      _$OrderItemProductFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemProductToJson(this);
}

@JsonSerializable()
class OrderItemVariant {
  final int id;

  @JsonKey(name: 'selling_price', defaultValue: 0)
  final num sellingPrice;

  @JsonKey(name: 'mrp_price', defaultValue: 0)
  final num mrpPrice;

  @JsonKey(name: 'include_gst', defaultValue: 0)
  final num includeGst;

  @JsonKey(name: 'exclude_gst', defaultValue: 0)
  final num excludeGst;

  @JsonKey(name: 'is_varient_image', defaultValue: '')
  final String isVarientImage;

  factory OrderItemVariant.fromJson(Map<String, dynamic> json) =>
      _$OrderItemVariantFromJson(json);

  OrderItemVariant({
    required this.id,
    required this.sellingPrice,
    required this.mrpPrice,
    required this.includeGst,
    required this.excludeGst,
    required this.isVarientImage,
  });

  Map<String, dynamic> toJson() => _$OrderItemVariantToJson(this);
}

@JsonSerializable()
class OrderItemColorVariant {
  final int id;

  @JsonKey(name: 'selling_price', defaultValue: 0)
  final num sellingPrice;

  @JsonKey(name: 'mrp_price', defaultValue: 0)
  final num mrpPrice;

  @JsonKey(name: 'include_gst', defaultValue: 0)
  final num includeGst;

  @JsonKey(name: 'exclude_gst', defaultValue: 0)
  final num excludeGst;

  @JsonKey(name: 'is_image', defaultValue: '')
  final String isImage;

  factory OrderItemColorVariant.fromJson(Map<String, dynamic> json) =>
      _$OrderItemColorVariantFromJson(json);

  OrderItemColorVariant({
    required this.id,
    required this.sellingPrice,
    required this.mrpPrice,
    required this.includeGst,
    required this.excludeGst,
    required this.isImage,
  });

  Map<String, dynamic> toJson() => _$OrderItemColorVariantToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrderStatus {
  final int id;

  @JsonKey(name: 'status_name', defaultValue: '')
  final String statusName;

  @JsonKey(name: 'display_status', defaultValue: '')
  final String displayStatus;

  @JsonKey(name: 'description', defaultValue: '')
  final String description;

  @JsonKey(name: 'is_status', defaultValue: 0)
  final int isStatus;

  @JsonKey(name: 'is_status_details', defaultValue: [])
  final List<StatusHistory> statusHistory;

  @JsonKey(name: 'is_status_image', defaultValue: '')
  final String statusImage;

  @JsonKey(name: 'is_status_image_highlight', defaultValue: '')
  final String statusImageHighlight;

  OrderStatus({
    required this.id,
    required this.statusName,
    required this.description,
    required this.displayStatus,
    required this.isStatus,
    required this.statusHistory,
    required this.statusImage,
    required this.statusImageHighlight,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}

@JsonSerializable()
class StatusHistory {
  final int id;

  @JsonKey(name: 'shipping_details', defaultValue: '')
  final String shippingDetails;

  @JsonKey(name: 'order_tracking_date', defaultValue: '')
  final String trackingDate;

  @JsonKey(defaultValue: '')
  final String status;

  StatusHistory({
    required this.id,
    required this.shippingDetails,
    required this.trackingDate,
    required this.status,
  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) =>
      _$StatusHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$StatusHistoryToJson(this);
}

num stringToNum(dynamic value) {
  try {
    return num.tryParse(value.toString()) ?? 0;
  } catch (e) {
    return 0;
  }
}
