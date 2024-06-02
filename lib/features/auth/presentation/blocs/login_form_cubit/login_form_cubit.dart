import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'package:teslo_shop/features/shared/infrastructure/inputs/inputs.dart';
import 'package:teslo_shop/features/shared/presentation/blocs/blocs.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  final loginUserCallback = getIt<AuthBloc>().loginUser;

  LoginFormCubit() : super(const LoginFormState());

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    emit(state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password])));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    emit(state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email])));
  }

  void onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;
    emit(state.copyWith(isPosting: true));
    await loginUserCallback(state.email.value, state.password.value);
    emit(state.copyWith(isPosting: false));
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email, password]),
    ));
  }
}
