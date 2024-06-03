import 'package:get_it/get_it.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:teslo_shop/features/products/presentation/blocs/products/products_cubit.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(AuthBloc());

  getIt.registerSingleton(RouterCubit(
    createRouter(getIt<AuthBloc>()),
  ));
  // getIt.registerLazySingleton(() => ProductsCubit(
  //       authBloc: getIt<AuthBloc>(),
  //     ));
  getIt.registerSingleton(ProductsCubit(
    authBloc: getIt<AuthBloc>(),
  ));
}
