import 'package:auto_route/auto_route.dart';
import 'package:rentool/router/router.dart';

abstract class ShopRoutes {
  static final routes = AutoRoute(
    page: ShopWrapperRoute.page,
    children: [
      AutoRoute(page: ShopRoute.page, initial: true, path: 'shop/'),
    ],
  );
}
