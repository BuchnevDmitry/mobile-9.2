import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/repositories/repositories.dart';

part 'card_product_event.dart';
part 'card_product_state.dart';

class CardProductBloc extends Bloc<CardProductEvent, CardProductState> {
  CardProductBloc({required FavoriteRepositoryInterface repository})
      : _repository = repository,
        super(CardProductInitialState()) {
    on<CardProductLoadEvent>(_onLoad);
    on<CardProductToggleFavoriteToolEvent>(_onToggleFavorite);
  }

  final FavoriteRepositoryInterface _repository;

  FutureOr<void> _onLoad(
    CardProductLoadEvent event,
    Emitter emit,
  ) async {
    try {
      if (state is! CardProductLoadedState) {
        emit(CardProductLoadingState());
      }
      final favoriteTool = _repository
          .getFavorites()
          .tools
          .where((e) => e.id == event.tool.id)
          .firstOrNull;

      emit(CardProductLoadedState(
        tool: event.tool,
        favoriteTool: favoriteTool,
      ));
    } catch (error) {
      emit(CardProductLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onToggleFavorite(
    CardProductToggleFavoriteToolEvent event,
    Emitter<CardProductState> emit,
  ) async {
    try {
      if (state is CardProductLoadedState) {
        await _repository.createOrDeleteTool(event.tool.toToolFavorite());

        final favoriteTool = _repository
            .getFavorites()
            .tools
            .where((e) => e.id == event.tool.id)
            .firstOrNull;
        final prevState = (state as CardProductLoadedState)
            .copyWith(favoriteTool: favoriteTool);
        emit(prevState);
      }
    } catch (error) {
      emit(CardProductLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
