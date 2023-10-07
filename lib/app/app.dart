import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i_called/app/locator.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/auth/domain/usecase/login_usecase.dart';
import 'package:i_called/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:i_called/features/auth/presentation/change-notifier/auth_notifier.dart';
import 'package:i_called/features/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GetIt getIt = SetUpLocators.getIt;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthNotifier(
            signUpUsecase: getIt<SignUpUseCase>(),
            loginUsecase: getIt<LoginUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'iCalled.',
        initialRoute: OnboardingScreen.route,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: AppRouter.instance.navigatorKey,
      ),
    );
  }
}
