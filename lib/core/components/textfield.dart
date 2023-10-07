import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_called/core/components/components.dart';
import 'package:i_called/core/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.validator,
    this.showDefault = true,
    this.hintText,
    this.keyboardType,
    this.inputFormats,
    this.title,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted, this.onSaved,
  });

  final String? Function(String?)? validator;
  final bool? showDefault;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormats;
  final String? title;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          title ?? 'Enter your user name',
          fontSize: kfsTiny,
          fontWeight: kW500,
        ),
        Gap.box(height: kfsTiny),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          focusNode: focusNode,
          inputFormatters: inputFormats,
          keyboardType: keyboardType,
          onSaved: onSaved ,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter your user name',
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
