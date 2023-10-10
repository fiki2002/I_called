import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_called/app/app.dart';
import 'package:i_called/app/locator.dart';
import 'package:i_called/core/navigator/app_router.dart';
import 'package:i_called/firebase_options.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ZegoUIKitPrebuiltCallInvitationService()
      .setNavigatorKey(AppRouter.instance.navigatorKey);

  SetUpLocators.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  ZegoUIKit().initLog().then(
    (value) {
      
      ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
        [ZegoUIKitSignalingPlugin()],
      );

      runApp(const MyApp());
    },
  );
}
