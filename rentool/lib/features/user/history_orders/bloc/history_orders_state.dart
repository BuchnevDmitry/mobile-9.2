part of 'history_orders_bloc.dart';

@immutable
sealed class HistoryOrdersState extends Equatable {
  const HistoryOrdersState();

  @override
  List<Object> get props => [];
}

final class HistoryOrdersInitialState extends HistoryOrdersState {}

final class HistoryOrdersLoadingState extends HistoryOrdersState {}

final class HistoryOrdersLoadedState extends HistoryOrdersState {
  const HistoryOrdersLoadedState({required this.rents});

  final List<Rent> rents;

  @override
  List<Object> get props => super.props..add(rents);
}

final class HistoryOrdersLoadingFailureState extends HistoryOrdersState {
  const HistoryOrdersLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
