import 'dart:math';

import 'package:i_called/features/dashboard/domain/entity/meeting_details.dart';

class MeetingDetails extends MeetingDetailsEntity {
  const MeetingDetails({
     super.meetingId,
     super.user,
  });

  String generateId() {
    final random = Random.secure();
    const alphabets = 'abcdefghijklmnopqrstuvwxyz';

    String randomString = '';
    for (int i = 0; i < 10; i++) {
      final randomIndex = random.nextInt(alphabets.length);
      randomString += alphabets[randomIndex];
    }
    return randomString;
  }
}
