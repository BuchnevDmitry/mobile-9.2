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
              onMapLongTap: (point) async {
                BlocProvider.of<MapBloc>(context).add(MapUpdatePointEvent(
                    point: MapPoint(
                        address: 'Неизвестный адресс',
                        latitude: point.latitude,
                        longitude: point.longitude)));
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
      onTap: (_, __) => showModalBottomSheet(
        context: context,
        builder: (context) => _ModalBodyView(point: point),
      ),
    );
  }
}

class _ModalBodyView extends StatefulWidget {
  const _ModalBodyView({required this.point});

  final MapPoint point;

  @override
  State<_ModalBodyView> createState() => _ModalBodyViewState();
}

class _ModalBodyViewState extends State<_ModalBodyView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    'Укажите адрес доставки',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text(
                    'Адрес',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xfffaaaaaa),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    widget.point.address,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ButtonPrimary(
                onPressed: _onPressed,
                text: 'Сохранить адрес',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPressed() async {
    final rout = context.router;
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final completer = Completer();

    mapBloc.add(MapAddAddressEvent(
      point: widget.point,
      type: 1,
      completer: completer,
    ));
    await completer.future;

    mapBloc.add(MapLoadAddressEvent());

    await rout.maybePop();
    await rout.maybePop();
  }
}
