import 'package:flutter/material.dart';

// Route createRoute(Widget page, {RouteSettings? settings}) {
//   return PageRouteBuilder(
//     settings: settings,
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionDuration: const Duration(milliseconds: 400),
//     reverseTransitionDuration: const Duration(milliseconds: 400),
//     transitionsBuilder: (context, anim, anim2, child) {
//       return SlideTransition(
//         position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(anim),
//         child: child,
//       );
//     },
//   );
// }

Route createRoute(Widget page, {RouteSettings? settings}) {
  return MaterialPageRoute(
    settings: settings,
    builder: (context) => page,
  );
}
