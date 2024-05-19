part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

final class HomeOrderEmptyState extends HomeState {}

final class HomeOrderLoadedState extends HomeState {
  const HomeOrderLoadedState({required this.count});

  final int count;

  @override
  List<Object> get props => super.props..add(count);
}
