part of 'active_orders_bloc.dart';

@immutable
sealed class ActiveOrdersState extends Equatable {
  const ActiveOrdersState();

  @override
  List<Object> get props => [];
}

final class ActiveOrdersInitialState extends ActiveOrdersState {}

final class ActiveOrdersLoadingState extends ActiveOrdersState {}

final class ActiveOrdersLoadedState extends ActiveOrdersState {
  const ActiveOrdersLoadedState({required this.rents});

  final List<Rent> rents;

  @override
  List<Object> get props => super.props..add(rents);
}

final class ActiveOrdersLoadingFailureState extends ActiveOrdersState {
  const ActiveOrdersLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
