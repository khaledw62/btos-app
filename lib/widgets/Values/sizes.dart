import 'package:flutter/cupertino.dart';

class SizeConfig{
  static late MediaQueryData mediaQuery;
  static late double screenHeight;
  static late double screenWidth;
  static late Orientation orientation;

  void init(BuildContext context){
    mediaQuery = MediaQuery.of(context);
    screenHeight = mediaQuery.size.height-mediaQuery.padding.top;
    screenWidth = mediaQuery.size.width;
    orientation = mediaQuery.orientation;
  }
}