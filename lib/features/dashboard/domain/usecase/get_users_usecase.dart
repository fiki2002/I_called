import 'dart:async';

import 'package:fpdart/src/either.dart';

import 'package:i_called/core/base_usecase/usecase_interface.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/auth/domain/usecase/check_user_log_in_status.dart';
import 'package:i_called/features/dashboard/domain/repository/home_page_repo.dart';

class GetUsersUsecase implements UseCaseFuture<Failures, List<UserModel>, NoParams> {
  final HomeRepository homeRepository;
  GetUsersUsecase({
    required this.homeRepository,
  });

  @override
  FutureOr<Either<Failures, List<UserModel>>> call(NoParams params) async {
    return await homeRepository.getUsers();
  }
}
