import 'package:auto_route/auto_route.dart';
import 'package:rentool/router/router.dart';

abstract class AdsFeedRoutes {
  static final routes = AutoRoute(
    page: AdsFeedWrapperRoute.page,
    children: [
      AutoRoute(page: AdsFeedRoute.page, initial: true, path: 'ads_feed/'),
      AutoRoute(page: CardProductRoute.page, path: 'card_product'),
    ],
  );
}
