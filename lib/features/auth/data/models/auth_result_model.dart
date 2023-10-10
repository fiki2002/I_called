import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/auth/domain/entities/auth_entities.dart';

class AuthResultModel extends AuthResultEntity {
  const AuthResultModel({
    required bool success,
    required String message,
    UserModel? user, 
  }) : super(success: success, message: message, user: user);

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    final email = json['email'];
    final userName = json['user_name'];

    return AuthResultModel(
      success: json['success'], 
      message: json['message'], 
      user: UserModel(
        email: email,
        userName: userName,
        userId: json['user_id'], 
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'success': success,
      'message': message,
    };

    if (user != null) {
      data['user'] = user!.toJson();
    }

    return data;
  }
}
