part of 'active_orders_bloc.dart';

@immutable
sealed class ActiveOrdersEvent extends Equatable {
  const ActiveOrdersEvent();

  @override
  List<Object?> get props => [];
}

class ActiveOrdersLoadEvent extends ActiveOrdersEvent {
  const ActiveOrdersLoadEvent({
    this.completer,
  });
  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}

class ActiveOrdersCancelEvent extends ActiveOrdersEvent {
  const ActiveOrdersCancelEvent({
    this.completer,
    required this.id,
  });

  final String id;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([completer, id]);
}

class ActiveOrdersReturnEvent extends ActiveOrdersEvent {
  const ActiveOrdersReturnEvent({
    this.completer,
    required this.id,
  });

  final String id;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([completer, id]);
}
