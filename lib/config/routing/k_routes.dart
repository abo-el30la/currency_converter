import 'package:currency_converter/screens/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';

import '../../screens/converter/view/converter_screen.dart';
import '../../screens/home/view/home_screen.dart';
import 'route_transitions.dart';

class KAppRoutes {
  static const String splash = '/';
  static const String homeScreen = '/homeScreen';
  static const String converterScreen = '/converterScreen';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return createRoute(const SplashScreen(), settings: routeSettings);
      case homeScreen:
        return createRoute(const HomeScreen(), settings: routeSettings);
      case converterScreen:
        return createRoute(const ConverterScreen(), settings: routeSettings);
      default:
        return null;
    }
    return null;
  }
}
