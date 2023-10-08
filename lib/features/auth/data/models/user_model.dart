import 'package:i_called/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.email,
    super.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final email = json['email'];

    if (email is! String) {
      throw FormatException(
        'Invalid JSON: required "email" field of type String in $json',
      );
    }
    final userName = json['user_name'];
    if (userName is! String) {
      throw FormatException(
        'Invalid JSON: required "user_name" field of type String in $json',
      );
    }

    return UserModel(
      email: email,
      userName: userName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'user_name': userName,
    };
  }
}
