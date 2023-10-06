import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_called/core/constants/constants.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
    this.textSize,
    this.height,
    this.width,
    this.textFontWeight = kW700,
    this.circular = false,
    this.active = true,
  })  : busy = false,
        iconData = null,
        borderColor = null,
        iconSize = null,
        iconColor = null;

  const Button.withBorderLine({
    super.key,
    required this.text,
    required this.onTap,
    this.color = Colors.transparent,
    this.borderColor,
    this.textColor,
    this.textSize,
    this.height,
    this.width,
    this.textFontWeight = kW700,
    this.circular = false,
    this.active = true,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        iconColor = null;

  const Button.loading({
    super.key,
    this.onTap,
    this.color,
    this.height,
    this.width,
  })  : busy = true,
        iconData = null,
        text = null,
        textColor = null,
        textSize = kfsMedium,
        textFontWeight = null,
        iconSize = null,
        iconColor = null,
        borderColor = null,
        active = true,
        circular = false;

  const Button.smallSized({
    super.key,
    this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.textSize = kfsMedium,
    this.height,
    this.width,
    this.textFontWeight,
    this.circular = false,
    this.active = true,
  })  : busy = false,
        iconData = null,
        iconSize = null,
        borderColor = null,
        iconColor = null;

  const Button.icon({
    super.key,
    required this.iconData,
    required this.height,
    required this.width,
    this.onTap,
    this.color,
    this.iconColor,
    this.iconSize,
    this.circular = false,
    this.active = true,
  })  : busy = false,
        text = null,
        borderColor = null,
        textColor = null,
        textSize = kfsMedium,
        textFontWeight = null;

  final String? text;
  final IconData? iconData;
  final void Function()? onTap;
  final bool busy;
  final bool active;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final double? height;
  final double? width;
  final FontWeight? textFontWeight;
  final Color? iconColor;
  final double? iconSize;
  final bool circular;

  @override
  Widget build(BuildContext context) {
    const double defaultHeight = 45.0;
    final double defaultWidth = MediaQuery.of(context).size.width * 0.95;

    return SizedBox(
      height: (height ?? defaultHeight),
      width: (width ?? defaultWidth),
      child: TextButton(
        onPressed: () {
          if (active == false) return;

          onTap!();
        },
        style: getButtonStyle(),
        child: getButtonChild(),
      ),
    );
  }

  ButtonStyle getButtonStyle() {
    MaterialStateProperty<RoundedRectangleBorder> shape;

    if (circular) {
      shape = MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular((kfsMedium)),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      );
    } else {
      shape = MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular((5.0)),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
      );
    }

    MaterialStateProperty<Color> backgroundColor;
    if (busy) {
      backgroundColor = MaterialStateProperty.all(kPrimaryColor);
    } else if (active == false) {
      backgroundColor = MaterialStateProperty.all(kcBorderColor);
    } else {
      backgroundColor = MaterialStateProperty.all(color ?? kPrimaryColor);
    }

    return ButtonStyle(
      shape: shape,
      backgroundColor: backgroundColor,
    );
  }

  Widget getButtonChild() {
    if (text == null) {
      if (busy) {
        return const SizedBox(
          height: (21),
          width: (21),
          child: CircularProgressIndicator(
            color: Colors.white,
            // backgroundColor: Palette.buttonColor,
          ),
        );
      } else {
        return Icon(
          iconData,
          color: iconColor ?? Colors.white,
          size: iconSize ?? 20.0,
        );
      }
    } else {
      return Text(
        text ?? 'no text',
        style: GoogleFonts.raleway(
          fontWeight: textFontWeight,
          color: textColor ?? Colors.white,
          fontSize: (kfsMedium),
        ),
      );
    }
  }
}
