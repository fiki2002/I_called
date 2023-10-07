import 'dart:async';

import 'package:fpdart/fpdart.dart';

import 'package:i_called/core/base_usecase/usecase_interface.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/features/auth/domain/entities/auth_entities.dart';
import 'package:i_called/features/auth/domain/repositories/auth_repo.dart';

class LoginUseCase
    implements UseCaseFuture<Failures, AuthResultEntity, LoginParams> {
  final AuthRepository authenticationRepository;
  LoginUseCase({
    required this.authenticationRepository,
  });

  @override
  FutureOr<Either<Failures, AuthResultEntity>> call(LoginParams login) async {
    return await authenticationRepository.login(
      email: login.email,
      password: login.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({
    required this.email,
    required this.password,
  });
}
