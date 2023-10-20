import 'package:equatable/equatable.dart';

class MeetingDetailsEntity extends Equatable {
  final String? meetingId;
  const MeetingDetailsEntity({
     this.meetingId,
  });

  @override
  List<Object?> get props => [meetingId];
}
