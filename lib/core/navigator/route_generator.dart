import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/auth/presentation/view/sign_up_view.dart';
import 'package:i_called/features/auth/presentation/view/login_view.dart';
import 'package:i_called/features/dashboard/data/model/meeting_details_model.dart';
import 'package:i_called/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:i_called/features/dashboard/presentation/views/welcome_view.dart';
import 'package:i_called/features/dashboard/presentation/widgets/video_conference_page.dart';
import 'package:i_called/features/onboarding/onboarding_screen.dart';
import 'package:i_called/features/splash/splash_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return pageRoute(const SplashPage());
      case OnboardingScreen.route:
        return pageRoute(const OnboardingScreen());
      case LoginView.route:
        return pageRoute(const LoginView());
      case SignUpView.route:
        return pageRoute(const SignUpView());
      case DashboardView.route:
        return pageRoute(const DashboardView());
      case WelcomeView.route:
        return pageRoute(const WelcomeView());
      case VideoConferencePage.route:
        return pageRoute(
          VideoConferencePage(
            user: args as MeetingDetails,
          ),
        );
      default:
        return errorRoute();
    }
  }

  static PageRoute pageRoute(Widget page) {
    if (!kIsWeb && Platform.isIOS) {
      return CupertinoPageRoute(builder: (_) => page);
    }

    return MaterialPageRoute(builder: (_) => page);
  }
}
