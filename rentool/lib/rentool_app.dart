import 'package:flutter/material.dart';
import 'package:rentool/router/router.dart';
import 'theme/theme.dart';

class RenToolApp extends StatefulWidget {
  const RenToolApp({
    super.key,
  });

  @override
  State<RenToolApp> createState() => _RenToolAppState();
}

class _RenToolAppState extends State<RenToolApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rentool',
      theme: AppTheme.lightTheme,
      routerConfig: _router.config(),
    );
  }
}
