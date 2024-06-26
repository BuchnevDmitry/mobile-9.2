import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/features/card_product/view/view.dart';
import 'package:rentool/features/catalog/catalog.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
import 'package:rentool/features/map/map.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/router/ads_feed_routes.dart';
import 'package:rentool/router/catalog_routes.dart';
import 'package:rentool/router/shop_routes.dart';
import 'package:rentool/router/user_routes.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          initial: true,
          children: [
            AdsFeedRoutes.routes,
            CatalogRoutes.routes,
            ShopRoutes.routes,
            UserRoutes.routes,
          ],
        ),
        AutoRoute(
          page: MapDeliveryRoute.page,
          path: '/map_delivery',
          guards: [AuthGuard()],
        ),
        AutoRoute(page: MapPickupRoute.page, path: '/map_pickup'),
        AutoRoute(
          page: ThanksRoute.page,
          path: '/thanks',
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: OrderPlaceRoute.page,
          path: '/order_place',
          guards: [AuthGuard()],
        ),
        AutoRoute(page: GuardRoute.page, path: '/guard'),
        AutoRoute(page: AuthRoute.page, path: '/auth'),
        AutoRoute(page: RegisterRoute.page, path: '/reg'),
      ];
}
