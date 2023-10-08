import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_called/core/exception/base_exception.dart';
import 'package:i_called/core/firebase/firebase_helper.dart';
import 'package:i_called/features/auth/data/models/auth_result_model.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSourceImpl {
  Future<AuthResultModel> login(String email, String password);

  Future<bool> isUserLoggedIn();

  Future<AuthResultModel> signUp(
    String email,
    String userName,
    String password,
  );
}

class AuthRemoteDataSourceImpl extends AuthenticationRemoteDataSourceImpl {
  final FirebaseHelper _firebaseHelper;
  AuthRemoteDataSourceImpl({
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
        message: "Unable to sign in user with this credential",
      );
    }

    return const AuthResultModel(
      success: true,
      message: 'Account Successfully Signed In!',
      user: UserModel(
        userId: 'userId',
        email: 'email',
        userName: 'userName',
      ),
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
        user: UserModel(
          userId: 'userId',
          email: 'email',
          userName: 'userName',
        ));
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _firebaseHelper.currentUserId != null;
  }
}
