// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'list_tools_bloc.dart';

@immutable
sealed class ListToolsState extends Equatable {
  const ListToolsState();

  @override
  List<Object> get props => [];
}

final class ListToolsInitialState extends ListToolsState {}

final class ListToolsLoadingState extends ListToolsState {}

final class ListToolsLoadedState extends ListToolsState {
  const ListToolsLoadedState({
    required this.tools,
    required List<ToolFavorite> favorites,
  }) : _favorites = favorites;

  final Tools tools;
  final List<ToolFavorite> _favorites;

  bool isFavorite(String id) {
    return _favorites.where((e) => e.id == id).isNotEmpty;
  }

  ListToolsLoadedState copyWith({
    Tools? tools,
    List<ToolFavorite>? favorites,
  }) {
    return ListToolsLoadedState(
      tools: tools ?? this.tools,
      favorites: favorites ?? _favorites,
    );
  }

  @override
  List<Object> get props =>
      super.props..addAll([tools.hashCode, _favorites.hashCode]);
}

final class ListToolsLoadingFailureState extends ListToolsState {
  const ListToolsLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
