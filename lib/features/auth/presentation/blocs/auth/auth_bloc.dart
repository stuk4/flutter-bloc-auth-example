import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_services_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  AuthBloc() : super(const AuthState()) {
    on<RegisterUserEvent>(_registerUserHandler);
    on<SetLoggedUserEvent>(_setLoggedUserHandler);
    on<LogoutUserEvent>(_logoutHandler);
    on<CheckAuthStatusEvent>(_checkAuthStatusHandler);
    checkAuthStatus();
  }

  void checkAuthStatus() {
    add(const CheckAuthStatusEvent());
  }

  void _checkAuthStatusHandler(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    final token = await keyValueStorageService.getValue<String>('token');
    if (token == null) return logout();
    try {
      final user = await authRepository.checkAuthStatus(token);
      add(SetLoggedUserEvent(user: user));
    } catch (e) {
      logout();
    }
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(microseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      keyValueStorageService.setKeyValue('token', user.token);
      add(SetLoggedUserEvent(user: user));
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error desconocido');
    }
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');
    add(LogoutUserEvent(errorMessage));
  }

  void _logoutHandler(LogoutUserEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        user: null,
        authStatus: AuthStatus.notAuthenticated,
        errorMessage: event.errorMessage,
        errorCounter: state.errorCounter + 1));
  }

  void _setLoggedUserHandler(
      SetLoggedUserEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(
      user: event.user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    ));
  }

  void registerUser(String email, String password, String fullName) async {}

  void _registerUserHandler(RegisterUserEvent event, Emitter<AuthState> emit) {}
}
