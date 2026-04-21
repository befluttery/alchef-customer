import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/no_data.dart';
import 'package:alchef/common/widgets/primary_loader.dart';
import 'package:alchef/features/orders/controller/order_list_controller.dart';
import 'package:alchef/features/orders/view/order_item_card.dart';
import 'package:go_router/go_router.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final controller = Get.put(OrderListController());
  final _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOrders(initialize: true);
    });
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= (maxScroll * 0.8)) {
        if (controller.canScroll) {
          controller.fetchOrders(initialize: false);
        }
      }
    });
    super.initState();
  }

  void _goHome() {
    Get.find<DashboardController>().changeIndex(0);
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        _goHome();
      },
      child: CustomScaffold(
        padding: EdgeInsets.all(0),
        appbarTitle: 'My Orders',
        onBack: _goHome,
        body: Obx(() {
          if (controller.isLoading.value) {
            return PrimaryLoader();
          }

          final orders = controller.orders;

          if (orders.isEmpty) {
            return NoData(onRetry: null);
          }

          if (controller.error != null) {
            return ErrorContent(
              message: controller.error,
              onRetry: () => controller.fetchOrders(initialize: true),
            );
          }

          return RefreshIndicator(
            onRefresh: () => controller.fetchOrders(initialize: true),
            child: ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount:
                  orders.length + (controller.paginationLoading.value ? 1 : 0),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                if (index < orders.length) {
                  return OrderItemCard(order: orders[index], onTap: () {});
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
