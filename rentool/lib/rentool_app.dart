import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rentool/features/ads_feed/bloc/ads_feed_bloc.dart';
import 'package:rentool/features/catalog/bloc/catalog_bloc.dart';
import 'package:rentool/features/list_tools/bloc/list_tools_bloc.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/router/router.dart';
import 'package:rentool/theme/theme.dart';

class RenToolApp extends StatefulWidget {
  const RenToolApp({
    super.key,
  });

  @override
  State<RenToolApp> createState() => _RenToolAppState();
}

class _RenToolAppState extends State<RenToolApp> {
  final _router = AppRouter();
  final _toolsApiClient = ToolsApiClient.create(apiUrl: dotenv.env['API_URL']);
  final _categoriesApiClient =
      CategoriesApiClient.create(apiUrl: dotenv.env['API_URL']);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdsFeedBloc>(
          create: (context) => AdsFeedBloc(
            toolApiClient: _toolsApiClient,
          ),
        ),
        BlocProvider<CatalogBloc>(
          create: (context) => CatalogBloc(
            categoriesApiClient: _categoriesApiClient,
          ),
        ),
        BlocProvider<ListToolsBloc>(
          create: (context) => ListToolsBloc(
            toolsApiClient: _toolsApiClient,
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Rentool',
        theme: AppTheme.lightTheme,
        routerDelegate: _router.delegate(),
        routeInformationParser: _router.defaultRouteParser(),
      ),
    );
  }
}
