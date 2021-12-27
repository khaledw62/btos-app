import 'dart:io';
import 'package:btos/widgets/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  VoidCallback onTap;
  CustomButton({required this.buttonText,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: backgroundColor,
            child: Text(
              buttonText,
              style: buttonTextStyle,
            ),
            onPressed: onTap,
          )
        : ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
              padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16))
            ),
            onPressed: onTap,
            child: Text(
              buttonText,
              style: buttonTextStyle,
            ),
          );
  }

  TextStyle buttonTextStyle = const TextStyle(fontWeight: FontWeight.w700, color: white);
}
