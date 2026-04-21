import 'package:alchef/config/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/features/orders/model/order_model.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.order,
    this.inListPage = true,
    this.onTap,
    this.onTrack,
  });

  final Order order;
  final bool inListPage;
  final VoidCallback? onTap;
  final VoidCallback? onTrack;

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(s.cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(s.cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 6.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(s.cardPadding),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(s.cardRadius),
                  ),
                  child: OnlineImage(
                    link: order.currentStatusImage,
                    height: s.avatarMd,
                    width: s.avatarMd,
                  ),
                ),
                SizedBox(width: s.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.orderId}',
                        style: TextStyle(
                          fontSize: s.fontMd,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: s.spacingXs),
                      Text(
                        'Placed on ${order.isOrderDate}',
                        style: TextStyle(
                          fontSize: s.fontSm,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: s.spacingXs),
                      Text(
                        'Items : ${order.noOfProduct}',
                        style: TextStyle(
                          fontSize: s.fontSm + 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                if (!inListPage)
                  InkWell(
                    onTap: onTrack,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: s.spacingMd - 2,
                        vertical: s.spacingXs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Track',
                        style: TextStyle(
                          fontSize: s.fontSm,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Divider(color: Colors.grey.shade200, height: s.spacingLg),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.displayStatus,
                  style: TextStyle(
                    fontSize: s.fontSm,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
                Text(
                  order.isDeliveryDate,
                  style: TextStyle(
                    fontSize: s.fontSm,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
