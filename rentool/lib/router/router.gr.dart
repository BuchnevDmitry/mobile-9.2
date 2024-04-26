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
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
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
    ShopRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShopScreen(),
      );
    },
    UserRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const UserScreen(),
      );
    },
  };
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
