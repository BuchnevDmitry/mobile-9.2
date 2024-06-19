import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';

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
    on<ActiveOrdersExtendEvent>(_onExtend);
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
      List<Rent> filtered = [];

      if (accessToken != null) {
        int page = 0;
        int size = 10;

        while (size == 10) {
          final rents =
              await _rentsApiClient.getRents('Bearer $accessToken', page: page);
          size = rents.size;

          for (var rent in rents.rents) {
            if (rent.status.id == Statuses.completed.value ||
                rent.status.id == Statuses.canceled.value) continue;
            filtered.add(rent);
          }
          page += 1;
        }
      }
      emit(ActiveOrdersLoadedState(rents: filtered));
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

  FutureOr<void> _onExtend(
    ActiveOrdersExtendEvent event,
    Emitter<ActiveOrdersState> emit,
  ) async {
    try {
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        final extend = Extend(endDate: event.endDate);
        await _rentsApiClient.extendRent(
          event.id,
          'Bearer $accessToken',
          extend,
        );
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
