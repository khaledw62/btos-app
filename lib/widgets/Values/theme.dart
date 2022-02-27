import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);
const Color lightRed = Color.fromRGBO(255, 0, 0, 1);
const Color darkRed = Color.fromRGBO(128, 32, 0, 1);
const Color neutralDark = Color.fromRGBO(34, 50, 99, 1);
const Color neutralGray = Color.fromRGBO(144, 152, 177, 1);
const Color backgroundColor = Color.fromRGBO(92, 194, 219, 1);

class Themes {
  static final light = ThemeData(
      primaryColor: lightRed,
      backgroundColor: white,
      brightness: Brightness.light,
      focusColor: white,
      appBarTheme: const AppBarTheme(
        backgroundColor: white,
        foregroundColor: black,
      ));
  static final dark = ThemeData(
      primaryColor: darkRed,
      backgroundColor: black,
      brightness: Brightness.dark,
      focusColor: white,
      appBarTheme: const AppBarTheme(
        backgroundColor: black,
        foregroundColor: white,
      ));

  TextStyle get headingStyle {
    return const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: black);
  }

  TextStyle get subHeadingStyle {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: black);
  }

  TextStyle get subTitleStyle {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      color: Get.isDarkMode ? white : black,
    );
  }

  TextStyle get titleStyle {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? white : neutralDark,
    );
  }

  TextStyle get logoTitleStyle {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? white : neutralDark,
    );
  }

  TextStyle get logoSubTitleStyle {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? white : neutralDark,
    );
  }

  TextStyle get appbarTitle {
    return const TextStyle(color: black, fontSize: 16, fontWeight: FontWeight.w700);
  }
}
