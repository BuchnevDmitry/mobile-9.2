import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'order_list_event.dart';
part 'order_list_state.dart';

class OrderListBloc extends Bloc<OrderListEvent, OrderListState> {
  OrderListBloc({required ToolsApiClient toolsApiClient})
      : _toolsApiClient = toolsApiClient,
        super(OrderListInitialState()) {
    on<OrderListLoadEvent>(_onLoad);
  }

  final ToolsApiClient _toolsApiClient;

  FutureOr<void> _onLoad(
    OrderListLoadEvent event,
    Emitter<OrderListState> emit,
  ) async {
    try {
      emit(OrderListLoadingState());
      List<Tool> tools = [];
      for (var rentTool in event.rent.tools) {
        final tool = await _toolsApiClient.getToolById(rentTool.toolId);
        tools.add(tool);
      }
      emit(OrderListLoadedState(tools: tools, rentTools: event.rent.tools));
    } catch (error) {
      emit(OrderListLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
