import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inbloc_clean/dependency_container.dart';
import 'package:inbloc_clean/features/splash/presentation/pages/splash_page.dart';

import 'core/utils/globals.dart';
import 'features/auth/presentation/manager/bloc/authentication_bloc.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginUser(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>(),
      child: MaterialApp.router(
        routerConfig: _router,
      ),
    );
  }
}
