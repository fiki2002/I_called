import 'package:equatable/equatable.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';

class MeetingDetailsEntity extends Equatable {
  final String? meetingId;
  final UserModel? user;
  const MeetingDetailsEntity({
    this.meetingId,
    this.user,
  });

  @override
  List<Object?> get props => [
        meetingId,
        user,
      ];
}
