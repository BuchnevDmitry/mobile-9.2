import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'list_tools_event.dart';
part 'list_tools_state.dart';

class ListToolsBloc extends Bloc<ListToolsEvent, ListToolsState> {
  ListToolsBloc({required this.toolsApiClient})
      : super(ListToolsInitialState()) {
    on<ListToolsLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    ListToolsLoadEvent event,
    Emitter<ListToolsState> emit,
  ) async {
    try {
      if (state is! ListToolsLoadedState) {
        emit(ListToolsLoadingState());
      }
      final tools = await toolsApiClient.getTools();
      emit(ListToolsLoadedState(tools: tools));
    } catch (error) {
      emit(ListToolsLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  final ToolsApiClient toolsApiClient;
}
