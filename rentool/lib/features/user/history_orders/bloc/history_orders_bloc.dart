import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';
import 'package:rentool/common/common.dart';

part 'history_orders_event.dart';
part 'history_orders_state.dart';

class HistoryOrdersBloc extends Bloc<HistoryOrdersEvent, HistoryOrdersState> {
  HistoryOrdersBloc({
    required RentsApiClient rentsApiClient,
    required FlutterSecureStorage storage,
  })  : _rentsApiClient = rentsApiClient,
        _storage = storage,
        super(HistoryOrdersInitialState()) {
    on<HistoryOrdersLoadEvent>(_onLoad);
  }

  final RentsApiClient _rentsApiClient;
  final FlutterSecureStorage _storage;

  FutureOr<void> _onLoad(
    HistoryOrdersLoadEvent event,
    Emitter<HistoryOrdersState> emit,
  ) async {
    try {
      emit(HistoryOrdersLoadingState());
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
                rent.status.id == Statuses.canceled.value) {
              filtered.add(rent);
            }
          }
          page += 1;
        }
      }
      emit(HistoryOrdersLoadedState(rents: filtered));
    } catch (error) {
      emit(HistoryOrdersLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
