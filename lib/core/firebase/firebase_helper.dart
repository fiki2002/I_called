import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_called/core/exception/base_exception.dart';

class FirebaseHelper {

  /// Authentication
  FirebaseAuth get auth => FirebaseAuth.instance;
  String get currentUserId {

    final String? userId = auth.currentUser?.uid;
    if (userId == null) throw const BaseFailures(message: 'User not found!');

    return userId;
  }
}
