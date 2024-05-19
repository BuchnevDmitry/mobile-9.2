import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required CategoriesApiClient categoriesApiClient})
      : _categoriesApiClient = categoriesApiClient,
        super(CatalogInitialState()) {
    on<CatalogLoadEvent>(_onLoad);
  }

  final CategoriesApiClient _categoriesApiClient;

  Future<void> _onLoad(
    CatalogLoadEvent event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      if (state is! CatalogLoadedState) {
        emit(CatalogLoadingState());
      }
      final categories = await _categoriesApiClient.getCategories();
      emit(CatalogLoadedState(categories: categories));
    } catch (error) {
      emit(CatalogLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
