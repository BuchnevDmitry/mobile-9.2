part of 'history_orders_bloc.dart';

@immutable
sealed class HistoryOrdersEvent extends Equatable {
  const HistoryOrdersEvent();

  @override
  List<Object?> get props => [];
}

class HistoryOrdersLoadEvent extends HistoryOrdersEvent {
  const HistoryOrdersLoadEvent({
    this.completer,
  });
  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}
