// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ActiveOrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ActiveOrdersScreen(),
      );
    },
    AdsFeedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AdsFeedScreen(),
      );
    },
    AdsFeedWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const AdsFeedWrapperScreen()),
      );
    },
    CardProductRoute.name: (routeData) {
      final args = routeData.argsAs<CardProductRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CardProductScreen(
          key: args.key,
          tool: args.tool,
        ),
      );
    },
    CatalogRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CatalogScreen(),
      );
    },
    CatalogWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const CatalogWrapperScreen()),
      );
    },
    FavoriteToolsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoriteToolsScreen(),
      );
    },
    HistoryOrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryOrdersScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LeaseExtensionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LeaseExtensionScreen(),
      );
    },
    ListToolsCategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<ListToolsCategoriesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ListToolsCategoriesScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    MapRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MapScreen(),
      );
    },
    OrderListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderListScreen(),
      );
    },
    OrderPlaceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderPlaceScreen(),
      );
    },
    ShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopScreen(),
      );
    },
    ShopWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ShopWrapperScreen()),
      );
    },
    ThanksRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ThanksScreen(),
      );
    },
    UserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserScreen(),
      );
    },
    UserWrapperRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const UserWrapperScreen()),
      );
    },
  };
}

/// generated route for
/// [ActiveOrdersScreen]
class ActiveOrdersRoute extends PageRouteInfo<void> {
  const ActiveOrdersRoute({List<PageRouteInfo>? children})
      : super(
          ActiveOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActiveOrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AdsFeedScreen]
class AdsFeedRoute extends PageRouteInfo<void> {
  const AdsFeedRoute({List<PageRouteInfo>? children})
      : super(
          AdsFeedRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdsFeedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AdsFeedWrapperScreen]
class AdsFeedWrapperRoute extends PageRouteInfo<void> {
  const AdsFeedWrapperRoute({List<PageRouteInfo>? children})
      : super(
          AdsFeedWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'AdsFeedWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CardProductScreen]
class CardProductRoute extends PageRouteInfo<CardProductRouteArgs> {
  CardProductRoute({
    Key? key,
    required Tool tool,
    List<PageRouteInfo>? children,
  }) : super(
          CardProductRoute.name,
          args: CardProductRouteArgs(
            key: key,
            tool: tool,
          ),
          initialChildren: children,
        );

  static const String name = 'CardProductRoute';

  static const PageInfo<CardProductRouteArgs> page =
      PageInfo<CardProductRouteArgs>(name);
}

class CardProductRouteArgs {
  const CardProductRouteArgs({
    this.key,
    required this.tool,
  });

  final Key? key;

  final Tool tool;

  @override
  String toString() {
    return 'CardProductRouteArgs{key: $key, tool: $tool}';
  }
}

/// generated route for
/// [CatalogScreen]
class CatalogRoute extends PageRouteInfo<void> {
  const CatalogRoute({List<PageRouteInfo>? children})
      : super(
          CatalogRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CatalogWrapperScreen]
class CatalogWrapperRoute extends PageRouteInfo<void> {
  const CatalogWrapperRoute({List<PageRouteInfo>? children})
      : super(
          CatalogWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoriteToolsScreen]
class FavoriteToolsRoute extends PageRouteInfo<void> {
  const FavoriteToolsRoute({List<PageRouteInfo>? children})
      : super(
          FavoriteToolsRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteToolsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HistoryOrdersScreen]
class HistoryOrdersRoute extends PageRouteInfo<void> {
  const HistoryOrdersRoute({List<PageRouteInfo>? children})
      : super(
          HistoryOrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryOrdersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LeaseExtensionScreen]
class LeaseExtensionRoute extends PageRouteInfo<void> {
  const LeaseExtensionRoute({List<PageRouteInfo>? children})
      : super(
          LeaseExtensionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LeaseExtensionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ListToolsCategoriesScreen]
class ListToolsCategoriesRoute
    extends PageRouteInfo<ListToolsCategoriesRouteArgs> {
  ListToolsCategoriesRoute({
    Key? key,
    required Category category,
    List<PageRouteInfo>? children,
  }) : super(
          ListToolsCategoriesRoute.name,
          args: ListToolsCategoriesRouteArgs(
            key: key,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'ListToolsCategoriesRoute';

  static const PageInfo<ListToolsCategoriesRouteArgs> page =
      PageInfo<ListToolsCategoriesRouteArgs>(name);
}

class ListToolsCategoriesRouteArgs {
  const ListToolsCategoriesRouteArgs({
    this.key,
    required this.category,
  });

  final Key? key;

  final Category category;

  @override
  String toString() {
    return 'ListToolsCategoriesRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<void> {
  const MapRoute({List<PageRouteInfo>? children})
      : super(
          MapRoute.name,
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderListScreen]
class OrderListRoute extends PageRouteInfo<void> {
  const OrderListRoute({List<PageRouteInfo>? children})
      : super(
          OrderListRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderPlaceScreen]
class OrderPlaceRoute extends PageRouteInfo<void> {
  const OrderPlaceRoute({List<PageRouteInfo>? children})
      : super(
          OrderPlaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderPlaceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShopScreen]
class ShopRoute extends PageRouteInfo<void> {
  const ShopRoute({List<PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ShopWrapperScreen]
class ShopWrapperRoute extends PageRouteInfo<void> {
  const ShopWrapperRoute({List<PageRouteInfo>? children})
      : super(
          ShopWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ThanksScreen]
class ThanksRoute extends PageRouteInfo<void> {
  const ThanksRoute({List<PageRouteInfo>? children})
      : super(
          ThanksRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThanksRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserScreen]
class UserRoute extends PageRouteInfo<void> {
  const UserRoute({List<PageRouteInfo>? children})
      : super(
          UserRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [UserWrapperScreen]
class UserWrapperRoute extends PageRouteInfo<void> {
  const UserWrapperRoute({List<PageRouteInfo>? children})
      : super(
          UserWrapperRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserWrapperRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
