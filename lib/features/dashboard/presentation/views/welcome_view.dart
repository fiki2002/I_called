import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/app_router.dart';
import 'package:i_called/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:i_called/features/dashboard/presentation/views/show_meeting_details_dialog.dart';
import 'package:lottie/lottie.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  static const String route = 'welcome-view';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.5,
            child: Lottie.asset(
              welcomeLottie,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kfsMedium,
              vertical: kfsMedium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  'Premium communication.\nNow free for everyone.',
                  fontSize: kBig30,
                  fontWeight: kW600,
                ),
                Gap.box(height: kBig30),
                Row(
                  children: [
                    Expanded(
                      child: _buildContainer(
                        title: 'New Meeting',
                        onTap: () => MeetingDetailsDialog.show(context),
                      ),
                    ),
                    Gap.box(width: kfsExtraLarge),
                    Expanded(
                      child: _buildContainer(
                        title: 'Join Meeting',
                        onTap: () => MeetingDetailsDialog.show(
                          context,
                          isJoin: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap.box(height: kfsTiny),
                Row(
                  children: [
                    Expanded(
                      child: _buildContainer(
                        title: 'View contacts',
                        onTap: () =>
                            AppRouter.instance.navigateTo(DashboardView.route),
                      ),
                    ),
                    Gap.box(width: kfsExtraLarge),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainer({
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: kfsMedium,
          horizontal: kfsMedium,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(kfsTiny),
        ),
        child: TextWidget(
          title,
        ),
      ),
    );
  }
}
