import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/login_page.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
  };
}
