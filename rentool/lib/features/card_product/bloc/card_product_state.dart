part of 'card_product_bloc.dart';

@immutable
sealed class CardProductState {
  const CardProductState();
}

final class CardProductInitialState extends CardProductState {}

final class CardProductLoadingState extends CardProductState {}

final class CardProductLoadedState extends CardProductState {
  const CardProductLoadedState({
    required this.tool,
    ToolFavorite? favoriteTool,
  }) : _favoriteTool = favoriteTool;

  final Tool tool;
  final ToolFavorite? _favoriteTool;

  bool isFavorite(String id) {
    if (_favoriteTool != null) {
      return _favoriteTool.id == id;
    } else {
      return false;
    }
  }

  CardProductLoadedState copyWith({
    Tool? tool,
    ToolFavorite? favoriteTool,
  }) {
    return CardProductLoadedState(
      tool: tool ?? this.tool,
      favoriteTool: favoriteTool,
    );
  }
}

final class CardProductLoadingFailureState extends CardProductState {
  const CardProductLoadingFailureState({required this.error});

  final Object? error;
}
