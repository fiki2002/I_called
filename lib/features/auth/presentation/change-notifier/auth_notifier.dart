import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/logger.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/auth/domain/entities/auth_entities.dart';
import 'package:i_called/features/auth/domain/entities/user_entity.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';
import 'package:i_called/features/auth/domain/usecase/login_usecase.dart';

import 'package:i_called/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:i_called/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class AuthNotifier extends ChangeNotifier {
  final SignUpUseCase signUpUsecase;
  final LoginUseCase loginUsecase;
  final CheckUserLogInStatusUsecase checkUserLoginStatusUsecase;

  AuthNotifier({
    required this.checkUserLoginStatusUsecase,
    required this.signUpUsecase,
    required this.loginUsecase,
  });
  Map<String, String> _signUpData = {
    email: '',
    userName: '',
    password: '',
  };

  void resetSignUpData() {
    _signUpData = {
      email: '',
      userName: '',
      password: '',
    };
    notifyListeners();
  }

  void updateSignUpData(var key, var value) {
    if (_signUpData.containsKey(key)) {
      _signUpData.update(key, (_) => value);
    } else {
      _signUpData.putIfAbsent(key, () => value);
    }
    notifyListeners();
  }

  bool isLoading = false;

  Future<Either<Failures, AuthResultEntity>> signUp(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    final data = await signUpUsecase.call(
      SignUpParams(
        email: _signUpData[email] ?? '',
        userName: _signUpData[userName] ?? '',
        password: _signUpData[password] ?? '',
      ),
    );
    return data.fold(
      (l) {
        isLoading = false;
        notifyListeners();
        resetSignUpData();

        SnackBarService.showSuccessSnackBar(
          context: context,
          message: l.message,
        );
        return Left(l);
      },
      (r) {
        isLoading = false;
        notifyListeners();
        resetSignUpData();
        AppRouter.instance.clearRouteAndPush(DashboardView.route);
        SnackBarService.showSuccessSnackBar(
          context: context,
          message: r.message,
        );
        final id = Random().nextInt(1000).toString();

        onUserLogin(r.user!, id);

        return Right(r);
      },
    );
  }

  /// SIGN IN PROCESSES
  Map<String, String> get signUpData => _signInData;

  Map<String, String> _signInData = {
    email: '',
    password: '',
  };

  void _resetSignInData() {
    _signInData = {
      email: '',
      password: '',
    };
    notifyListeners();
  }

  void updateSignInData(var key, var value) {
    if (_signInData.containsKey(key)) {
      _signInData.update(key, (_) => value);
    } else {
      _signInData.putIfAbsent(key, () => value);
    }

    notifyListeners();
  }

  Future<Either<Failures, AuthResultEntity>> signIn(
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();

    final data = await loginUsecase.call(
      LoginParams(
        email: _signInData[email] ?? '',
        password: _signInData[password] ?? '',
      ),
    );
    return data.fold(
      (l) {
        isLoading = false;
        notifyListeners();
        _resetSignInData();

        SnackBarService.showSuccessSnackBar(
          context: context,
          message: l.message,
        );
        return Left(l);
      },
      (r) {
        isLoading = false;
        notifyListeners();
        _resetSignInData();
        final id = Random().nextInt(1000).toString();
        onUserLogin(r.user!, id);
        AppRouter.instance.clearRouteAndPush(DashboardView.route);

        SnackBarService.showSuccessSnackBar(
          context: context,
          message: r.message,
        );
        return Right(r);
      },
    );
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  /// Check User Login Status
  Future<bool> checkLoginStatus() async {
    final res = await checkUserLoginStatusUsecase.call(NoParams());
    res.fold(
      (l) => Left(l),
      (r) {
        _isLoggedIn = true;
        notifyListeners();
      },
    );
    return _isLoggedIn;
  }

  void onUserLogin(UserEntity user, String id) {
    LoggerHelper.log('User ${user.userName}');
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appId,
      appSign: appSign,
      userID: '${user.userName}_$id',
      userName: user.userName ?? '',
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }
}
