part of 'order_bloc.dart';

@immutable
sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class OrderLoadEvent extends OrderEvent {}

final class OrderClearEvent extends OrderEvent {}

final class OrderAddEvent extends OrderEvent {
  const OrderAddEvent({
    required this.tool,
    required this.count,
  });

  final Tool tool;
  final int count;

  @override
  List<Object> get props => super.props..addAll([tool, count]);
}

final class OrderRemoveToolEvent extends OrderEvent {
  const OrderRemoveToolEvent({
    required this.tool,
  });

  final ToolOrder tool;

  @override
  List<Object> get props => super.props..add(tool);
}

final class OrderSendRentEvent extends OrderEvent {
  const OrderSendRentEvent({
    required this.startDate,
    required this.endDate,
    required this.receivingMethodId,
    required this.timeReceivingId,
    required this.address,
    required this.completer,
  });

  final String startDate;
  final String endDate;
  final int receivingMethodId;
  final int timeReceivingId;
  final String address;
  final Completer completer;

  @override
  List<Object> get props => super.props
    ..addAll([
      startDate,
      endDate,
      receivingMethodId,
      timeReceivingId,
      address,
      completer,
    ]);
}
