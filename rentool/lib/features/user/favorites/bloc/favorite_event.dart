part of 'favorite_bloc.dart';

@immutable
sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

final class FavoritesLoadEvent extends FavoritesEvent {}

class ToggleFavoriteToolEvent extends FavoritesEvent {
  const ToggleFavoriteToolEvent({
    required this.tool,
    this.completer,
  });

  final Tool tool;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([tool, completer]);
}
