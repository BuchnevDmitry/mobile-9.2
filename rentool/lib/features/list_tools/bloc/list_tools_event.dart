part of 'list_tools_bloc.dart';

@immutable
sealed class ListToolsEvent extends Equatable {
  const ListToolsEvent();
  @override
  List<Object?> get props => [];
}

class ListToolsLoadEvent extends ListToolsEvent {
  const ListToolsLoadEvent({
    this.completer,
    this.category = '',
  });
  final String category;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([completer, category]);
}

class ListToolsToggleFavoriteToolEvent extends ListToolsEvent {
  const ListToolsToggleFavoriteToolEvent({
    required this.tool,
    this.completer,
  });

  final Tool tool;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(tool);
}
