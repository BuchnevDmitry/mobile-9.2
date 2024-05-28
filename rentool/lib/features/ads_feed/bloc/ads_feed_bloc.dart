import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/repositories/repositories.dart';

part 'ads_feed_event.dart';
part 'ads_feed_state.dart';

class AdsFeedBloc extends Bloc<AdsFeedEvent, AdsFeedState> {
  AdsFeedBloc({
    required ToolsApiClient toolApiClient,
    required FavoriteRepositoryInterface repository,
  })  : _toolApiClient = toolApiClient,
        _repository = repository,
        super(AdsFeedInitialState()) {
    on<AdsFeedLoadEvent>(_onLoad);
    on<AdsFeedToggleFavoriteToolEvent>(_onToggleFavorite);
  }

  final ToolsApiClient _toolApiClient;
  final FavoriteRepositoryInterface _repository;

  Future<void> _onLoad(
    AdsFeedLoadEvent event,
    Emitter<AdsFeedState> emit,
  ) async {
    try {
      if (state is! AdsFeedLoadedState) {
        emit(AdsFeedLoadingState());
      }
      final tools = await _toolApiClient.getTools();
      final favorites = _repository.getFavorites();
      emit(AdsFeedLoadedState(
        tools: tools,
        favorites: favorites.tools,
      ));
    } catch (error) {
      emit(AdsFeedLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onToggleFavorite(
    AdsFeedToggleFavoriteToolEvent event,
    Emitter<AdsFeedState> emit,
  ) async {
    try {
      if (state is AdsFeedLoadedState) {
        await _repository.createOrDeleteTool(event.tool.toToolFavorite());
        final favorites = _repository.getFavorites();
        emit(
            (state as AdsFeedLoadedState).copyWith(favorites: favorites.tools));
      }
    } catch (error) {
      emit(AdsFeedLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
