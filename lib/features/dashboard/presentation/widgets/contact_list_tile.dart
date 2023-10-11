import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/dashboard/presentation/widgets/zego_send_call_button.dart';

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
          ZegoSendCallButton(
            isVideo: false,
            userId: user.userId ?? '',
            userName: user.userName ?? '',
          ),
          ZegoSendCallButton(
            isVideo: true,
            userId: user.userId ?? '',
            userName: user.userName ?? '',
          ),
        ],
      ),
    );
  }
}
