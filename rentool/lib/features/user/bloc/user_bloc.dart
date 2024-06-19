import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required FlutterSecureStorage storage,
    required UsersApiClient usersApiClient,
  })  : _storage = storage,
        _usersApiClient = usersApiClient,
        super(UserInitialState()) {
    on<UserLoadEvent>(_onLoad);
    on<UserChangePasswordEvent>(_onChangePassword);
  }

  final UsersApiClient _usersApiClient;
  final FlutterSecureStorage _storage;

  FutureOr<void> _onLoad(
    UserLoadEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoadingState());
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        final user =
            await _usersApiClient.getUserProfile('Bearer $accessToken');
        emit(UserLoadedState(user: user));
      }
    } catch (error) {
      emit(UserLoadingFailureState(error: error));
    }
  }

  FutureOr<void> _onChangePassword(
    UserChangePasswordEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoadingState());
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        final user = await _usersApiClient.changeUserPassword(
            'Bearer $accessToken',
            Password(
              password: event.password,
            ));
        emit(UserLoadedState(user: user));
      }
    } catch (error) {
      log(error.toString());
      emit(UserLoadingFailureState(error: error));
    }
  }
}
