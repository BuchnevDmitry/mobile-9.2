import 'package:auto_route/auto_route.dart';
import 'package:rentool/router/router.dart';

abstract class UserRoutes {
  static final routes = AutoRoute(
    page: UserWrapperRoute.page,
    children: [
      AutoRoute(page: UserRoute.page, initial: true, path: 'user/'),
      AutoRoute(page: FavoriteToolsRoute.page, path: 'favorite_tools'),
      AutoRoute(page: ActiveOrdersRoute.page, path: 'active_orders/'),
      AutoRoute(page: HistoryOrdersRoute.page, path: 'history_orders/'),
      AutoRoute(page: OrderListRoute.page, path: 'order_list'),
      AutoRoute(page: LeaseExtensionRoute.page, path: 'lease_extention')
    ],
  );
}
