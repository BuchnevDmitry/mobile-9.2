part of 'order_list_bloc.dart';

@immutable
sealed class OrderListState extends Equatable {
  const OrderListState();

  @override
  List<Object> get props => [];
}

final class OrderListInitialState extends OrderListState {}

final class OrderListLoadingState extends OrderListState {}

final class OrderListLoadedState extends OrderListState {
  const OrderListLoadedState({required this.tools, required this.rentTools});

  final Tools tools;
  final List<RentTool> rentTools;

  @override
  List<Object> get props => super.props..addAll([tools, rentTools]);
}

final class OrderListLoadingFailureState extends OrderListState {
  const OrderListLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
