import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/exception/base_exception.dart';
import 'package:i_called/core/exception/firebase_auth_exception.dart';

import 'package:i_called/core/failures/base.dart';
import 'package:i_called/core/failures/error_text.dart';
import 'package:i_called/core/utils/logger.dart';
import 'package:i_called/features/auth/data/datasource/remote_data_source.dart';
import 'package:i_called/features/auth/data/models/auth_result_model.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/auth/domain/entities/auth_entities.dart';
import 'package:i_called/features/auth/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  AuthRepositoryImpl({
    required this.authenticationRemoteDataSource,
  });

  @override
  Future<Either<Failures, AuthResultEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResultModel result = await authenticationRemoteDataSource.login(
        email,
        password,
      );
      return Either.right(result);
    } on FirebaseAuthException catch (e, s) {
      return Either.left(AuthFirebaseException(e.code, s));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, AuthResultEntity>> signUp({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      final AuthResultModel result =
          await authenticationRemoteDataSource.signUp(
        email,
        userName,
        password,
      );
      return Either.right(result);
    } on FirebaseAuthException catch (e) {
      return Either.left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, bool>> isUserLoggedIn() async {
    try {
      final result = await authenticationRemoteDataSource.isUserLoggedIn();
      return Either.right(result);
    } on FirebaseAuthException catch (e) {
      return Either.left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, UserModel?>> getUserModel() async {
    try {
      final result = await authenticationRemoteDataSource.getUserModel();
      LoggerHelper.log(
          'USER MODEL RESULT FROM AUTH REPO IMPL:: ${result.userId} ${result.userName} ${result.email} $result');
      return Either.right(result);
    } on FirebaseAuthException catch (e) {
      return Either.left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Either.left(BaseFailures(message: e.message));
      }

      return Either.left(BaseFailures(message: e.toString()));
    }
  }
}
