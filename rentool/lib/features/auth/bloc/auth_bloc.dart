import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:rentool/api/api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

bool isAuthorized = false;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required FlutterSecureStorage storage,
    required UsersApiClient usersApiClient,
    required AuthClient authClient,
    String? clientId,
    String? clientSecret,
    String? grantType,
  })  : _storage = storage,
        _usersApiClient = usersApiClient,
        _authClient = authClient,
        _clientId = clientId,
        _clientSecret = clientSecret,
        _grantType = grantType,
        super(AuthInitialState()) {
    on<AuthRegisterEvent>(_register);
    on<AuthCheckLoginInAppEvent>(_checkLoginInApp);
    on<AuthAuthorizeEvent>(_login);
    on<AuthRefreshEvent>(_refresh);
    on<AuthLogoutEvent>(_logout);
  }

  final UsersApiClient _usersApiClient;
  final AuthClient _authClient;
  final FlutterSecureStorage _storage;

  final String? _clientId;
  final String? _clientSecret;
  final String? _grantType;

  FutureOr<void> _refresh(
    AuthRefreshEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthRequestState());
      final resreshToken = await _storage.read(key: 'refresh_token');
      Token token = await _authClient.refresh(
        _clientId!,
        _grantType!,
        resreshToken!,
        _clientSecret!,
      );
      await _storage.write(
        key: 'acess_token',
        value: token.access_token,
      );
      await _storage.write(
        key: 'refresh_token',
        value: token.refresh_token,
      );
      emit(AuthAuthorizedState());
    } catch (error) {
      emit(AuthFailedAuthorizedState(error: error));
      await _storage.deleteAll();
      isAuthorized = false;
    }
  }

  FutureOr<void> _login(
    AuthAuthorizeEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthRequestState());
      Token token = await _authClient.auth(
        _clientId!,
        _clientSecret!,
        _grantType!,
        event.username,
        event.password,
      );
      await _storage.write(
        key: 'acess_token',
        value: token.access_token,
      );
      await _storage.write(
        key: 'refresh_token',
        value: token.refresh_token,
      );
      emit(AuthAuthorizedState());
      isAuthorized = true;
    } catch (error) {
      emit(AuthFailedAuthorizedState(error: error));
    } finally {
      event.completer?.complete();
    }
  }

  FutureOr<void> _logout(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthUnAuthorizedState());
      await _storage.deleteAll();
      isAuthorized = false;
    } catch (error) {
      emit(AuthFailedAuthorizedState(error: error));
    }
  }

  FutureOr<void> _checkLoginInApp(
    AuthCheckLoginInAppEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      bool exist = await _storage.containsKey(key: 'acess_token');
      if (exist) {
        isAuthorized = true;
      }
      if (isAuthorized) {
        emit(AuthAuthorizedState());
      } else {
        emit(AuthUnAuthorizedState());
      }
    } catch (error) {
      emit(AuthFailedAuthorizedState(error: error));
    }
  }

  FutureOr<void> _register(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthRequestState());
      await _usersApiClient.registerUser(event.user);
      emit(AuthUnAuthorizedState());
    } catch (error) {
      emit(AuthFailedRegistratedState(error: error));
    } finally {
      event.completer?.complete();
    }
  }
}
