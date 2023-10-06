import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/components/textfield.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/auth/presentation/sign_up_view.dart';
import 'package:i_called/features/call_page/domain/user_model.dart';
import 'package:i_called/features/call_page/presentation/create_or_join_call.dart';

class LoginView extends StatefulWidget {
  static const route = 'home-page';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _HomePageState();
}

class _HomePageState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              'Sign in',
              fontSize: kfsExtraLarge,
              fontWeight: kW700,
            ),
            Gap.box(height: kSmall10),
            const TextWidget('One Step Closer to Hassle-Free Calls'),
            Gap.box(height: kBig30),
            TextFieldWidget(
              textInputAction: TextInputAction.next,
              focusNode: _emailNode,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (_) => _passwordNode.requestFocus(),
              controller: _emailController,
              validator: (value) => value?.validateEmail(),
              hintText: 'johndoe@gmail.com',
              title: 'Enter your Email',
            ),
            Gap.box(height: kfsTiny),
            TextFieldWidget(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
              focusNode: _passwordNode,
              controller: _passwordController,
              title: 'Enter password',
              hintText: '*******',
              validator: (value) => value?.validatePassword(value),
            ),
            const Spacer(),
            Button(
              text: 'Continue',
              onTap: () => _submit(),
            ),
            Gap.box(height: kfsMedium),
            Align(
              alignment: Alignment.center,
              child: TwoSpanTextWidget(
                'Don\'t have an account?  ',
                'Click here',
                fontSize: kfsTiny,
                fontSize2: kfsTiny,
                textColor2: kPrimaryColor,
                recognizer2: TapGestureRecognizer()
                  ..onTap =
                      () => AppRouter.instance.navigateTo(SignUpView.route),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailNode = FocusNode();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      final String id = Random().nextInt(1000).toString();

      final User user = User(
        id: id,
        userName: 'text',
        callId: '',
      );

      AppRouter.instance.navigateTo(CreateOrJoinCall.route, arguments: user);
    }
  }
}
