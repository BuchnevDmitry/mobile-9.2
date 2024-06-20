import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentool/common/common.dart';
import 'package:rentool/features/map/map.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class MapPickupScreen extends StatefulWidget {
  const MapPickupScreen({super.key});

  @override
  State<MapPickupScreen> createState() => _MapPickupScreenState();
}

class _MapPickupScreenState extends State<MapPickupScreen> {
  late final YandexMapController _mapController;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapBloc>(context).add(MapLoadPickupsEvent());
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
                  'Точка самовывоза',
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<MapBloc, MapState>(
        builder: (context, state) {
          if (state is MapLoadedPickupsState) {
            final mapObjects = [_getPlacemarkObject(context, state.point)];
            return YandexMap(
              onMapCreated: (controller) async {
                _mapController = controller;
                await _mapController.moveCamera(
                  CameraUpdate.newCameraPosition(
                    const CameraPosition(
                      target: Point(
                        latitude: 51.789919,
                        longitude: 39.196772,
                      ),
                      zoom: 16,
                    ),
                  ),
                );
              },
              mapObjects: mapObjects,
            );
          }
          return YandexMap(
            onMapCreated: (controller) async {
              _mapController = controller;
            },
          );
        },
      ),
    );
  }

  PlacemarkMapObject _getPlacemarkObject(BuildContext context, MapPoint point) {
    return PlacemarkMapObject(
      mapId: MapObjectId('Пункт самовывоза $point'),
      point: Point(latitude: point.latitude, longitude: point.longitude),
      opacity: 1,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
              'assets/icons/Yandex_Maps_icon_min.png'))),
      onTap: (_, __) => showModalBottomSheet(
        context: context,
        builder: (context) => ModalBodyView(
          point: point,
          receivingMethod: ReceivingMethods.selfPickup.value,
          buttonText: 'Заберу здесь',
          mainText: 'Пункт самовывоза',
        ),
      ),
    );
  }
}
