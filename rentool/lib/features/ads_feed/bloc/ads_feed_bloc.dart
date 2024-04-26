import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'ads_feed_event.dart';
part 'ads_feed_state.dart';

class AdsFeedBloc extends Bloc<AdsFeedEvent, AdsFeedState> {
  AdsFeedBloc({required this.toolApiClient}) : super(AdsFeedInitialState()) {
    on<AdsFeedLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    AdsFeedLoadEvent event,
    Emitter<AdsFeedState> emit,
  ) async {
    try {
      if (state is! AdsFeedLoadedState) {
        emit(AdsFeedLoadingState());
      }
      final tools = await toolApiClient.getTools();
      emit(AdsFeedLoadedState(tools: tools));
    } catch (error) {
      emit(AdsFeedLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  final ToolsApiClient toolApiClient;
}
