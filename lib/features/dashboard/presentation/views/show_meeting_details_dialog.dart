import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/components/textfield.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/dashboard/data/model/meeting_details_model.dart';
import 'package:i_called/features/dashboard/presentation/change-notifier/home_notifier.dart';
import 'package:i_called/features/dashboard/presentation/widgets/video_conference_page.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MeetingDetailsDialog extends StatefulWidget {
  const MeetingDetailsDialog({
    super.key,
    this.isJoin = false,
  });
  final bool isJoin;
  static Future<void> show(BuildContext context, {bool isJoin = false}) {
    return showDialog(
      context: context,
      builder: (context) {
        return MeetingDetailsDialog(
          isJoin: isJoin,
        );
      },
    );
  }

  @override
  State<MeetingDetailsDialog> createState() => _MeetingDetailsDialogState();
}

class _MeetingDetailsDialogState extends State<MeetingDetailsDialog> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    Future.microtask(
      () => Provider.of<HomeNotifier>(context, listen: false)
          .getCurrentUserDetails(context),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Consumer<HomeNotifier>(
      builder: (context, value, _) {
        late String id = value.getUserMeetingID();
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isJoin != true
                  ? const TextWidget(
                      'Copy Meeting link to share: ',
                      fontSize: kfsTiny,
                      fontWeight: kW500,
                    )
                  : const SizedBox.shrink(),
              Gap.box(height: kSmall10),
              widget.isJoin == true
                  ? TextFieldWidget(
                      title: 'Enter meeting id',
                      controller: _controller,
                      hintText: '',
                    )
                  : Row(
                      children: [
                        TextWidget(
                          id,
                          fontSize: kfsMedium,
                          fontWeight: kW700,
                        ),
                        Gap.box(width: kSmall10),
                        GestureDetector(
                          onTap: () {
                            Share.share(
                              'You have an invite from ${value.userModel?.userName ?? ''} on iCalled: $id',
                            );
                          },
                          child: shareIcon.svg,
                        ),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: id,
                              ),
                            );
                          },
                          child: copyIcon.svg,
                        ),
                      ],
                    ),
              Gap.box(height: kfsExtraLarge),
              Button(
                text: 'Join',
                onTap: () {
                  if (widget.isJoin == true && _controller.text.isEmpty) {
                    SnackBarService.showErrorSnackBar(
                      context: context,
                      message: 'Please input an ID',
                      margin: EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: height - 50,
                      ),
                    );
                  } else {
                    AppRouter.instance.goBack();
                    AppRouter.instance.navigateTo(
                      VideoConferencePage.route,
                      arguments: MeetingDetails(
                        meetingId:
                            widget.isJoin == true ? _controller.text : id,
                        user: value.userModel,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
