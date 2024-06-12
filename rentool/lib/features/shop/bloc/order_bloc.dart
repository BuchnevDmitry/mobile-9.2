import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/repositories/repositories.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({
    required RentsApiClient rentsApiClient,
    required OrderRepositoryInterface orderRepository,
    required FlutterSecureStorage storage,
  })  : _orderRepository = orderRepository,
        _rentsApiClient = rentsApiClient,
        _storage = storage,
        super(OrderInitialState()) {
    on<OrderLoadEvent>(_onLoad);
    on<OrderClearEvent>(_clearOrder);
    on<OrderAddEvent>(_addToOrder);
    on<OrderRemoveToolEvent>(_removeFromOrder);
    on<OrderSendRentEvent>(_rent);
  }

  final OrderRepositoryInterface _orderRepository;
  final RentsApiClient _rentsApiClient;
  final FlutterSecureStorage _storage;

  FutureOr<void> _rent(
    OrderSendRentEvent event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderLoadingState());
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        final tools = _orderRepository.getOrder();
        List<RentTool> rentTools = [];
        for (var tool in tools.tools) {
          rentTools.add(RentTool(toolId: tool.id, countTool: tool.userCount));
        }

        final order = OrderModel(
          startDate: event.startDate,
          endDate: event.endDate,
          price: event.price,
          timeReceivingId: event.timeReceivingId,
          receivingMethodId: event.receivingMethodId,
          address: event.address,
          tools: rentTools,
        );
        await _rentsApiClient.addRent('Bearer $accessToken', order);
        add(OrderClearEvent());
      }
    } catch (error) {
      emit(OrderLoadingFailureState(error: error));
    }
  }

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
