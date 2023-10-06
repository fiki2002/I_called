import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/components/textfield.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:i_called/features/call_page/presentation/preview_page.dart';
import 'package:i_called/features/call_page/presentation/zego_cloud_prebuilt_widget.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({
    super.key,
    this.isCreate = false,
    required this.user,
  });
  final bool isCreate;
  final User user;

  static Future<void> show(
    BuildContext context, {
    bool isCreate = false,
    required User user,
  }) {
    return showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => InputDialog(
        isCreate: isCreate,
        user: user,
      ),
    );
  }

  @override
  State<InputDialog> createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  late TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callId = Random().nextInt(10000).toString();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kfsMedium),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isCreate == false) ...[
              const TextWidget(
                'Input the call id shared with you',
                fontSize: kfsLarge,
                fontWeight: kW500,
              ),
              Gap.box(height: kfsExtraLarge),
              TextFieldWidget(
                controller: _controller,
                showDefault: false,
                inputFormats: [FilteringTextInputFormatter.digitsOnly],
                hintText: '0000',
                validator: (value) => value?.validateAnyField(
                  field: 'To join call, call id is required.',
                ),
              ),
            ] else ...[
              TwoSpanTextWidget(
                'Your call id is: ',
                callId,
                fontSize: kfsVeryTiny,
                fontWeight: kW400,
                fontSize2: kfsMedium,
                fontWeight2: kW700,
              ),
              Gap.box(height: kfsExtraLarge),
              const TextWidget(
                'You can share to your friends and get talking!',
                fontWeight: FontWeight.w500,
              ),
            ],
            Gap.box(height: kfsExtraLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  text: 'Submit',
                  onTap: switch (widget.isCreate) {
                    true => () => _createCall(),
                    false => () => _joinCall(),
                  },
                  width: kBig100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createCall() async {
    AppRouter.instance.goBack();

    await Future.delayed(const Duration(milliseconds: 200));

    AppRouter.instance.navigateTo(PreviewPage.route, arguments: widget.user);
  }

  void _joinCall() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      widget.user.callId = _controller.text;
      AppRouter.instance.navigateToAndReplace(
        VideoCallPage.route,
        arguments: widget.user,
        
      );
    }
  }
}
