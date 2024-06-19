import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rentool/features/map/map.dart';
import 'package:rentool/features/map/models/models.dart';
import 'package:rentool/repositories/repositories.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc(
      {required YandexGeocoder geocoder,
      required OrderAddressRepository repository})
      : _geocoder = geocoder,
        _repository = repository,
        super(MapInitialState()) {
    on<MapLoadDeliveryEvent>(_onLoadDelivery);
    on<MapLoadPickupsEvent>(_onLoadPickups);
    on<MapUpdatePointEvent>(_onUpdatePoint);
    on<MapAddAddressEvent>(_onAddAddressPoint);
    on<MapLoadAddressEvent>(_onLoadAddress);
  }

  final YandexGeocoder _geocoder;
  final OrderAddressRepository _repository;

  final _defLocation = const MapPoint(
    address: 'Плехановская улица',
    latitude: 51.657245,
    longitude: 39.205037,
  );

  final _pickupLocation = const MapPoint(
    address: 'улица Московское шоссе, 135',
    latitude: 51.789919,
    longitude: 39.196772,
  );

  Future<void> _onLoadAddress(
    MapLoadAddressEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      if (state is! MapLoadedPickupsState || state is! MapLoadedDeliveryState) {
        emit(MapAddressEmptyState());
      }
      final address = _repository.getOrderAddress();
      emit(MapLoadedAddressState(orderAdress: address!));
    } catch (error) {
      emit(MapLoadingFailureState(error: error));
    }
  }

  Future<void> _onLoadPickups(
    MapLoadPickupsEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      if (state is! MapLoadedPickupsState) {
        emit(MapLoadingPickupsState());
      }
      emit(MapLoadedPickupsState(point: _pickupLocation));
    } catch (error) {
      emit(MapLoadingFailureState(error: error));
    }
  }

  Future<void> _onLoadDelivery(
    MapLoadDeliveryEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      if (state is! MapLoadedDeliveryState) {
        emit(MapLoadingDeliveryState());
        _initPermission().ignore();
      }
      MapPoint point = await fetchCurrentLocation();
      emit(MapLoadedDeliveryState(point: point));
    } catch (error) {
      emit(MapLoadingFailureState(error: error));
    }
  }

  Future<void> _onUpdatePoint(
    MapUpdatePointEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      if (state is MapLoadedDeliveryState) {
        final address = await _getAddressFromMapPoint(event.point);
        final point = MapPoint(
            address: address,
            latitude: event.point.latitude,
            longitude: event.point.longitude);
        emit((state as MapLoadedDeliveryState).copyWith(point: point));
      }
    } catch (error) {
      emit(MapLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onAddAddressPoint(
    MapAddAddressEvent event,
    Emitter<MapState> emit,
  ) async {
    try {
      if (state is MapLoadedPickupsState || state is MapLoadedDeliveryState) {
        await _repository.createOrReplaceOrderAddress(
            event.point.toOrderAddress(event.type));
        log('${_repository.getOrderAddress()}');
      }
    } catch (error) {
      emit(MapLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  Future<MapPoint> fetchCurrentLocation() async {
    MapPoint location;
    try {
      location = await _getCurrentLocation();
    } catch (_) {
      location = _defLocation;
    }
    return location;
  }

  Future<bool> _checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  Future<void> _initPermission() async {
    if (!await _checkPermission()) {
      await _requestPermission();
    }
    await fetchCurrentLocation();
  }

  Future<MapPoint> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      final address = await _getAddress(position);
      return MapPoint(
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (_) {
      return _defLocation;
    }
  }

  Future<bool> _requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  Future<String> _getAddress(Position point) async {
    String text;
    final GeocodeResponse address =
        await _geocoder.getGeocode(ReverseGeocodeRequest(
      pointGeocode: (lat: point.latitude, lon: point.longitude),
    ));
    text = address.firstAddress?.formatted ?? 'Неизвестный адрес';
    return text;
  }

  Future<String> _getAddressFromMapPoint(MapPoint point) async {
    String text;
    final GeocodeResponse address =
        await _geocoder.getGeocode(ReverseGeocodeRequest(
      pointGeocode: (lat: point.latitude, lon: point.longitude),
    ));
    text = address.firstAddress?.formatted ?? 'Неизвестный адрес';
    return text;
  }
}
