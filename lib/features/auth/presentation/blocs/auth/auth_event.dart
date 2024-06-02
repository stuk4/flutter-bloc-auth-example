part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// class LoginUserEvent extends AuthEvent {
//   final User user;
//   final AuthStatus authStatus;

//   const LoginUserEvent({required this.user, required this.authStatus});

//   @override
//   List<Object> get props => [user, authStatus];
// }

class LogoutUserEvent extends AuthEvent {
  final String? errorMessage;

  const LogoutUserEvent([this.errorMessage]);
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class SetLoggedUserEvent extends AuthEvent {
  final User user;

  const SetLoggedUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterUserEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  const RegisterUserEvent(
      {required this.email, required this.password, required this.fullName});

  @override
  List<Object> get props => [email, password, fullName];
}
