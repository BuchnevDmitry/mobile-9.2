import 'package:equatable/equatable.dart';
import 'package:rentool/repositories/repositories.dart';

class MapPoint extends Equatable {
  const MapPoint({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  /// Адресс
  final String address;

  /// Широта
  final double latitude;

  /// Долгота
  final double longitude;

  @override
  List<Object?> get props => [address, latitude, longitude];

  OrderAddress toOrderAddress(int type) => OrderAddress(
        '0',
        type,
        address,
      );
}
