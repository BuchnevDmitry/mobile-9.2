import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:realm/realm.dart';

import 'package:rentool/features/ads_feed/ads_feed.dart';
import 'package:rentool/features/auth/auth.dart';
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
  late final FlutterSecureStorage storage;
  late final ToolsApiClient _toolsApiClient;
  late final UsersApiClient _usersApiClient;
  late final AuthClient _authClient;
  late final CategoriesApiClient _categoriesApiClient;
  late final YandexGeocoder _geocoder;
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    storage = const FlutterSecureStorage();
    _toolsApiClient = ToolsApiClient.create(apiUrl: dotenv.env['API_URL']);
    _usersApiClient = UsersApiClient.create(apiUrl: dotenv.env['API_URL']);
    _authClient = AuthClient.create(apiUrl: dotenv.env['AUTH_URL']);
    _categoriesApiClient =
        CategoriesApiClient.create(apiUrl: dotenv.env['API_URL']);
    _geocoder = YandexGeocoder(apiKey: dotenv.env['GEOCODER_KEY']!);
    _router = AppRouter();
  }

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
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            storage: storage,
            usersApiClient: _usersApiClient,
            authClient: _authClient,
            clientId: dotenv.env['CLIENT_ID'],
            clientSecret: dotenv.env['CLIENT_SECRET'],
            grantType: dotenv.env['GRANT_TYPE'],
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
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(
            usersApiClient: _usersApiClient,
            storage: storage,
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
