part of 'favorite_bloc.dart';

@immutable
sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitialState extends FavoritesState {}

final class FavoritesLoadingState extends FavoritesState {}

final class FavoritesEmptyState extends FavoritesState {}

final class FavoritesLoadedState extends FavoritesState {
  const FavoritesLoadedState({required this.favorites});

  final List<Tool> favorites;

  FavoritesLoadedState copyWith({
    List<Tool>? favorites,
  }) {
    return FavoritesLoadedState(
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object> get props => super.props..add(favorites.hashCode);
}

final class FavoritesLoadingFailureState extends FavoritesState {
  const FavoritesLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
