import 'dart:io';
import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String? buttonText;
  VoidCallback onTap;
  Color? background, textColor;
  double? hPadding, vPadding, textSize;
  FontWeight? fontWeight;
  Widget? text;

  CustomButton(
      {this.buttonText,
      required this.onTap,
      this.background,
      this.textColor,
      this.hPadding,
      this.vPadding,
      this.fontWeight,
      this.text,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    TextStyle buttonTextStyle =
        TextStyle(fontWeight: fontWeight ?? FontWeight.w700, color: textColor ?? white, fontSize: textSize ?? 15);
    return (Platform.isIOS)
        ? CupertinoButton(
            padding: EdgeInsets.symmetric(vertical: vPadding ?? 16, horizontal: hPadding ?? 0),
            color: background ?? backgroundColor,
            child: text ??
                Text(
                  buttonText!,
                  style: buttonTextStyle,
                ),
            onPressed: onTap,
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          )
        : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(background ?? backgroundColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              padding:
                  MaterialStateProperty.all(EdgeInsets.symmetric(vertical: vPadding ?? 16, horizontal: hPadding ?? 0)),
            ),
            onPressed: onTap,
            child: text ??
                Text(
                  buttonText!,
                  style: buttonTextStyle,
                ),
          );
  }
}
