import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/category/view/widgets/category_grid.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/no_data.dart';
import 'package:alchef/features/category/controller/category_list_controller.dart';
import 'package:go_router/go_router.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final controller = Get.put(CategoryListController());
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    initialize();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      if (currentScroll >= (maxScroll * 0.8)) {
        if (controller.canScroll) {
          controller.fetchCategories(
            initialize: false,
            search: _searchController.text.trim(),
          );
        }
      }
    });
    super.initState();
  }

  Future<void> initialize() async {
    controller.fetchCategories(
      initialize: true,
      search: _searchController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return CustomScaffold(
      appbarTitle: 'Categories',
      onBack: () {
        context.go(RoutePaths.home);
      },
      body: RefreshIndicator(
        onRefresh: initialize,
        child: Obx(() {
          if (controller.isLoading.value) {
            return CategoryGrid(
              isLoading: true,
              padding: EdgeInsets.all(s.pagePadding),
              categories: [],
              onCategoryTap: (c) {},
            );
          }
          if (controller.error != null) {
            return ErrorContent(message: controller.error, onRetry: initialize);
          }

          final categories = controller.categories;

          if (categories.isEmpty) {
            return NoData(onRetry: initialize);
          }

          return CategoryGrid(
            padding: EdgeInsets.all(s.pagePadding),
            scrollController: _scrollController,
            categories: categories,
            isPaginationLoading: controller.paginationLoading.value,
            onCategoryTap: (c) {
              context.push(RoutePaths.categoryProducts, extra: c.id);
            },
          );
        }),
      ),
    );
  }
}
