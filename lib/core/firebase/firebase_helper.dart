import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_called/core/exception/base_exception.dart';

String USERCOLLECTION = "users";

class FirebaseHelper {
  /// Authentication
  FirebaseAuth get auth => FirebaseAuth.instance;
  String? get currentUserId {
    final String? userId = auth.currentUser?.uid;
    if (userId == null) throw const BaseFailures(message: 'User not found!');

    return userId;
  }

  /// -------- FIRESTORE ---------
  CollectionReference<Map<String, dynamic>> userCollectionRef() {
    return FirebaseFirestore.instance.collection(USERCOLLECTION);
  }
}
