import 'dart:async';

import 'package:fpdart/fpdart.dart';

import 'package:i_called/core/base_usecase/usecase_interface.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/features/auth/domain/entities/auth_entities.dart';
import 'package:i_called/features/auth/domain/repositories/auth_repo.dart';

class SignUpUseCase
    implements UseCaseFuture<Failures, AuthResultEntity, SignUpParams> {
  final AuthRepository authenticationRepository;
  SignUpUseCase({
    required this.authenticationRepository,
  });

  @override
  FutureOr<Either<Failures, AuthResultEntity>> call(
    SignUpParams signUp,
  ) async {
    return await authenticationRepository.signUp(
      email: signUp.email,
      userName: signUp.userName,
      password: signUp.password,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String userName;
  SignUpParams({
    required this.email,
    required this.userName,
    required this.password,
  });
}
