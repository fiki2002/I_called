import 'package:flutter/material.dart';
import 'package:i_called/core/components/avatar.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/utils/logger.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/auth/data/models/user_model.dart';
import 'package:i_called/features/dashboard/presentation/change-notifier/home_notifier.dart';
import 'package:i_called/features/dashboard/presentation/widgets/contact_list_tile.dart';
import 'package:provider/provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});
  static const String route = 'dashboard-view';

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        Provider.of<HomeNotifier>(context, listen: false)
            .getCurrentUserDetails(context)
            .then((value) {
          onUserLogin();
        });
        return Provider.of<HomeNotifier>(context, listen: false)
            .getUser(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        backgroundColor: kcWhiteColor,
        elevation: 0,
        title: const TextWidget(
          'Contacts',
          fontSize: kfsExtraLarge,
          fontWeight: kW700,
        ),
      ),
      body: Consumer<HomeNotifier>(
        builder: (context, homeNotifier, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                StreamBuilder<List<UserModel>>(
                  stream: homeNotifier.userList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return TextWidget('${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const TextWidget('No contacts');
                    } else {
                      final userList = snapshot.data;
                      return ListView.separated(
                        separatorBuilder: (context, i) =>
                            Gap.box(height: kfsLarge),
                        itemCount: userList?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, contact) {
                          final user = userList![contact];

                          return ContactListTile(user: user);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ZegoUIKitPrebuiltCallController? callController;

  void onUserLogin() async {
    final user = context.read<HomeNotifier>().userModel;
    LoggerHelper.log('VALUE SHANU MI:: ${user?.userId} ${user?.userName}');
    callController ??= ZegoUIKitPrebuiltCallController();
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: appId,
      appSign: appSign,
      userID: user?.userId ?? '',
      userName: user?.userName ?? '',
      notifyWhenAppRunningInBackgroundOrQuit: true,
      androidNotificationConfig: ZegoAndroidNotificationConfig(
        channelID: "ZegoUIKit",
        channelName: "Call Notifications",
        sound: "notification",
      ),
      iOSNotificationConfig: ZegoIOSNotificationConfig(
        isSandboxEnvironment: false,
        systemCallingIconName: 'CallKitIcon',
      ),
      plugins: [ZegoUIKitSignalingPlugin()],
      controller: callController,
      requireConfig: (ZegoCallInvitationData data) {
        final config = (data.invitees.length > 1)
            ? ZegoCallType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
                : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
            : ZegoCallType.videoCall == data.type
                ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

        config.avatarBuilder = customAvatarBuilder;

        /// support minimizing, show minimizing button
        config.topMenuBarConfig.isVisible = true;
        config.topMenuBarConfig.buttons.insert(
          0,
          ZegoMenuBarButtonName.minimizingButton,
        );

        return config;
      },
    );
  }
}
