import 'package:equatable/equatable.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';

class AuthResultEntity extends Equatable {
  const AuthResultEntity( {
    required this.success,
    required this.message,
    required this.user,
  });

  final bool success;
  final String message;
  final UserModel user;

  @override
  List<Object?> get props => [success, message];
}
