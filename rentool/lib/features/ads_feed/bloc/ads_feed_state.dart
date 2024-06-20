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
    required this.advertisings,
    required this.hasMore,
    required List<ToolFavorite> favorites,
  }) : _favorites = favorites;

  final Tools tools;
  final bool hasMore;
  final List<Advertising> advertisings;
  final List<ToolFavorite> _favorites;

  bool isFavorite(String id) {
    return _favorites.where((e) => e.id == id).isNotEmpty;
  }

  AdsFeedLoadedState copyWith({
    Tools? tools,
    bool? hasMore,
    List<Advertising>? advertisings,
    List<ToolFavorite>? favorites,
  }) {
    return AdsFeedLoadedState(
      tools: tools ?? this.tools,
      hasMore: hasMore ?? this.hasMore,
      advertisings: advertisings ?? this.advertisings,
      favorites: favorites ?? _favorites,
    );
  }

  @override
  List<Object> get props => super.props
    ..addAll([
      tools.tools.hashCode,
      _favorites.hashCode,
      advertisings.hashCode,
    ]);
}

final class AdsFeedLoadingFailureState extends AdsFeedState {
  const AdsFeedLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
