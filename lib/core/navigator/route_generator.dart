import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:i_called/features/call_page/presentation/create_or_join_call.dart';
import 'package:i_called/features/call_page/presentation/home_page.dart';
import 'package:i_called/features/call_page/presentation/preview_page.dart';
import 'package:i_called/features/call_page/presentation/zego_cloud_prebuilt_widget.dart';
import 'package:i_called/features/onboarding/onboarding_screen.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case OnboardingScreen.route:
        return pageRoute(const OnboardingScreen());
      case HomePage.route:
        return pageRoute(const HomePage());
      case PreviewPage.route:
        return pageRoute(PreviewPage(user: args as User));
      case VideoCallPage.route:
        return pageRoute(
          VideoCallPage(
            user: args as User,
            config: args as ZegoUIKitPrebuiltCallConfig,
          ),
        );
      case CreateOrJoinCall.route:
        return pageRoute(CreateOrJoinCall(user: args as User));
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
