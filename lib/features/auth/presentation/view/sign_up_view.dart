import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/components/textfield.dart';
import 'package:i_called/core/constants/constants.dart';
import 'package:i_called/core/navigator/navigator.dart';
import 'package:i_called/core/utils/utils.dart';
import 'package:i_called/features/auth/presentation/change-notifier/auth_notifier.dart';
import 'package:i_called/features/auth/presentation/view/login_view.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});
  static const route = 'sign-up-page';

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailNode;
  late final FocusNode _passwordNode;
  late final FocusNode _userNameNode;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: true,
      body: Consumer<AuthNotifier>(
        builder: (_, auth, __) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  'Sign up',
                  fontSize: kfsExtraLarge,
                  fontWeight: kW700,
                ),
                Gap.box(height: kSmall10),
                const TextWidget('Welcome to iCalled'),
                Gap.box(height: kBig30),
                TextFieldWidget(
                  onFieldSubmitted: (_) => _userNameNode.requestFocus(),
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailNode,
                  textInputAction: TextInputAction.next,
                  onSaved: (v) => context.auth.updateSignUpData(email, v),
                  validator: (value) => value?.validateEmail(),
                  hintText: 'johndoe@gmail.com',
                  title: 'Enter your Email',
                ),
                Gap.box(height: kfsTiny),
                TextFieldWidget(
                  onFieldSubmitted: (_) => _passwordNode.requestFocus(),
                  keyboardType: TextInputType.name,
                  focusNode: _userNameNode,
                  onSaved: (v) => context.auth.updateSignUpData(userName, v),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value?.validateAnyField(
                    field: 'User name required',
                  ),
                  hintText: 'Fiki',
                  title: 'Enter your user name',
                ),
                Gap.box(height: kfsTiny),
                TextFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  focusNode: _passwordNode,
                  onSaved: (v) => context.auth.updateSignUpData(password, v),
                  textInputAction: TextInputAction.done,
                  title: 'Enter password',
                  onFieldSubmitted: (_) => _submit(),
                  hintText: '*******',
                  validator: (value) => value?.validatePassword(value),
                ),
                Gap.box(height: kBig100),
                auth.isLoading
                    ? Button.loading(
                        onTap: () {},
                      )
                    : Button(
                        text: 'Continue',
                        onTap: () => _submit(),
                      ),
                Gap.box(height: kfsMedium),
                Align(
                  alignment: Alignment.center,
                  child: TwoSpanTextWidget(
                    'Already have an account?  ',
                    'Click here',
                    fontSize: kfsTiny,
                    fontSize2: kfsTiny,
                    textColor2: kPrimaryColor,
                    recognizer2: TapGestureRecognizer()
                      ..onTap =
                          () => AppRouter.instance.navigateTo(LoginView.route),
                  ),
                ),
                Gap.box(height: kBig100),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();

    _emailNode = FocusNode();
    _userNameNode = FocusNode();
    _passwordNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();

    _emailNode.dispose();
    _userNameNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      context.auth.signUp(context);
    }
  }
}
