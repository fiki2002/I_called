import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._internal();
  static final AppRouter instance = AppRouter._internal();
  factory AppRouter() => instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> navigate(Widget page) {
    return navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<dynamic> navigateToAndReplace(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> clearRouteAndPush(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName('/'),
    );
  }

  void goBack([dynamic result]) {
    return navigatorKey.currentState!.pop(result);
  }
}
