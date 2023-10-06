import 'package:flutter/material.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({Key? key, required this.user, required this.config})
      : super(key: key);
  final ZegoUIKitPrebuiltCallConfig config;
  static const String route = '/video-call-page';
  final User user;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId,
      appSign: appSign,
      userID: user.id,
      userName: user.userName,
      callID: user.callId,
      config: config,
      //  ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
      //   ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
