import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/repositories/repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required OrderRepositoryInterface repository})
      : _repository = repository,
        super(HomeInitialState()) {
    on<HomeBadgeOrderEvent>(_countOrders);
  }

  final OrderRepositoryInterface _repository;

  FutureOr<void> _countOrders(
    HomeBadgeOrderEvent event,
    Emitter emit,
  ) {
    try {
      final count = _repository.getOrder().tools.length;
      count > 0
          ? emit(HomeOrderLoadedState(count: count))
          : emit(HomeOrderEmptyState());
    } catch (error) {
      log(error.toString());
    }
  }
}
