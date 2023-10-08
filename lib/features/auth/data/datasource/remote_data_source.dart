import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_called/core/exception/base_exception.dart';
import 'package:i_called/core/firebase/firebase_helper.dart';
import 'package:i_called/features/auth/data/models/auth_result_model.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);

  Future<bool> isUserLoggedIn();

  Future<AuthResultModel> signUp(
    String email,
    String userName,
    String password,
  );
}

class AuthRemoteDataSourceImpl extends AuthenticationRemoteDataSource {
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
    if (userCredential.user != null) {
      final doc = await _firebaseHelper
          .userCollectionRef()
          .doc(userCredential.user?.uid)
          .get();

      final data = doc.data();
      if (data != null) {
        UserModel.fromJson(data);
      }
    }
    return const AuthResultModel(
      success: true,
      message: 'Account Successfully Signed In!',
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

    final UserModel userModel = UserModel(
      email: email,
      userName: userName,
    );

    // Save User Data to Firestore
    if (userCredential.user != null) {
      final User user = userCredential.user!;
      await _firebaseHelper
          .userCollectionRef()
          .doc(user.uid)
          .set(userModel.toJson());
    }

    return const AuthResultModel(
      success: true,
      message: 'Account Successfully Created!',
    );
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _firebaseHelper.currentUserId != null;
  }
}
