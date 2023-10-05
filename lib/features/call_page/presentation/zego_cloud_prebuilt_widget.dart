import 'package:flutter/material.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: appId,
      appSign: appSign,
      userID: '',
      userName: 'user.userName',
      callID: 'callID',
      config: ZegoUIKitPrebuiltCallConfig(turnOnCameraWhenJoining: true),
    );
  }
}
