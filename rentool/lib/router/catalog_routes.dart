import 'package:auto_route/auto_route.dart';
import 'package:rentool/router/router.dart';

class CatalogRoutes {
  static final routes = AutoRoute(
    page: CatalogWrapperRoute.page,
    children: [
      AutoRoute(page: CatalogRoute.page, initial: true, path: 'catalog/'),
      AutoRoute(page: ListToolsCategoriesRoute.page, path: 'list_tools'),
    ],
  );
}
