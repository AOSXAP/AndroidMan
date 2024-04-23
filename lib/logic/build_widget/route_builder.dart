import 'package:flutter/cupertino.dart';

/// Builds fast navigation, escapes sluggish transitions
class FastRoutes{
  static Route initRoute(Widget page, Duration animationDuration) {
    return PageRouteBuilder(
      transitionDuration: animationDuration,
      reverseTransitionDuration: animationDuration,
      pageBuilder: (context, _, __) => page,
      transitionsBuilder: (context, _, __, child) {
        return child;
      },
    );
  }
}