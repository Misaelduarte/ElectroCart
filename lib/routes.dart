import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_app/features/login/ui/login.dart';
import 'package:flutter_bloc_app/features/login/ui/register.dart';

abstract class Routes {
  static const String login = '/login';
  static const String register = '/register';
}

final Map<String, WidgetBuilder> appRoutes = {
  Routes.login: (_) => LoginPage(),
  Routes.register: (_) => RegisterPage(),
};
