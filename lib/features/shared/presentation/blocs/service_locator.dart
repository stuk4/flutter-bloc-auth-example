import 'package:get_it/get_it.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';

GetIt getIt = GetIt.instance;

void serviceLocatorInit() {
  getIt.registerSingleton(AuthBloc());
  getIt.registerSingleton(RouterCubit());
}
