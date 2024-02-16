import 'package:currency_converter/screens/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/home/view/home_screen.dart';
import 'route_transitions.dart';

class KAppRoutes {
  static const String splash = '/';
  static const String homeScreen = '/homeScreen';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return createRoute(const SplashScreen());
      case homeScreen:
        return createRoute(const HomeScreen());
    }
    return null;
  }
}
