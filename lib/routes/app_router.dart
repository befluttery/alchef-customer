import 'package:alchef/features/address/view/screens/address_list_screen.dart';
import 'package:alchef/features/auth/view/screens/login_screen.dart';
import 'package:alchef/features/auth/view/screens/otp_screen.dart';
import 'package:alchef/features/auth/view/screens/update_profile_screen.dart';
import 'package:alchef/features/cart/view/screens/cart_screen.dart';
import 'package:alchef/features/cart/view/screens/checkout_screen.dart';
import 'package:alchef/features/coupon/view/coupon_list_screen.dart';
import 'package:alchef/features/dashboard/dashboard_screen.dart';
import 'package:alchef/features/home/view/home_screen.dart';
import 'package:alchef/features/notification/view/notification_screen.dart';
import 'package:alchef/features/orders/view/order_list_screen.dart';
import 'package:alchef/features/products/view/screens/category_products_screen.dart';
import 'package:alchef/features/products/view/screens/product_detail_screen.dart';
import 'package:alchef/features/products/view/screens/search_products_screen.dart';
import 'package:alchef/features/profile/view/profile_screen.dart';
import 'package:alchef/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_paths.dart';

final appNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: appNavigatorKey,
  initialLocation: RoutePaths.splash,
  routes: [
    // ── Auth flow ────────────────────────────────────────────────
    GoRoute(
      path: RoutePaths.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(path: RoutePaths.login, builder: (context, state) => LoginScreen()),
    GoRoute(
      path: RoutePaths.otp,
      builder: (context, state) {
        final args = state.extra as OtpScreenArgs;
        return OtpScreen(args: args);
      },
    ),
    GoRoute(
      path: RoutePaths.updateProfile,
      builder: (context, state) => const UpdateProfileScreen(),
    ),

    GoRoute(
      path: RoutePaths.updateProfile,
      builder: (context, state) => const UpdateProfileScreen(),
    ),

    // ── Dashboard shell (StatefulShellRoute) ─────────────────────
    ShellRoute(
      builder: (context, state, child) => DashboardScreen(child: child),

      routes: [
        GoRoute(
          path: RoutePaths.home,
          builder: (context, state) => const HomeScreen(),
        ),

        GoRoute(
          path: RoutePaths.categoryProducts,
          builder: (context, state) {
            final categoryId = state.extra as int?;
            return CategoryProductsScreen(categoryId: categoryId);
          },
        ),

        GoRoute(
          path: RoutePaths.cart,
          builder: (context, state) => const CartScreen(),
        ),

        GoRoute(
          path: RoutePaths.orders,
          builder: (context, state) => const OrderListScreen(),
        ),

        GoRoute(
          path: RoutePaths.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    //
    GoRoute(
      path: RoutePaths.notifications,
      builder: (context, state) {
        return const NotificationScreen();
      },
    ),

    //
    GoRoute(
      path: RoutePaths.addressList,
      builder: (context, state) {
        return const AddressListScreen();
      },
    ),

    //
    GoRoute(
      path: RoutePaths.searchProduct,
      builder: (context, state) {
        return const SearchProductsScreen();
      },
    ),

    GoRoute(
      path: RoutePaths.productDetail,
      builder: (context, state) {
        final productId = state.extra as int;
        return ProductDetailScreen(productId: productId);
      },
    ),

    GoRoute(
      path: RoutePaths.coupons,
      builder: (context, state) => CouponListScreen(onSelect: (c) {}),
    ),

    GoRoute(
      path: RoutePaths.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
  ],
);
