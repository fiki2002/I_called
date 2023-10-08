import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:i_called/core/firebase/firebase_helper.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  HomeRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<List<UserModel>> getUsers() async {
    Query<Map<String, dynamic>> userReference =
        firebaseHelper.userCollectionRef();
    QuerySnapshot<Map<String, dynamic>> result =
        await userReference.get();
    return result.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }
}
