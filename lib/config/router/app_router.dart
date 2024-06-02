import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/products/products.dart';
import 'package:teslo_shop/features/shared/presentation/blocs/service_locator.dart';

final _appRouter = GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterNotifier(),
    routes: [
      ///* Auth Routes
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      ///* Product Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
    ],
    redirect: (context, state) {
      print(state.matchedLocation);
      final authStatus = getIt<AuthBloc>().state.authStatus;
      final isGoingTo = state.matchedLocation;
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') {
          return null;
        }
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    });

class RouterCubit extends Cubit<GoRouter> {
  RouterCubit() : super(_appRouter);

  void goBack() {
    state.pop();
  }

  void goHome() {
    state.go('/');
  }
}
