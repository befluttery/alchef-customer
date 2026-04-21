// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$OrderListRequestToJson(OrderListRequest instance) =>
    <String, dynamic>{'user_id': instance.userId, 'pag_no': instance.pageNo};

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
  id: (json['id'] as num?)?.toInt() ?? 0,
  orderId: json['order_id'] as String? ?? '',
  invoiceNo: json['invoice_no'] as String? ?? '',
  userId: (json['user_id'] as num?)?.toInt() ?? 0,
  deliveryDate: json['delivery_date'] as String? ?? '',
  paymentStatus: json['payment_status'] as String? ?? '',
  noOfProduct: (json['no_of_product'] as num?)?.toInt() ?? 0,
  status: json['status'] as String? ?? '',
  orderDate: json['order_date'] as String? ?? '',
  subTotal: json['sub_total'] as num? ?? 0,
  discount: json['discount'] as num? ?? 0,
  deliveryFee: json['delivery_fee'] == null
      ? 0
      : stringToNum(json['delivery_fee']),
  grandTotal: json['grand_total'] as num? ?? 0,
  isOrderDate: json['is_order_date'] as String? ?? '',
  customerName: json['customer_name'] as String? ?? '',
  isDeliveryType: json['is_delivery_type'] as String? ?? '',
  isDeliveryDate: json['is_delivery_date'] as String? ?? '',
  isOrderType: json['is_order_type'] as String? ?? '',
  statusIndicatorCount: (json['status_indicator_count'] as num?)?.toInt() ?? 0,
  currentStatusImage: json['current_status_image'] as String? ?? '',
  currentStatusDescription: json['current_status_description'] as String? ?? '',
  deliveryBoyName: json['delivery_boy_name'] as String? ?? '',
  deliveryBoyMobile: json['delivery_boy_mobile'] as String? ?? '',
  displayStatus: json['display_status'] as String? ?? '',
  isSlot: json['is_slot'] as String? ?? '',
  customerMobile: json['customer_mobile'] as String? ?? '',
  isSavedAmount: json['is_saved_amount'] as String? ?? '',
  orderShippingAddress: json['order_shipping_address'] == null
      ? null
      : OrderShippingAddress.fromJson(
          json['order_shipping_address'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'invoice_no': instance.invoiceNo,
  'user_id': instance.userId,
  'delivery_date': instance.deliveryDate,
  'payment_status': instance.paymentStatus,
  'no_of_product': instance.noOfProduct,
  'status': instance.status,
  'order_date': instance.orderDate,
  'sub_total': instance.subTotal,
  'discount': instance.discount,
  'delivery_fee': instance.deliveryFee,
  'grand_total': instance.grandTotal,
  'is_order_date': instance.isOrderDate,
  'customer_name': instance.customerName,
  'is_delivery_type': instance.isDeliveryType,
  'is_delivery_date': instance.isDeliveryDate,
  'is_order_type': instance.isOrderType,
  'status_indicator_count': instance.statusIndicatorCount,
  'current_status_image': instance.currentStatusImage,
  'current_status_description': instance.currentStatusDescription,
  'delivery_boy_name': instance.deliveryBoyName,
  'delivery_boy_mobile': instance.deliveryBoyMobile,
  'display_status': instance.displayStatus,
  'is_slot': instance.isSlot,
  'customer_mobile': instance.customerMobile,
  'is_saved_amount': instance.isSavedAmount,
  'order_shipping_address': instance.orderShippingAddress?.toJson(),
};

OrderShippingAddress _$OrderShippingAddressFromJson(
  Map<String, dynamic> json,
) => OrderShippingAddress(
  id: (json['id'] as num?)?.toInt() ?? 0,
  orderId: (json['order_id'] as num?)?.toInt() ?? 0,
  name: json['address_name'] as String? ?? '',
  address: json['address'] as String? ?? '',
  city: json['city'] as String? ?? '',
  pincode: json['pincode'] as String? ?? '',
  landmark: json['landmark'] as String? ?? '',
  streetFlat: json['street_flat'] as String? ?? '',
);

Map<String, dynamic> _$OrderShippingAddressToJson(
  OrderShippingAddress instance,
) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'address_name': instance.name,
  'address': instance.address,
  'city': instance.city,
  'pincode': instance.pincode,
  'landmark': instance.landmark,
  'street_flat': instance.streetFlat,
};

