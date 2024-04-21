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
  const ListToolsLoadedState({required this.tools});

  final Tools tools;

  @override
  List<Object> get props => super.props..add(tools);
}

final class ListToolsLoadingFailureState extends ListToolsState {
  const ListToolsLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
