import 'package:flutter/material.dart';

class RenToolApp extends StatelessWidget {
  const RenToolApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentool',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Montserrat',
        primaryColor: const Color(0xfff7c815),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xfff7c815)),
      ),
      home: const Placeholder(),
    );
  }
}
