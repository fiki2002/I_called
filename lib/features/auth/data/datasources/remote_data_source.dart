import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_called/core/exception/base_exception.dart';
import 'package:i_called/core/firebase/firebase_helper.dart';
import 'package:i_called/features/auth/data/models/auth_result_model.dart';

abstract class AuthenticationDataSource {
  Future<AuthResultModel> login(String email, String password);

  Future<AuthResultModel> signUp(
    String email,
    String userName,
    String password,
  );
}

class AuthDataSourceImpl extends AuthenticationDataSource {
  final FirebaseHelper _firebaseHelper;
  AuthDataSourceImpl({
    required FirebaseHelper firebaseHelper,
  }) : _firebaseHelper = firebaseHelper;

  @override
  Future<AuthResultModel> login(String email, String password) async {
    final UserCredential userCredential =
        await _firebaseHelper.auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) {
      throw const BaseFailures(
        message: "Unable to login user with this credential",
      );
    }
    return const AuthResultModel(
      success: true,
      message: 'Account Successfully Created!',
    );
  }

  @override
  Future<AuthResultModel> signUp(
    String email,
    String userName,
    String password,
  ) async {

    final UserCredential userCredential =
        await _firebaseHelper.auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      throw const BaseFailures(
        message: "Unable to create account with this credential",
      );
    }
     return const AuthResultModel(
      success: true,
      message: 'Account Successfully Created!',
    );
  }
}
