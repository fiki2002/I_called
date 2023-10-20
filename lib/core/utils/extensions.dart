import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_called/core/constants/palette.dart';
import 'package:i_called/features/auth/presentation/change-notifier/auth_notifier.dart';
import 'package:provider/provider.dart';

extension ValidatingExtensions on String {
  String? validateAnyField({String? field}) {
    if (toString().isEmpty) {
      return '$field field is required ';
    } else {
      return null;
    }
  }

  String? validateEmail() {
    if (toString().isEmpty) {
      return 'Email is required';
    }

    final pattern = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (pattern.hasMatch(this)) {
      return null;
    } else {
      return 'Invalid email';
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }

    // Your custom password validation logic here
    if (!value.isValidPassword()) {
      return 'Invalid password';
    }

    return null; // Return null if the validation succeeds
  }

  bool isValidPassword() {
    // Password must be at least 8 characters long
    if (length < 6) {
      return false;
    }

    // Password must contain at least one lowercase letter
    if (!RegExp(r'[a-z]').hasMatch(this)) {
      return false;
    }

    // Password must contain at least one uppercase letter
    if (!RegExp(r'[A-Z]').hasMatch(this)) {
      return false;
    }

    // Password must contain at least one digit
    if (!RegExp(r'[0-9]').hasMatch(this)) {
      return false;
    }

    // Password may contain special characters (you can customize this)
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this)) {
      return false;
    }

    // If all criteria are met, the password is considered valid
    return true;
  }
}

extension SvgExtension on String {
  SvgPicture get svg => SvgPicture.asset(
        this,
        fit: BoxFit.scaleDown,
        color: kPrimaryColor.withOpacity(.2),
      );
}

extension BuildContextNotifier on BuildContext {
  AuthNotifier get auth => Provider.of<AuthNotifier>(this, listen: false);
}
