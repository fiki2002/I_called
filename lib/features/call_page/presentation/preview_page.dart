import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:i_called/features/call_page/presentation/zego_cloud_prebuilt_widget.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key, required this.user});
  static const route = '/preview-page';
  final User user;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        children: [
          Gap.box(height: kBig100),
          Center(
            child: CircleAvatar(
              radius: kBig70,
              backgroundColor: kPrimaryColor.withOpacity(.4),
              child: TextWidget(
                widget.user.userName[0],
                fontSize: kBig50,
                textColor: kcWhiteColor,
                fontWeight: kW700,
              ),
            ),
          ),
          Gap.box(height: kfsExtraLarge),
          TextWidget(
            widget.user.userName,
            fontSize: kBig30,
            fontWeight: kW600,
            textColor: kcTextColor,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: kBig30,
                backgroundColor: kcBorder1,
                child: audioIcon.svg,
              ),
              GestureDetector(
                onTap: () => AppRouter.instance.navigateToAndReplace(
                  VideoCallPage.route,
                  arguments: widget.user,
                ),
                child: CircleAvatar(
                  radius: kBig30,
                  backgroundColor: kcBorder1,
                  child: videoIcon.svg,
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

