import 'package:equatable/equatable.dart';
import 'package:i_called/features/auth/domain/entities/user_entity.dart';

class AuthResultEntity extends Equatable {
  const AuthResultEntity({
    required this.success,
    required this.message,
    this.user,
  });

  final bool success;
  final String message;
  final UserEntity? user;

  @override
  List<Object?> get props => [success, message, user];
}
