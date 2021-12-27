import 'dart:io';
import 'package:btos/widgets/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialButton extends StatelessWidget {
  String buttonText,logoPath;

  CustomSocialButton({required this.buttonText,required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 5),
            color: Theme.of(context).backgroundColor,
            child: ListTile(
              title: Text(
                buttonText,
                style: buttonTextStyle,
              ),
              leading: SvgPicture.asset(logoPath),
            ),
            onPressed: () {},
          )
        : ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 5))),
            onPressed: () {},
            child: ListTile(
              title: Text(
                buttonText,
                style: buttonTextStyle,
              ),
              leading: SvgPicture.asset(logoPath),
            ),
          );
  }

  TextStyle buttonTextStyle = const TextStyle(fontWeight: FontWeight.w700, color: neutralGray);
}
