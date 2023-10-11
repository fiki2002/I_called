import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i_called/app/locator.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';
import 'package:i_called/features/auth/domain/usecase/get_user_model_usecase.dart';
import 'package:i_called/features/auth/domain/usecase/login_usecase.dart';
import 'package:i_called/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:i_called/features/auth/presentation/change-notifier/auth_notifier.dart';
import 'package:i_called/features/dashboard/domain/usecase/get_users_usecase.dart';
import 'package:i_called/features/dashboard/presentation/change-notifier/home_notifier.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
            getUserModelUsecase: getIt<GetUserModelUsecase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'iCalled.',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: AppRouter.instance.navigatorKey,
         builder: (BuildContext context, Widget? child) {
        return Stack(
          children: [
            child!,

            /// support minimizing
            ZegoUIKitPrebuiltCallMiniOverlayPage(
              contextQuery: () {
                return AppRouter.instance.navigatorKey.currentState!.context;
              },
            ),
          ],
        );
      },
      ),
    );
  }
}
