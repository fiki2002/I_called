import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/exception/base_exception.dart';
import 'package:i_called/core/exception/firebase_auth_exception.dart';
import 'package:i_called/core/failures/base.dart';
import 'package:i_called/core/failures/error_text.dart';
import 'package:i_called/core/utils/logger.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/dashboard/data/datasource/home_remote_datasource.dart';
import 'package:i_called/features/dashboard/domain/repository/home_page_repo.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl({
    required this.homeRemoteDataSource,
  });
  @override
  Future<Either<Failures, Stream<List<UserModel>>>> getUsers() async {
    try {
      final Stream<List<UserModel>> result =
          homeRemoteDataSource.getUsers().map(
                (querySnapshot) => querySnapshot.docs
                    .map(
                      (doc) => UserModel(
                        email: doc.get('email'),
                        userId: doc.get('user_id'),
                        userName: doc.get('user_name'),
                      ),
                    )
                    .toList(),
              );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFirebaseException(e.code));
    } on SocketException {
      return const Left(BaseFailures(message: ErrorText.noInternet));
    } catch (e, s) {
      LoggerHelper.log(e, s);

      if (e is BaseFailures) {
        return Left(BaseFailures(message: e.message));
      }

      return Left(BaseFailures(message: e.toString()));
    }
  }
}
