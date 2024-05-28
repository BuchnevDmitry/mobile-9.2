import 'package:auto_route/auto_route.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/router/router.dart';

abstract class UserRoutes {
  static final routes = AutoRoute(
    page: UserWrapperRoute.page,
    children: [
      AutoRoute(
        page: UserRoute.page,
        initial: true,
        path: 'user/',
      ),
      AutoRoute(
          page: FavoriteToolsRoute.page,
          path: 'favorite_tools/',
          guards: [AuthGuard()]),
      AutoRoute(
          page: ActiveOrdersRoute.page,
          path: 'active_orders/',
          guards: [AuthGuard()]),
      AutoRoute(
          page: HistoryOrdersRoute.page,
          path: 'history_orders/',
          guards: [AuthGuard()]),
      AutoRoute(
          page: OrderListRoute.page,
          path: 'order_list/',
          guards: [AuthGuard()]),
      AutoRoute(
          page: LeaseExtensionRoute.page,
          path: 'lease_extention/',
          guards: [AuthGuard()]),
      AutoRoute(page: CardProductRoute.page, path: 'card_product/'),
    ],
  );
}
