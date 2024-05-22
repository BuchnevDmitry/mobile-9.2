part of 'map_bloc.dart';

@immutable
sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitialState extends MapState {}

final class MapLoadingDeliveryState extends MapState {}

final class MapLoadedDeliveryState extends MapState {
  const MapLoadedDeliveryState({
    required this.point,
  });

  final MapPoint point;

  MapLoadedDeliveryState copyWith({
    MapPoint? point,
  }) {
    return MapLoadedDeliveryState(
      point: point ?? this.point,
    );
  }

  @override
  List<Object> get props => super.props..add(point);
}

final class MapLoadingPickupsState extends MapState {}

final class MapLoadedPickupsState extends MapState {
  const MapLoadedPickupsState({
    required this.point,
  });

  final MapPoint point;

  MapLoadedPickupsState copyWith({
    MapPoint? point,
  }) {
    return MapLoadedPickupsState(
      point: point ?? this.point,
    );
  }

  @override
  List<Object> get props => super.props..add(point);
}

final class MapLoadedAddressState extends MapState {
  const MapLoadedAddressState({
    required this.orderAdress,
  });

  final OrderAddress orderAdress;

  MapLoadedAddressState copyWith({
    OrderAddress? orderAdress,
  }) {
    return MapLoadedAddressState(
      orderAdress: orderAdress ?? this.orderAdress,
    );
  }
}

final class MapAddressEmptyState extends MapState {}

final class MapLoadingFailureState extends MapState {
  const MapLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
