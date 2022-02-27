import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomSocialButton extends StatelessWidget {
  String buttonText, logoPath;
  VoidCallback onTap;

  CustomSocialButton({required this.buttonText, required this.logoPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Get.isDarkMode ? white :backgroundColor.withOpacity(0.2),
        child: SvgPicture.asset(logoPath),
      ),
    );
  }

  TextStyle buttonTextStyle = const TextStyle(fontWeight: FontWeight.w700, color: white);
}
