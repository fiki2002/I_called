import 'package:i_called/features/auth/domain/entities/auth_entities.dart';

class AuthResultModel extends AuthResultEntity {
  const AuthResultModel({
    required super.success,
    required super.message,
    required super.user,
  });
}
