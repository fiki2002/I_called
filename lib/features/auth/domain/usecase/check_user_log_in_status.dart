import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:i_called/core/base_usecase/usecase_interface.dart';
import 'package:i_called/core/failures/base.dart';
import 'package:i_called/features/auth/domain/repositories/auth_repo.dart';

class CheckUserLogInStatusUsecase
    implements UseCaseFuture<Failures, bool, NoParams> {
  final AuthRepository authenticationRepository;
  CheckUserLogInStatusUsecase({
    required this.authenticationRepository,
  });

  @override
  FutureOr<Either<Failures, bool>> call(NoParams params) async {
    return await authenticationRepository.isUserLoggedIn();
  }
}

/// In cases where no params are to be passed, we call [NoParams]
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
