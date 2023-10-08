import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? userName;
  const UserEntity({
     this.email,
     this.userName,
  });
  @override
  List<Object?> get props => [];
}
