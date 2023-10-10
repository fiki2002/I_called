import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i_called/app/locator.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';
import 'package:i_called/features/auth/domain/usecase/login_usecase.dart';
import 'package:i_called/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:i_called/features/auth/presentation/change-notifier/auth_notifier.dart';
import 'package:i_called/features/dashboard/domain/usecase/get_users_usecase.dart';
import 'package:i_called/features/dashboard/presentation/change-notifier/home_notifier.dart';
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
            checkUserLoginStatusUsecase: getIt<CheckUserLogInStatusUsecase>(),
          ),
        ),
        ChangeNotifierProvider.value(
          value: HomeNotifier(
            getUsersUsecase: getIt<GetUsersUsecase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'iCalled.',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: AppRouter.instance.navigatorKey,
      ),
    );
  }
}
