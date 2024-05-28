import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/repositories/repositories.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required FavoriteRepositoryInterface repository})
      : _repository = repository,
        super(FavoritesInitialState()) {
    on<FavoritesLoadEvent>(_onLoad);
    on<ToggleFavoriteToolEvent>(_onToggleFavorite);
    on<FavoritesClearEvent>(_onClear);
  }

  final FavoriteRepositoryInterface _repository;

  FutureOr<void> _onClear(
    FavoritesClearEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _repository.clearFavorites();
    } catch (error) {
      emit(FavoritesLoadingFailureState(error: error));
    }
  }

  FutureOr<void> _onLoad(
    FavoritesLoadEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      emit(FavoritesLoadingState());

      final List<Tool> tools = [];

      _repository.getFavorites().tools.forEach((element) {
        tools.add(element.toTool());
      });

      if (tools.isNotEmpty) {
        emit(FavoritesLoadedState(favorites: tools));
      }
    } catch (error) {
      emit(FavoritesLoadingFailureState(error: error));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteToolEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      if (state is FavoritesLoadedState) {
        await _repository.createOrDeleteTool(event.tool.toToolFavorite());
        final List<Tool> tools = [];

        _repository.getFavorites().tools.forEach((element) {
          tools.add(element.toTool());
        });
        emit((state as FavoritesLoadedState).copyWith(favorites: tools));
      }
    } catch (error) {
      emit(FavoritesLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
