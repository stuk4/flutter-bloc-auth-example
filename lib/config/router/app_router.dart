import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/config/router/app_router_notifier.dart';
import 'package:teslo_shop/features/auth/auth.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/products/products.dart';

GoRouter createRouter(AuthBloc authBloc) {
  final routerNotifier = GoRouterNotifier(authBloc);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: routerNotifier,
    routes: [
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
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductsScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) => ProductScreen(
          productId: state.pathParameters['id'] ?? 'no-id',
        ),
      ),
    ],
    redirect: (context, state) {
      final authStatus = routerNotifier.authStatus;
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
    },
  );
}

class RouterCubit extends Cubit<GoRouter> {
  RouterCubit(GoRouter router) : super(router);

  void goBack() {
    state.pop();
  }

  void goHome() {
    state.go('/');
  }
}
