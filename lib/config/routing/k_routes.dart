import 'package:currency_converter/screens/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

import 'route_transitions.dart';

class KAppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String noInternetPage = '/noInternetPage';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return createRoute(const SplashScreen());
    }
    return null;
  }
}
