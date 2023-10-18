import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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

    final phoneNumber = Random().nextInt(1000);

    final UserModel userModel = UserModel(
      email: email,
      userName: userName,
      userId: '080$phoneNumber',
    );
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
    final DocumentSnapshot<Map<String, dynamic>> result =
        await _firebaseHelper.userCollectionRef().doc(userId).get();

    return UserModel.fromJson(result.data() ?? {});
  }

  @override
  Future<bool> isUserLoggedIn() async {
    return _firebaseHelper.currentUserId != null ||
        _firebaseHelper.currentUserId == '';
  }
}
