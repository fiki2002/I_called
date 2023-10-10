import 'package:fpdart/fpdart.dart';
import 'package:i_called/core/failures/failures.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';

abstract class HomeRepository {
  Future<Either<Failures, Stream<List<UserModel>>>> getUsers();
}
