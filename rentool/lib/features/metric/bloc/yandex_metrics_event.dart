part of 'yandex_metrics_bloc.dart';

@immutable
sealed class YandexMetricsEvent extends Equatable {
  const YandexMetricsEvent();

  @override
  List<Object?> get props => [];
}

class YandexMetricsOpenScreenEvent extends YandexMetricsEvent {
  const YandexMetricsOpenScreenEvent({
    required this.screenName,
  });

  final String screenName;

  @override
  List<Object?> get props => super.props..add(screenName);
}

class YandexMetricsViewProductScreenEvent extends YandexMetricsEvent {
  const YandexMetricsViewProductScreenEvent({
    required this.screenName,
    required this.priceDay,
    required this.category,
    required this.model,
    required this.id,
  });

  final String screenName;
  final int priceDay;
  final String category;
  final String model;
  final String id;

  @override
  List<Object?> get props => super.props
    ..addAll([
      screenName,
      priceDay,
      category,
      model,
      id,
    ]);
}

class YandexMetricsAddProductToOrderEvent extends YandexMetricsEvent {
  const YandexMetricsAddProductToOrderEvent({
    required this.screenName,
    required this.priceDay,
    required this.category,
    required this.model,
    required this.id,
    required this.quantity,
  });

  final String screenName;
  final int priceDay;
  final String category;
  final String model;
  final String id;
  final int quantity;

  @override
  List<Object?> get props => super.props
    ..addAll([
      screenName,
      priceDay,
      category,
      model,
      id,
      quantity,
    ]);
}

class YandexMetricsRemoveProductFromOrderEvent extends YandexMetricsEvent {
  const YandexMetricsRemoveProductFromOrderEvent({
    required this.screenName,
    required this.priceDay,
    required this.category,
    required this.model,
    required this.id,
    required this.quantity,
  });

  final String screenName;
  final int priceDay;
  final String category;
  final String model;
  final String id;
  final int quantity;

  @override
  List<Object?> get props => super.props
    ..addAll([
      screenName,
      priceDay,
      category,
      model,
      id,
      quantity,
    ]);
}
