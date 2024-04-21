part of 'catalog_bloc.dart';

@immutable
sealed class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

final class CatalogInitialState extends CatalogState {}

final class CatalogLoadingState extends CatalogState {}

final class CatalogLoadedState extends CatalogState {
  const CatalogLoadedState({required this.categories});

  final Categories categories;

  @override
  List<Object> get props => super.props..add(categories);
}

final class CatalogLoadingFailureState extends CatalogState {
  const CatalogLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
