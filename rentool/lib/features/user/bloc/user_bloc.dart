import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
        final id = getIdFromJWT(accessToken);
        final user =
            await _usersApiClient.getUserById(id, 'Bearer $accessToken');
        emit(UserLoadedState(user: user));
      }
    } catch (error) {
      emit(UserLoadingFailureState(error: error));
    }
  }

  String getIdFromJWT(String token) {
    return JwtDecoder.decode(token)['sub'];
  }
}
