import 'package:flutter/material.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.validator,
    required this.controller,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          'Enter your user name',
          fontSize: kfsTiny,
          fontWeight: kW500,
        ),
        Gap.box(height: kfsTiny),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter your user name',
            border: _borderStyle,
            focusedBorder: _enabledBorder,
            enabledBorder: _borderStyle,
          ),
        ),
      ],
    );
  }

  InputBorder get _borderStyle => OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall10),
        borderSide: const BorderSide(color: kcBorder1),
      );

  InputBorder get _enabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(kSmall10),
        borderSide: const BorderSide(color: kPrimaryColor),
      );
}
