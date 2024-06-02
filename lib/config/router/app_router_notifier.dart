import 'package:flutter/material.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/shared/presentation/blocs/service_locator.dart';

class GoRouterNotifier extends ChangeNotifier {
  final AuthBloc _authBloc = getIt<AuthBloc>();

  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier() {
    _authBloc.stream.listen((authState) {
      authStatus = authState.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
