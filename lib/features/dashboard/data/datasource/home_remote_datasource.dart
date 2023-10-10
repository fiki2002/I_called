import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:i_called/core/firebase/firebase_helper.dart';

abstract class HomeRemoteDataSource {
  Stream<QuerySnapshot> getUsers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseHelper firebaseHelper;
  HomeRemoteDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Stream<QuerySnapshot> getUsers() {
    Query<Map<String, dynamic>> userReference =
        firebaseHelper.userCollectionRef();
    Stream<QuerySnapshot> result = userReference.snapshots();
    return result;
  }
}
