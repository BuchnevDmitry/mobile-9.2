import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rentool/rentool_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // dotenv init
  await dotenv.load(fileName: '.env');

  initializeDateFormatting('ru_RU', null)
      .then((_) => runApp(const RenToolApp()));
}
