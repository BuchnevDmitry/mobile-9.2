import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rentool/rentool_app.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:realm/realm.dart';
import 'package:rentool/repositories/repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // dotenv init
  await dotenv.load(fileName: '.env');

  final realmConfig = Configuration.local([
    Order.schema,
    ToolOrder.schema,
    BrandOrder.schema,
    CategoryOrder.schema,
    Favorites.schema,
    ToolFavorite.schema,
    BrandFavorite.schema,
    CategoryFavorite.schema,
    OrderAddress.schema,
  ]);
  final realm = Realm(realmConfig);

  AppMetrica.activate(
      AppMetricaConfig(dotenv.env['APP_METRIC_KEY'].toString(), logs: true));

  initializeDateFormatting('ru_RU', null).then((_) => runApp(RenToolApp(
        realm: realm,
      )));
}
