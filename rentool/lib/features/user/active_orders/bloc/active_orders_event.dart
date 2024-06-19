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

class ActiveOrdersExtendEvent extends ActiveOrdersEvent {
  const ActiveOrdersExtendEvent({
    this.completer,
    required this.id,
    required this.endDate,
  });

  final String id;
  final String endDate;
  final Completer? completer;

  @override
  List<Object?> get props => super.props
    ..addAll([
      completer,
      id,
      endDate,
    ]);
}
