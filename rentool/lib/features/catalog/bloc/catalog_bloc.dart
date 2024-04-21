import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rentool/repositories/repositories.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required this.categoriesApiClient})
      : super(CatalogInitialState()) {
    on<CatalogLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    CatalogLoadEvent event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      if (state is! CatalogLoadedState) {
        emit(CatalogLoadingState());
      }
      final categories = await categoriesApiClient.getCategories();
      emit(CatalogLoadedState(categories: categories));
    } catch (error) {
      emit(CatalogLoadingFailureState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  final CategoriesApiClient categoriesApiClient;
}
