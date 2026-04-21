import 'package:alchef/common/widgets/custom_scaffold.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/config/app_colors.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/features/category/controller/category_list_controller.dart';
import 'package:alchef/features/category/model/category_model.dart';
import 'package:alchef/features/category/view/widgets/category_vertical_list.dart';
import 'package:alchef/features/dashboard/dashboard_controller.dart';
import 'package:alchef/features/products/controller/category_products_controller.dart';
import 'package:alchef/features/products/view/widgets/product_grid.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key, this.categoryId});

  final int? categoryId;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final controller = Get.put(CategoryProductsController());
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  final categoryListController = Get.put(CategoryListController());
  final _categoryScrollController = ScrollController();

  @override
  void initState() {
    controller.selectedCategoryId = widget.categoryId;
    loadCategories();
    loadProducts();
    _categoryScrollController.addListener(_loadMoreCategories);
    _scrollController.addListener(_loadMoreProducts);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _categoryScrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadProducts() async {
    controller.fetchProducts(
      initialize: true,
      search: _searchController.text.trim(),
    );
  }

  void _loadMoreProducts() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.8) && controller.canScroll) {
      controller.fetchProducts(
        initialize: false,
        search: _searchController.text.trim(),
      );
    }
  }

  Future<void> loadCategories() async {
    if (categoryListController.categories.isEmpty) {
      categoryListController.fetchCategories(initialize: true);
    }
  }

  void _loadMoreCategories() {
    final maxScroll = _categoryScrollController.position.maxScrollExtent;
    final currentScroll = _categoryScrollController.offset;
    if (currentScroll >= (maxScroll * 0.8) &&
        categoryListController.canScroll) {
      categoryListController.fetchCategories(initialize: false);
    }
  }

  void _onCategoryTap(Category category) {
    controller.selectedCategoryId = category.id;
    controller.update();
    controller.fetchProducts(
      initialize: true,
      search: _searchController.text.trim(),
    );
  }

  void _goHome() {
    Get.find<DashboardController>().changeIndex(0);
    context.go(RoutePaths.home);
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return GetBuilder<CategoryProductsController>(
      builder: (controller) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }

          _goHome();
        },
        child: CustomScaffold(
          onBack: _goHome,
          appbarTitle: 'Categories',
          padding: EdgeInsets.zero,
          body: IntrinsicHeight(
            child: Row(
              children: [
                // ── Category vertical list ─────────────────────────
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        right: BorderSide(color: AppColors.divider),
                      ),
                    ),
                    child: Obx(() {
                      return CategoryVerticalList(
                        padding: EdgeInsets.symmetric(vertical: s.pagePadding),
                        categories: categoryListController.categories,
                        selectedCategoryId: controller.selectedCategoryId,
                        isLoading: categoryListController.isLoading.value,
                        isPaginationLoading:
                            categoryListController.paginationLoading.value,
                        scrollController: _categoryScrollController,
                        onCategoryTap: _onCategoryTap,
                      );
                    }),
                  ),
                ),

                // ── Product grid ───────────────────────────────────
                Expanded(
                  flex: 4,
                  child: Obx(() {
                    if (controller.error != null &&
                        controller.products.isEmpty) {
                      return ErrorContent(
                        message: controller.error,
                        onRetry: loadProducts,
                      );
                    }

                    return ProductGrid(
                      products: controller.products,
                      isLoading: controller.isLoading.value,
                      isPaginationLoading: controller.paginationLoading.value,
                      scrollController: _scrollController,
                      padding: EdgeInsets.all(s.pagePadding),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
