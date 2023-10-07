import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/features/call_page/presentation/input_dialog.dart';

class CreateOrJoinCall extends StatelessWidget {
  const CreateOrJoinCall({super.key});
  static const String route = '/create-or join-call';
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            'Hey there',
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
                  ),
                ),
              ),
              Gap.box(width: kfsExtraLarge),
              Expanded(
                child: Button(
                  text: 'Join',
                  onTap: () => InputDialog.show(
                    context,
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
