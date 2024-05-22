import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/repositories/repositories.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required OrderRepositoryInterface orderRepository})
      : _orderRepository = orderRepository,
        super(OrderInitialState()) {
    on<OrderLoadEvent>(_onLoad);
    on<OrderClearEvent>(_clearOrder);
    on<OrderAddEvent>(_addToOrder);
    on<OrderRemoveToolEvent>(_removeFromOrder);
  }

  final OrderRepositoryInterface _orderRepository;
  FutureOr<void> _onLoad(
    OrderLoadEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderLoadingState());
      final order = _orderRepository.getOrder();
      order.tools.isEmpty
          ? emit(OrderEmptyState())
          : emit(OrderLoadedState(order: order));
    } catch (error) {
      emit(OrderLoadingFailureState(error: error));
    }
  }

  FutureOr<void> _clearOrder(
    OrderClearEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      await _orderRepository.clearOrder();
      add(OrderLoadEvent());
    } catch (error) {
      log(error.toString());
    }
  }

  FutureOr<void> _addToOrder(
    OrderAddEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderLoadingState());
      await _orderRepository.addToOrder(event.tool.toToolOrder(event.count));
      add(OrderLoadEvent());
    } catch (error) {
      log(error.toString());
    }
  }

  FutureOr<void> _removeFromOrder(
    OrderRemoveToolEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      await _orderRepository.removeFromOrder(event.tool);
      add(OrderLoadEvent());
    } catch (error) {
      log(error.toString());
    }
  }
}
