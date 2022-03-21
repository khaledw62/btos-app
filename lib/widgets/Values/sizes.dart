import 'package:flutter/cupertino.dart';

class SizeConfig {
  MediaQueryData mediaQuery;
  double screenHeight;
  double screenWidth;
  Orientation orientation;

  SizeConfig({
    required this.screenHeight,
    required this.mediaQuery,
    required this.orientation,
    required this.screenWidth,
  });

  factory SizeConfig.init(BuildContext context) {
    MediaQueryData a = MediaQuery.of(context);
    return SizeConfig(
      screenHeight: a.size.height - a.padding.top,
      mediaQuery: a,
      orientation: a.orientation,
      screenWidth: a.size.width,
    );
  }
}
