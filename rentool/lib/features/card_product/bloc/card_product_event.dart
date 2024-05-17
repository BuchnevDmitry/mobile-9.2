part of 'card_product_bloc.dart';

@immutable
sealed class CardProductEvent extends Equatable {
  const CardProductEvent();

  @override
  List<Object?> get props => [];
}

class CardProductLoadEvent extends CardProductEvent {
  const CardProductLoadEvent({
    required this.tool,
    this.completer,
  });

  final Tool tool;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}

class CardProductToggleFavoriteToolEvent extends CardProductEvent {
  const CardProductToggleFavoriteToolEvent({
    required this.tool,
    this.completer,
  });

  final Tool tool;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([tool, completer]);
}
