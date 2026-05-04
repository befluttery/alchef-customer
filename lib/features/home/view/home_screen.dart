import 'package:alchef/common/widgets/carousel_indicator.dart';
import 'package:alchef/common/widgets/custom_carousel.dart';
import 'package:alchef/common/widgets/error_content.dart';
import 'package:alchef/common/widgets/loading_shimmer.dart';
import 'package:alchef/common/widgets/online_image.dart';
import 'package:alchef/config/app_images.dart';
import 'package:alchef/config/app_sizes.dart';
import 'package:alchef/core/utils/auth_helper.dart';
import 'package:alchef/core/utils/device_helper.dart';
import 'package:alchef/core/utils/ui_helper.dart';
import 'package:alchef/features/category/view/widgets/category_horizontal_list.dart';
import 'package:alchef/features/home/controller/home_controller.dart';
import 'package:alchef/features/home/model/home_model.dart';
import 'package:alchef/features/home/view/side_menu.dart';
import 'package:alchef/features/products/view/widgets/product_list.dart';
import 'package:alchef/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(HomeController());

  @override
  void initState() {
    controller.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSizes.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: ColoredBox(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: DeviceHelper.statusbarHeight(context) + 12,
                left: s.pagePadding,
                right: s.pagePadding,
                bottom: s.pagePadding,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.doodleBg),
                  fit: BoxFit.fitWidth,
                ),
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Stack(
                          children: [
                            SizedBox(height: 56, width: 44),
                            Positioned(
                              top: 0,
                              child: Center(
                                child: Image.asset(
                                  AppImages.hat,
                                  height: s.avatarSm + 2,
                                  width: s.avatarSm + 8,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Center(
                                child: OnlineImage(
                                  link: AuthHelper.user.isUserImage,
                                  height: s.avatarSm + 8,
                                  width: s.avatarSm + 8,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ${AuthHelper.user.firstName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: s.fontMd,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: s.spacingXs),
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.locationIcon,
                                  height: s.iconSm,
                                ),
                                SizedBox(width: s.spacingXs),
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    context.push(RoutePaths.addressList);
                                  },
                                  child: Text(
                                    AuthHelper
                                            .user
                                            .userDefaultAddress
                                            ?.address ??
                                        '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: s.fontSm,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          context.push(RoutePaths.notifications);
                        },
                        child: Image.asset(
                          AppImages.notificationIcon,
                          height: s.iconLg,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: s.spacingSm),
                  InkWell(
                    onTap: () {
                      context.push(RoutePaths.searchProduct);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: s.spacingMd,
                        vertical: s.spacingSm + 4,
                      ),
                      child: Row(
                        children: [
                          Image.asset(AppImages.searchIcon, height: s.iconSm),
                          SizedBox(width: s.spacingMd),
                          Text(
                            'Search Items...',
                            style: TextStyle(
                              fontSize: s.fontSm,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: s.spacingXs),
                ],
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Obx(
                    () => SingleChildScrollView(
                      padding: EdgeInsets.all(s.pagePadding),
                      child: Column(
                        children: [
                          //BANNER SECTION
                          if (controller.bannersLoading.value)
                            LoadingShimmer(
                              height: 172,
                              width: double.infinity,
                              radius: 16,
                            )
                          else if (controller.bannersError != null)
                            ErrorContent(
                              message: controller.bannersError,
                              onRetry: controller.fetchBanners,
                            )
                          else
                            Stack(
                              children: [
                                CustomCarousel(
                                  height: 172,
                                  autoPlay: false,
                                  imageUrls: [
                                    for (final banner in controller.banners)
                                      banner.isImage,
                                  ],
                                  onImageChanged: (index, reason) {
                                    controller.activeBannerIndex.value = index;
                                  },

                                  onTap: (index) {
                                    final productId =
                                        controller.banners[index].productId;
                                    if (productId > 0) {
                                      context.push(
                                        RoutePaths.productDetail,
                                        extra: productId,
                                      );
                                    }
                                  },

                                  radius: 12,
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 12,
                                  child: CarouselIndicator(
                                    length: controller.banners.length,
                                    activeIndex:
                                        controller.activeBannerIndex.value,
                                  ),
                                ),
                              ],
                            ),

                          //CATEGORY SECTION
                          _ViewAll(
                            title: 'Browse by Category',
                            onTap: () {
                              context.push(RoutePaths.categoryProducts);
                            },
                          ),

                          if (controller.categoriesError != null)
                            ErrorContent(
                              message: controller.categoriesError,
                              onRetry: controller.fetchCategories,
                            )
                          else
                            CategoryHorizontalList(
                              isLoading: controller.categoriesLoading.value,
                              categories: controller.categories,
                              onTap: (c) {
                                context.push(
                                  RoutePaths.categoryProducts,
                                  extra: c.id,
                                );
                              },
                            ),

                          //
                          if (controller.productsLoading.value)
                            Column(
                              children: List.generate(
                                3,
                                (_) => const _CategorySectionShimmer(),
                              ),
                            )
                          else if (controller.productsError != null)
                            ErrorContent(
                              message: controller.productsError,
                              onRetry: controller.fetchCategoryProducts,
                            )
                          else
                            ListView.builder(
                              padding: EdgeInsets.all(0),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.homeCategoryProducts.length,
                              itemBuilder: (context, index) => _CategorySection(
                                category:
                                    controller.homeCategoryProducts[index],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewAll extends StatelessWidget {
  const _ViewAll({required this.title, required this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Spacer(),
          if (onTap != null)
            InkWell(
              onTap: onTap,
              child: Row(
                spacing: 6,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.category});

  final HomeCategoryProduct category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ViewAll(
          title: category.categoryName,
          onTap: category.categoryId == 0
              ? null
              : () {
                  context.push(
                    RoutePaths.categoryProducts,
                    extra: category.categoryId,
                  );
                },
        ),
        ProductList(products: category.products),
      ],
    );
  }
}

class _CategorySectionShimmer extends StatelessWidget {
  const _CategorySectionShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _ViewAll shimmer
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              LoadingShimmer(height: 18, width: 130, radius: 4),
              const Spacer(),
              LoadingShimmer(height: 14, width: 60, radius: 4),
            ],
          ),
        ),
        // ProductList shimmer
        ProductList(isLoading: true, products: const []),
      ],
    );
  }
}
