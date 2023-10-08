import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_called/core/components/text_widget.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/auth/presentation/change-notifier/auth_notifier.dart';
import 'package:i_called/features/auth/presentation/view/login_view.dart';
import 'package:i_called/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const route = 'splash_page';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  double targetValue = 1.0;

  late AnimationController _controller;
  late Animation<Offset> _offset;
  @override
  void initState() {
    super.initState();
    context.read<AuthNotifier>().checkLoginStatus();
    animationCalls();
    timerForSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: _offset,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: targetValue),
            duration: const Duration(milliseconds: 2000),
            curve: Curves.easeIn,
            builder: (context, double val, child) {
              return Opacity(
                opacity: val,
                child: const TextWidget(
                  'iCalled',
                  textColor: kPrimaryColor,
                  fontSize: kBig70,
                  fontStyle: FontStyle.italic,
                  fontWeight: kw800,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Controls the Animation of the Page
  void animationCalls() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offset = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  /// Determines the time spent on splash screen
  void timerForSplashScreen() {
    Timer(
      const Duration(seconds: 2),
      () {
        final isLoggedIn = context.read<AuthNotifier>().isLoggedIn;
        if (isLoggedIn == true) {
          AppRouter.instance.clearRouteAndPush(DashboardView.route);
        } else {
          AppRouter.instance.clearRouteAndPush(LoginView.route);
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
