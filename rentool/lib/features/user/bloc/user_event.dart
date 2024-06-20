part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserLoadEvent extends UserEvent {
  const UserLoadEvent({
    this.completer,
  });
  final Completer? completer;

  @override
  List<Object?> get props => super.props..add(completer);
}

class UserChangePasswordEvent extends UserEvent {
  const UserChangePasswordEvent({
    this.completer,
    required this.password,
  });

  final String password;
  final Completer? completer;

  @override
  List<Object?> get props => super.props
    ..addAll([
      completer,
      password,
    ]);
}

class UserRegisterEvent extends UserEvent {
  const UserRegisterEvent({
    this.completer,
    required this.user,
  });

  final User user;
  final Completer? completer;

  @override
  List<Object?> get props => super.props..addAll([completer, user]);
}
