part of 'auth_bloc.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final int errorCounter;

  const AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = '',
      this.errorCounter = 0});
// Tambien para mostar siempre el mensaje se puede usar Unikey()
  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
    int? errorCounter,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        errorCounter: errorCounter ?? this.errorCounter,
      );

  @override
  List<Object?> get props => [authStatus, user, errorMessage, errorCounter];
}
