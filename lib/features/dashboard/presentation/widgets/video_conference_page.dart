import 'package:flutter/material.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/dashboard/data/model/meeting_details_model.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final MeetingDetails user;
  static const String route = 'video-conference-page';

  const VideoConferencePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: appId,
        appSign: appSign,
        userID: user.user?.userId ?? '',
        userName: user.user?.userName ?? '',
        conferenceID: user.meetingId ?? '',
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
