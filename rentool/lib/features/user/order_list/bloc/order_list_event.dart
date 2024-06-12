part of 'order_list_bloc.dart';

@immutable
sealed class OrderListEvent extends Equatable {
  const OrderListEvent();

  @override
  List<Object?> get props => [];
}

class OrderListLoadEvent extends OrderListEvent {
  const OrderListLoadEvent({
    this.completer,
    required this.rent,
  });

  final Rent rent;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([completer, rent]);
}
