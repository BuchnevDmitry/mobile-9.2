import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/catalog/catalog.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
import 'package:rentool/repositories/repositories.dart';
import 'package:rentool/router/ads_feed_routes.dart';
import 'package:rentool/router/catalog_routes.dart';

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
            AutoRoute(page: ShopRoute.page, path: 'shop'),
            AutoRoute(page: UserRoute.page, path: 'user'),
          ],
        ),
      ];
}
