import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
    on<UserRegisterEvent>(_register);
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
      emit(UserRequestState());
      final accessToken = await _storage.read(key: 'acess_token');
      if (accessToken != null) {
        await _usersApiClient.changeUserPassword(
            'Bearer $accessToken',
            Password(
              password: event.password,
            ));
        emit(UserLogoutState());
      }
    } catch (error) {
      log(error.toString());
      emit(UserLoadingFailureState(error: error));
    }
  }

  FutureOr<void> _register(
    UserRegisterEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserRequestState());
      await _usersApiClient.registerUser(event.user);
      emit(UserRegisterSucsessState());
    } catch (error) {
      if (error is DioException) {
        String errorMessage = 'Произошла ошибка';
        if (error.response != null && error.response?.data != null) {
          try {
            if (error.response?.data is Map<String, dynamic> &&
                error.response?.data.containsKey('message')) {
              errorMessage = error.response?.data['message'];
            } else if (error.response?.data is String) {
              errorMessage = error.response?.data;
            }
          } catch (e) {
            log('Error while parsing error response: $e');
          }
        }
        emit(UserLoadingFailureState(error: error, message: errorMessage));
      } else {
        log('Error: $error');
        emit(UserLoadingFailureState(error: error));
      }
    } finally {
      event.completer?.complete();
    }
  }
}
