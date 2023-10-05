import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/call_page/presentation/home_page.dart';

class OnboardingScreen extends StatelessWidget {
  static const route = "/onboarding";

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap.box(height: kBig100),
          Image.asset(callIllustration),
          Gap.box(height: kBig30),
          const TextWidget(
            'Welcome to iCalled!',
            fontSize: kBig30,
            fontWeight: kW700,
          ),
          Gap.box(height: kfsMedium),
          const TextWidget(
            'Ready to level up your calling game?\niCalled is here to make connecting with people easier!',
            textAlign: TextAlign.center,
            fontWeight: kW500,
            fontSize: kfsLarge,
          ),
          Gap.box(height: kBig100),
          Button(
            text: 'Get Started',
            onTap: () => AppRouter.instance.clearRouteAndPush(HomePage.route),
          )
        ],
      ),
    );
  }
}
