import 'package:auto_route/auto_route.dart';
import 'package:rentool/features/catalog/catalog.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/user/user.dart';

import '../features/ads_feed/ads_feed.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: AdsFeedRoute.page,
              path: 'ads_feed',
            ),
            AutoRoute(
              page: CatalogRoute.page,
              path: 'catalog',
            ),
            AutoRoute(
              page: ShopRoute.page,
              path: 'shop',
            ),
            AutoRoute(
              page: UserRoute.page,
              path: 'user',
            ),
          ],
        ),
      ];
}
