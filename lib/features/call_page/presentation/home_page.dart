import 'dart:math';

import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/components/textfield.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:i_called/features/call_page/presentation/preview_page.dart';

class HomePage extends StatefulWidget {
  static const route = 'home-page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _controller;

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
    return ScaffoldWidget(
      appBar: AppBar(
        backgroundColor: kcWhiteColor,
        foregroundColor: kcTextColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const TextWidget(
          'iCalled',
          fontSize: kfsLarge,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFieldWidget(
              controller: _controller,
              validator: (value) => value?.validateAnyField(field: 'User name'),
            ),
            Gap.box(height: kfsMedium),
            Button(
              text: 'Continue',
              onTap: () => _submit(),
            )
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final String id = Random().nextInt(1000).toString();

      final User user = User(
        id: id,
        userName: _controller.text,
      );

      AppRouter.instance.navigateTo(PreviewPage.route, arguments: user);
    }
  }
}
