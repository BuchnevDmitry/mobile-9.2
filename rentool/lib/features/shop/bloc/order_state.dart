part of 'order_bloc.dart';

@immutable
sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitialState extends OrderState {}

final class OrderLoadingState extends OrderState {}

final class OrderEmptyState extends OrderState {}

final class OrderLoadedState extends OrderState {
  const OrderLoadedState({required this.order});

  final Order order;

  @override
  List<Object> get props => super.props..add(order);
}

final class OrderLoadingFailureState extends OrderState {
  const OrderLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
