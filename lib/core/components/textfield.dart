import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.validator,
    required this.controller,
    this.showDefault = true,
    this.hintText,
    this.keyboardType,
    this.inputFormats,
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool? showDefault;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormats;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        switch (showDefault) {
          true => Column(
              children: [
                const TextWidget(
                  'Enter your user name',
                  fontSize: kfsTiny,
                  fontWeight: kW500,
                ),
                Gap.box(height: kfsTiny),
              ],
            ),
          false => const SizedBox.shrink(),
          _ => const SizedBox.shrink(),
        },
        TextFormField(
          inputFormatters: inputFormats,
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: showDefault == true ? 'Enter your user name' : hintText,
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
