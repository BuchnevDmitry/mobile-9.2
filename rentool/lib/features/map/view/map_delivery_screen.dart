import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/map/map.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class MapDeliveryScreen extends StatefulWidget {
  const MapDeliveryScreen({super.key});

  @override
  State<MapDeliveryScreen> createState() => _MapDeliveryScreenState();
}

class _MapDeliveryScreenState extends State<MapDeliveryScreen> {
  final _mapControllerCompleter = Completer<YandexMapController>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapBloc>(context).add(MapLoadDeliveryEvent());
  }

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
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoadedDeliveryState) {
            _moveToCurrentLocation(state.point);
            final mapObjects = [_getPlacemarkObject(context, state.point)];
            return YandexMap(
              onMapCreated: (controller) {
                _mapControllerCompleter.complete(controller);
              },
              onMapTap: (point) async {
                final mapBloc = BlocProvider.of<MapBloc>(context);
                final completer = Completer();

                mapBloc.add(MapUpdatePointEvent(
                  point: MapPoint(
                      address: 'Неизвестный адресс',
                      latitude: point.latitude,
                      longitude: point.longitude),
                  completer: completer,
                ));

                await completer.future;

                showModalBottomSheet(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) => ModalBodyView(
                    point: state.point,
                    mainText: 'Укажите адрес доставки',
                    buttonText: 'Сохранить адрес',
                    receivingMethod: ReceivingMethods.delivery.value,
                  ),
                );
              },
              mapObjects: mapObjects,
            );
          }
          return YandexMap(
            onMapCreated: (controller) {
              _mapControllerCompleter.complete(controller);
            },
          );
        },
      ),
    );
  }

  Future<void> _moveToCurrentLocation(
    MapPoint mapPoint,
  ) async {
    (await _mapControllerCompleter.future).moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: mapPoint.latitude,
            longitude: mapPoint.longitude,
          ),
          zoom: 16,
        ),
      ),
      animation: const MapAnimation(
        type: MapAnimationType.linear,
        duration: 1,
      ),
    );
  }

  PlacemarkMapObject _getPlacemarkObject(BuildContext context, MapPoint point) {
    return PlacemarkMapObject(
      mapId: MapObjectId('Пункт доставки $point'),
      point: Point(latitude: point.latitude, longitude: point.longitude),
      opacity: 1,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
              'assets/icons/Yandex_Maps_icon_min.png'))),
      onTap: (_, __) => (),
    );
  }
}
