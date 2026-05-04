import 'package:alchef/common/widgets/custom_search_field.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/no_data.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/products/controller/search_products_controller.dart';
import 'package:alchef/features/products/view/widgets/product_grid.dart';
import 'package:alchef/features/products/view/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchProductsScreen extends StatefulWidget {
  const SearchProductsScreen({super.key});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  final controller = Get.put(SearchProductsController());
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    loadProducts();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _scrollController.addListener(_loadMoreProducts);
    super.initState();
  }

  Future<void> loadProducts() async {
    controller.searchProducts(
      initialize: true,
      search: _searchController.text.trim(),
    );
  }

  void _loadMoreProducts() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.8)) {
      if (controller.canScroll) {
        controller.searchProducts(
          initialize: false,
          search: _searchController.text.trim(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchProductsController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.only(
                top: DeviceHelper.statusbarHeight(context) + 12,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(AppImages.backIcon, height: 36),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: CustomSearchField(
                          focusNode: _focusNode,
                          controller: _searchController,
                          hintText: 'Search Products',
                          textInputAction: TextInputAction.search,
                          onSubmit: () {
                            UiHelper.unfocus();
                            loadProducts();
                          },
                          onChanged: (v) {
                            if (v.trim().isEmpty) {
                              loadProducts();
                            }
                          },
                          onEditingComplete: () {
                            if (_searchController.text.trim().isNotEmpty) {
                              UiHelper.unfocus();
                              loadProducts();
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),
                ],
              ),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ProductGrid(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    isLoading: true,
                    products: [],
                    isPaginationLoading: false,
                  );
                }

                if (controller.error != null) {
                  return ErrorContent(message: controller.error, onRetry: null);
                }

                if (controller.products.isEmpty) {
                  return NoData(onRetry: null);
                }

                return ProductGrid(
                  padding: EdgeInsets.all(16),
                  scrollController: _scrollController,
                  products: controller.products,
                  isPaginationLoading: controller.paginationLoading.value,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
