import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/features/auth/domain/entities/auth_entities.dart';

abstract class AuthRepository {
  Future<Either<Failures, AuthResultEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failures, AuthResultEntity>> signUp({
    required String email,
    required String userName,
    required String password,
  });

  Future<Either<Failures, bool>> isUserLoggedIn();
}
