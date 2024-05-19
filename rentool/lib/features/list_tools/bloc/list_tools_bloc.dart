import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/repositories/repositories.dart';

part 'list_tools_event.dart';
part 'list_tools_state.dart';

class ListToolsBloc extends Bloc<ListToolsEvent, ListToolsState> {
  ListToolsBloc(
      {required ToolsApiClient toolsApiClient,
      required FavoriteRepositoryInterface repository})
      : _repository = repository,
        _toolsApiClient = toolsApiClient,
        super(ListToolsInitialState()) {
    on<ListToolsLoadEvent>(_onLoad);
    on<ListToolsToggleFavoriteToolEvent>(_onToggleFavorite);
  }

  final ToolsApiClient _toolsApiClient;
  final FavoriteRepositoryInterface _repository;

  Future<void> _onLoad(
    ListToolsLoadEvent event,
    Emitter<ListToolsState> emit,
  ) async {
    try {
      if (state is! ListToolsLoadedState) {
        emit(ListToolsLoadingState());
      }
      final tools = await _toolsApiClient.getTools();
      final favorites = _repository.getFavorites();

      emit(ListToolsLoadedState(tools: tools, favorites: favorites.tools));
    } catch (error) {
      emit(ListToolsLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onToggleFavorite(
    ListToolsToggleFavoriteToolEvent event,
    Emitter<ListToolsState> emit,
  ) async {
    try {
      if (state is ListToolsLoadedState) {
        await _repository.createOrDeleteTool(event.tool.toToolFavorite());
        final favorites = _repository.getFavorites();
        emit((state as ListToolsLoadedState)
            .copyWith(favorites: favorites.tools));
      }
    } catch (error) {
      emit(ListToolsLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
