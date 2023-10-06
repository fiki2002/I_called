import 'package:equatable/equatable.dart';

class AuthResultEntity extends Equatable {
  const AuthResultEntity({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;

  @override
  List<Object?> get props => [success, message];
}
