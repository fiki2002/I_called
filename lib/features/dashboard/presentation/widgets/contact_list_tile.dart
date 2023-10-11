import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ContactListTile extends StatelessWidget {
  const ContactListTile({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kfsTiny),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: kfsLarge,
            backgroundColor: kcBorderColor,
            child: TextWidget(
              user.userName?[0] ?? '',
              textColor: kcWhiteColor,
              fontSize: kfsLarge,
              fontWeight: kW700,
            ),
          ),
          Gap.box(width: kfsMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                user.userName ?? '',
              ),
              Gap.box(height: kSmall10),
              TextWidget(
                user.userId ?? '',
              ),
            ],
          ),
          const Spacer(),
          ZegoSendCallInvitationButton(
            isVideoCall: false,
            resourceID: "zegouikit_call",
            borderRadius: 10,
            iconSize: const Size(40, 40),
            buttonSize: const Size(50, 50),
            invitees: [
              ZegoUIKitUser(
                id: user.userId ?? '',
                name: user.userName ?? '',
              ),
            ],
          ),
          ZegoSendCallInvitationButton(
            isVideoCall: true,
            resourceID: "zegouikit_call",
            borderRadius: 10,
            iconSize: const Size(40, 40),
            buttonSize: const Size(50, 50),
            invitees: [
              ZegoUIKitUser(
                id: user.userId ?? '',
                name: user.userName ?? '',
              ),
            ],
            // onPressed: (v){},
          ),
        ],
      ),
    );
  }
}
