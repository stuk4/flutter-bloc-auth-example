import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teslo_shop/config/config.dart';
import 'package:teslo_shop/features/auth/presentation/blocs/auth/auth_bloc.dart';

import 'package:teslo_shop/features/shared/presentation/blocs/blocs.dart';

void main() async {
  await Envionment.initEnviornment();
  serviceLocatorInit();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => getIt<AuthBloc>()),
      BlocProvider(create: (context) => getIt<RouterCubit>())
    ], child: const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = context.watch<RouterCubit>().state;
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
