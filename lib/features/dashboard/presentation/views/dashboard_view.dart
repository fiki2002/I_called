import 'package:flutter/material.dart';
import 'package:i_called/core/components/avatar.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
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
      () async {
        /// FETCH CURRENT USER DETAILS
        Provider.of<HomeNotifier>(context, listen: false)
            .getCurrentUserDetails(context)
            .then(
          (value) {
            onUserLogin();
          },
        );

        /// FETCH USERS
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
        foregroundColor: kcTextColor,
        title: const TextWidget(
          'Contacts',
          fontSize: kfsExtraLarge,
          fontWeight: kW700,
        ),
      ),
      body: Consumer<HomeNotifier>(
        builder: (context, homeNotifier, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<UserModel>>(
                stream: homeNotifier.userList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return TextWidget('${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: TextWidget('No contacts'));
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
          );
        },
      ),
    );
  }

  ZegoUIKitPrebuiltCallController? callController;

  void onUserLogin() async {
    final user = context.read<HomeNotifier>().userModel;
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
        config.topMenuBarConfig.buttons = [
          ZegoMenuBarButtonName.minimizingButton,
          ZegoMenuBarButtonName.showMemberListButton,
        ];

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
