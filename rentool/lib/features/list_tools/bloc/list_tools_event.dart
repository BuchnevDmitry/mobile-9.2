part of 'list_tools_bloc.dart';

@immutable
sealed class ListToolsEvent extends Equatable {
  const ListToolsEvent();
  @override
  List<Object> get props => [];
}

class ListToolsLoadEvent extends ListToolsEvent {
  const ListToolsLoadEvent({
    this.completer,
  });
  final Completer? completer;
}
