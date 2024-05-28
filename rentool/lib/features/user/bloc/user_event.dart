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
  List<Object?> get props => super.props..addAll([completer]);
}
