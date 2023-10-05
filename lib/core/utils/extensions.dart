import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:i_called/core/constants/palette.dart';

extension ValidatingExtensions on String {
  String? validateAnyField({String? field}) {
    if (toString().isEmpty) {
      return '$field field is required ';
    } else {
      return null;
    }
  }
}

extension SvgExtension on String {
  SvgPicture get svg => SvgPicture.asset(
        this,
        fit: BoxFit.scaleDown,
        color: kcWhiteColor,
      );
}
