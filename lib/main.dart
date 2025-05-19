import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_app/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app/auth/bloc/auth_state.dart';
import 'package:flutter_bloc_app/data/repositories/auth_repository.dart';
import 'package:flutter_bloc_app/features/login/ui/login.dart';
import 'package:flutter_bloc_app/features/login/ui/register.dart';
import 'package:flutter_bloc_app/routes.dart';
import 'package:flutter_bloc_app/shared/widgets/app_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));

  final authRepo = AuthRepository();
  runApp(
    BlocProvider(
      create: (_) => AuthBloc(authRepo),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            Routes.register: (_) => RegisterPage(),
          },
          home: () {
            if (state is AuthAuthenticated) {
              return const AppShell();
            }
            return LoginPage();
          }(),
        );
      },
    );
  }
}
