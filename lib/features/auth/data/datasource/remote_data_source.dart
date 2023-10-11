import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_called/core/exception/base_exception.dart';
import 'package:i_called/core/firebase/firebase_helper.dart';
import 'package:i_called/core/utils/logger.dart';
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

  Future<UserModel> getUserModel();
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
    final String? userId = _firebaseHelper.currentUserId;
    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseHelper.userCollectionRef().doc(userId).get();

    LoggerHelper.log('USER GET RESULT:: ${result.data()}');

    return AuthResultModel(
      success: true,
      message: 'Account Successfully Signed In!',
      user: UserModel.fromJson(result.data()!),
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
    LoggerHelper.log('Fom Sign Up1:: ${userCredential.user?.uid}');

    final UserModel userModel = UserModel(
      email: email,
      userName: userName,
      userId: userCredential.user?.uid,
    );
    LoggerHelper.log('Fom Sign Up2:: ${userCredential.user?.uid}');
    // Save User Data to Fire store
    if (userCredential.user != null) {
      userCredential.user!;
      await _firebaseHelper
          .userCollectionRef()
          .doc(userCredential.user!.uid)
          .set(
            userModel.toJson(),
          );
    }

    return AuthResultModel(
      success: true,
      message: 'Account Successfully Created!',
      user: userModel,
    );
  }

  @override
  Future<UserModel> getUserModel() async {
    final String userId = _firebaseHelper.currentUserId ?? '';
    LoggerHelper.log('USER ID FROM GET PROFILE:: $userId');
    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseHelper.userCollectionRef().doc(userId).get();
        
    LoggerHelper.log('RESULT FROM DIRECT SOURCE:: ${result.data()}');

    return UserModel.fromJson(result.data()!);
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _firebaseHelper.currentUserId != null ||
        _firebaseHelper.currentUserId == '';
  }
}