OrderDetailResponse _$OrderDetailResponseFromJson(Map<String, dynamic> json) =>
    OrderDetailResponse(
      orderDetail:
          (json['order_detail'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      order: Order.fromJson(json['order'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : OrderShippingAddress.fromJson(
              json['address'] as Map<String, dynamic>,
            ),
      statusDetails:
          (json['status_details'] as List<dynamic>?)
              ?.map((e) => OrderStatus.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$OrderDetailResponseToJson(
  OrderDetailResponse instance,
) => <String, dynamic>{
  'order_detail': instance.orderDetail.map((e) => e.toJson()).toList(),
  'order': instance.order.toJson(),
  'address': instance.address?.toJson(),
  'status_details': instance.statusDetails.map((e) => e.toJson()).toList(),
};

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
  id: (json['id'] as num?)?.toInt() ?? 0,
  orderId: json['order_id'] as String? ?? '',
  productId: (json['product_id'] as num?)?.toInt() ?? 0,
  varientId: (json['varient_id'] as num?)?.toInt() ?? 0,
  price: (json['price'] as num?)?.toInt() ?? 0,
  qty: (json['qty'] as num?)?.toInt() ?? 0,
  netTotal: (json['net_total'] as num?)?.toInt() ?? 0,
  variantName: json['is_varient_name'] as String? ?? '',
  productName: json['is_product_name'] as String? ?? '',
  productImage: json['is_product_image'] as String? ?? '',
  totalMrpPrice: (json['is_total_mrp_price'] as num?)?.toInt() ?? 0,
  product: OrderItemProduct.fromJson(json['product'] as Map<String, dynamic>),
  productVarient: OrderItemVariant.fromJson(
    json['product_varient'] as Map<String, dynamic>,
  ),
  colorVarient: json['variant_colors'] == null
      ? null
      : OrderItemColorVariant.fromJson(
          json['variant_colors'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
  'id': instance.id,
  'order_id': instance.orderId,
  'product_id': instance.productId,
  'varient_id': instance.varientId,
  'price': instance.price,
  'qty': instance.qty,
  'net_total': instance.netTotal,
  'is_varient_name': instance.variantName,
  'is_product_name': instance.productName,
  'is_product_image': instance.productImage,
  'is_total_mrp_price': instance.totalMrpPrice,
  'product': instance.product,
  'product_varient': instance.productVarient,
  'variant_colors': instance.colorVarient,
};

OrderItemProduct _$OrderItemProductFromJson(Map<String, dynamic> json) =>
    OrderItemProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      isImage: json['is_image'] as String? ?? '',
    );

Map<String, dynamic> _$OrderItemProductToJson(OrderItemProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_image': instance.isImage,
    };

OrderItemVariant _$OrderItemVariantFromJson(Map<String, dynamic> json) =>
    OrderItemVariant(
      id: (json['id'] as num).toInt(),
      sellingPrice: json['selling_price'] as num? ?? 0,
      mrpPrice: json['mrp_price'] as num? ?? 0,
      includeGst: json['include_gst'] as num? ?? 0,
      excludeGst: json['exclude_gst'] as num? ?? 0,
      isVarientImage: json['is_varient_image'] as String? ?? '',
    );

Map<String, dynamic> _$OrderItemVariantToJson(OrderItemVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'selling_price': instance.sellingPrice,
      'mrp_price': instance.mrpPrice,
      'include_gst': instance.includeGst,
      'exclude_gst': instance.excludeGst,
      'is_varient_image': instance.isVarientImage,
    };

OrderItemColorVariant _$OrderItemColorVariantFromJson(
  Map<String, dynamic> json,
) => OrderItemColorVariant(
  id: (json['id'] as num).toInt(),
  sellingPrice: json['selling_price'] as num? ?? 0,
  mrpPrice: json['mrp_price'] as num? ?? 0,
  includeGst: json['include_gst'] as num? ?? 0,
  excludeGst: json['exclude_gst'] as num? ?? 0,
  isImage: json['is_image'] as String? ?? '',
);

Map<String, dynamic> _$OrderItemColorVariantToJson(
  OrderItemColorVariant instance,
) => <String, dynamic>{
  'id': instance.id,
  'selling_price': instance.sellingPrice,
  'mrp_price': instance.mrpPrice,
  'include_gst': instance.includeGst,
  'exclude_gst': instance.excludeGst,
  'is_image': instance.isImage,
};

OrderStatus _$OrderStatusFromJson(Map<String, dynamic> json) => OrderStatus(
  id: (json['id'] as num).toInt(),
  statusName: json['status_name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  displayStatus: json['display_status'] as String? ?? '',
  isStatus: (json['is_status'] as num?)?.toInt() ?? 0,
  statusHistory:
      (json['is_status_details'] as List<dynamic>?)
          ?.map((e) => StatusHistory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  statusImage: json['is_status_image'] as String? ?? '',
  statusImageHighlight: json['is_status_image_highlight'] as String? ?? '',
);

Map<String, dynamic> _$OrderStatusToJson(
  OrderStatus instance,
) => <String, dynamic>{
  'id': instance.id,
  'status_name': instance.statusName,
  'display_status': instance.displayStatus,
  'description': instance.description,
  'is_status': instance.isStatus,
  'is_status_details': instance.statusHistory.map((e) => e.toJson()).toList(),
  'is_status_image': instance.statusImage,
  'is_status_image_highlight': instance.statusImageHighlight,
};

StatusHistory _$StatusHistoryFromJson(Map<String, dynamic> json) =>
    StatusHistory(
      id: (json['id'] as num).toInt(),
      shippingDetails: json['shipping_details'] as String? ?? '',
      trackingDate: json['order_tracking_date'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$StatusHistoryToJson(StatusHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shipping_details': instance.shippingDetails,
      'order_tracking_date': instance.trackingDate,
      'status': instance.status,
    };
