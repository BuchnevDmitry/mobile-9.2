import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class MapDeliveryScreen extends StatefulWidget {
  const MapDeliveryScreen({super.key});

  @override
  State<MapDeliveryScreen> createState() => _MapDeliveryScreenState();
}

class _MapDeliveryScreenState extends State<MapDeliveryScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromRadius(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    context.router.maybePop();
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Text(
                  'Точка доставки',
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      body: YandexMap(
        onMapCreated: (controller) {
          mapControllerCompleter.complete(controller);
        },
      ),
    );
  }
}