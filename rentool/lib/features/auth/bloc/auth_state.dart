part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthAuthorizedState extends AuthState {}

final class AuthRequestState extends AuthState {}

final class AuthUnAuthorizedState extends AuthState {}

final class AuthFailedAuthorizedState extends AuthState {
  const AuthFailedAuthorizedState({required this.error});

  final Object? error;

  @override
  List<Object> get props => super.props..add(error!);
}
