import 'package:flutter/material.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/onboarding/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCalled.',
      initialRoute: OnboardingScreen.route,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: AppRouter.instance.navigatorKey,
    );
  }
}