import 'package:flutter/material.dart';

const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color black = Color.fromRGBO(0, 0, 0, 1);
const Color lightRed = Color.fromRGBO(255, 0, 0, 1);
const Color darkRed = Color.fromRGBO(128, 32, 0, 1);
const Color neutralDark = Color.fromRGBO(34, 50, 99, 1);
const Color neutralGray = Color.fromRGBO(144, 152, 177, 1);
const Color backgroundColor = Color.fromRGBO(92, 194, 219, 1);
class Themes{
  static final light = ThemeData(
    primaryColor: lightRed,
    backgroundColor: white,
    brightness: Brightness.light
  );
  static final dark = ThemeData(
      primaryColor: darkRed,
      backgroundColor: black,
      brightness: Brightness.dark
  );
}