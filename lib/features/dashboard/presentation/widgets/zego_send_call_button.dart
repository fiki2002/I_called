import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoSendCallButton extends StatelessWidget {
  const ZegoSendCallButton({
    super.key,
    required this.isVideo,
    required this.userId,
    required this.userName,
  });
  final bool isVideo;
  final String userId;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return ZegoSendCallInvitationButton(
      isVideoCall: isVideo,
      resourceID: "zegouikit_call",
      borderRadius: 10,
      iconSize: const Size(40, 40),
      buttonSize: const Size(50, 50),
      invitees: [
        ZegoUIKitUser(
          id: userId,
          name: userName,
        ),
      ],
      // onPressed: (v){},
    );
  }
}
