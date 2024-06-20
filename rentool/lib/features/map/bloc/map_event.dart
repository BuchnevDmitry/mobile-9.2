part of 'map_bloc.dart';

@immutable
sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

final class MapLoadDeliveryEvent extends MapEvent {}

final class MapLoadAddressEvent extends MapEvent {}

final class MapLoadPickupsEvent extends MapEvent {}

final class MapUpdatePointEvent extends MapEvent {
  const MapUpdatePointEvent({
    required this.point,
    this.completer,
  });

  final MapPoint point;
  final Completer? completer;

  @override
  List<Object?> get props => super.props
    ..addAll([
      point,
      completer,
    ]);
}

final class MapAddAddressEvent extends MapEvent {
  const MapAddAddressEvent({
    required this.point,
    required this.type,
    this.completer,
  });

  final MapPoint point;
  final int type;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([point, type, completer]);
}
