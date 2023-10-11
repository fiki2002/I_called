import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/base_usecase/usecase_interface.dart';
import 'package:i_called/core/failures/base.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/auth/domain/repositories/auth_repo.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';

class GetUserModelUsecase
    implements UseCaseFuture<Failures, UserModel?, NoParams> {
  final AuthRepository authenticationRepository;
  GetUserModelUsecase({
    required this.authenticationRepository,
  });

  @override
  FutureOr<Either<Failures, UserModel?>> call(NoParams params) async {
    return await authenticationRepository.getUserModel();
  }
}

