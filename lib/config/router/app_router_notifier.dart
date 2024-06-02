import 'package:flutter/material.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';

class GoRouterNotifier extends ChangeNotifier {
  final AuthBloc authBloc;

  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this.authBloc) {
    authBloc.stream.listen((authState) {
      authStatus = authState.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }
}
// import 'package:flutter/material.dart';

// import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';

// class GoRouterNotifier extends ChangeNotifier {
//   final AuthBloc authBloc;

  // GoRouterNotifier(this.authBloc) {
  //   authBloc.stream.listen((_) => notifyListeners());
  // }

  // AuthStatus get authStatus => authBloc.state.authStatus;
// }
