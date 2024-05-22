import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:realm/realm.dart';

import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/card_product/card_product.dart';
import 'package:rentool/features/catalog/catalog.dart';
import 'package:rentool/features/home/home.dart';
import 'package:rentool/features/list_tools/list_tools.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/features/map/map.dart';
import 'package:rentool/features/shop/shop.dart';
import 'package:rentool/features/user/user.dart';
import 'package:rentool/repositories/repositories.dart';
import 'package:rentool/router/router.dart';
import 'package:rentool/theme/theme.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

class RenToolApp extends StatefulWidget {
  const RenToolApp({
    super.key,
    required this.realm,
  });

  final Realm realm;

  @override
  State<RenToolApp> createState() => _RenToolAppState();
}

class _RenToolAppState extends State<RenToolApp> {
  final _router = AppRouter();
  final _toolsApiClient = ToolsApiClient.create(apiUrl: dotenv.env['API_URL']);
  final _categoriesApiClient =
      CategoriesApiClient.create(apiUrl: dotenv.env['API_URL']);
  final _geocoder = YandexGeocoder(apiKey: dotenv.env['GEOCODER_KEY']!);

  @override
  Widget build(BuildContext context) {
    final orderRepository = OrderRepository(realm: widget.realm);
    final orderAddressRepository = OrderAddressRepository(realm: widget.realm);
    final favoriteRepository = FavoriteRepository(realm: widget.realm);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdsFeedBloc>(
          create: (context) => AdsFeedBloc(
            toolApiClient: _toolsApiClient,
            repository: favoriteRepository,
          ),
        ),
        BlocProvider<CardProductBloc>(
          create: (context) => CardProductBloc(
            repository: favoriteRepository,
          ),
        ),
        BlocProvider<CatalogBloc>(
          create: (context) => CatalogBloc(
            categoriesApiClient: _categoriesApiClient,
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            repository: orderRepository,
          ),
        ),
        BlocProvider<ListToolsBloc>(
          create: (context) => ListToolsBloc(
            toolsApiClient: _toolsApiClient,
            repository: favoriteRepository,
          ),
        ),
        BlocProvider<MapBloc>(
          create: (context) => MapBloc(
            geocoder: _geocoder,
            repository: orderAddressRepository,
          ),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(
            orderRepository: orderRepository,
          ),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            repository: favoriteRepository,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Rentool',
        theme: AppTheme.lightTheme,
        routerDelegate: _router.delegate(),
        routeInformationParser: _router.defaultRouteParser(),
      ),
    );
  }
}
