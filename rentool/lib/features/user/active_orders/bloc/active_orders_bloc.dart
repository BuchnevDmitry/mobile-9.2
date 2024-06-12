import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'active_orders_event.dart';
part 'active_orders_state.dart';

class ActiveOrdersBloc extends Bloc<ActiveOrdersEvent, ActiveOrdersState> {
  ActiveOrdersBloc({
    required RentsApiClient rentsApiClient,
    required FlutterSecureStorage storage,
  })  : _storage = storage,
        _rentsApiClient = rentsApiClient,
        super(ActiveOrdersInitialState()) {
    on<ActiveOrdersLoadEvent>(_onLoad);
    on<ActiveOrdersReturnEvent>(_onReturn);
    on<ActiveOrdersCancelEvent>(_onCancel);
  }

  final RentsApiClient _rentsApiClient;
  final FlutterSecureStorage _storage;

  FutureOr<void> _onLoad(
    ActiveOrdersLoadEvent event,
    Emitter<ActiveOrdersState> emit,
  ) async {
    try {
      emit(ActiveOrdersLoadingState());
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        final rents = await _rentsApiClient.getRents('Bearer $accessToken');
        List<Rent> filtered = [];

        for (var rent in rents.rents) {
          if (rent.status.id == 4 || rent.status.id == 5) continue;
          filtered.add(rent);
        }
        emit(ActiveOrdersLoadedState(rents: filtered));
      }
    } catch (error) {
      emit(ActiveOrdersLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  FutureOr<void> _onReturn(
    ActiveOrdersReturnEvent event,
    Emitter<ActiveOrdersState> emit,
  ) async {
    try {
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        await _rentsApiClient.returnRent(event.id, 'Bearer $accessToken');
      }
      add(const ActiveOrdersLoadEvent());
    } catch (error) {
      emit(ActiveOrdersLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  FutureOr<void> _onCancel(
    ActiveOrdersCancelEvent event,
    Emitter<ActiveOrdersState> emit,
  ) async {
    try {
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        await _rentsApiClient.cancelRent(event.id, 'Bearer $accessToken');
      }
      add(const ActiveOrdersLoadEvent());
    } catch (error) {
      emit(ActiveOrdersLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
