import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:i_called/features/call_page/presentation/input_dialog.dart';

class CreateOrJoinCall extends StatelessWidget {
  const CreateOrJoinCall({super.key, required this.user});
  final User user;
  static const String route = '/create-or join-call';
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'Hey there, ${user.userName}',
            fontSize: kBig30,
            fontWeight: kW700,
          ),
          Gap.box(height: kSmall10),
          const TextWidget(
            'Do you want to join a call or create?',
            fontSize: kfsMedium,
            fontWeight: kW400,
          ),
          Gap.box(height: kBig50),
          Image.asset(createOrJoin),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Button(
                  text: 'Create',
                  onTap: () => InputDialog.show(
                    context,
                    isCreate: true,
                    user: user,
                  ),
                ),
              ),
              Gap.box(width: kfsExtraLarge),
              Expanded(
                child: Button(
                  text: 'Join',
                  onTap: () => InputDialog.show(
                    context,
                    user: user,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
