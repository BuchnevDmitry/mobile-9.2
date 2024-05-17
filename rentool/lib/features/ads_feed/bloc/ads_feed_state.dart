// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ads_feed_bloc.dart';

@immutable
sealed class AdsFeedState extends Equatable {
  const AdsFeedState();

  @override
  List<Object> get props => [];
}

final class AdsFeedInitialState extends AdsFeedState {}

final class AdsFeedLoadingState extends AdsFeedState {}

final class AdsFeedLoadedState extends AdsFeedState {
  const AdsFeedLoadedState({
    required this.tools,
    required List<ToolFavorite> favorites,
  }) : _favorites = favorites;

  final Tools tools;
  final List<ToolFavorite> _favorites;

  bool isFavorite(String id) {
    return _favorites.where((e) => e.id == id).isNotEmpty;
  }

  AdsFeedLoadedState copyWith({
    Tools? tools,
    List<ToolFavorite>? favorites,
  }) {
    return AdsFeedLoadedState(
      tools: tools ?? this.tools,
      favorites: favorites ?? _favorites,
    );
  }

  @override
  List<Object> get props =>
      super.props..addAll([tools.tools.hashCode, _favorites.hashCode]);
}

final class AdsFeedLoadingFailureState extends AdsFeedState {
  const AdsFeedLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
