import 'package:auto_route/auto_route.dart';
import 'package:rentool/router/router.dart';

class CatalogRoutes {
  static final routes = AutoRoute(
    page: CatalogWrapperRoute.page,
    children: [
      AutoRoute(page: CatalogRoute.page, initial: true, path: 'catalog/'),
      AutoRoute(page: ListToolsCategoriesRoute.page, path: 'list_tools/'),
      AutoRoute(page: CardProductRoute.page, path: 'card_product/'),
      AutoRoute(page: ListToolsSearchRoute.page, path: 'search_tools/'),
    ],
  );
}
