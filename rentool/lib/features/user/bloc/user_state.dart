part of 'user_bloc.dart';

@immutable
sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserLoadedState extends UserState {
  const UserLoadedState({
    required this.user,
  });

  final User user;

  @override
  List<Object> get props => super.props..add(user);
}

final class UserLoadingFailureState extends UserState {
  const UserLoadingFailureState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
