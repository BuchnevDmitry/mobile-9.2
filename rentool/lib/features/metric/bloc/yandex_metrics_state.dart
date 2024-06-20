part of 'yandex_metrics_bloc.dart';

@immutable
sealed class YandexMetricsState extends Equatable {
  const YandexMetricsState();

  @override
  List<Object> get props => [];
}

final class YandexMetricsInitialState extends YandexMetricsState {}

final class YandexMetricsSendingState extends YandexMetricsState {}

final class YandexMetricsSendedState extends YandexMetricsState {}

final class YandexMetricsFailureState extends YandexMetricsState {
  const YandexMetricsFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
