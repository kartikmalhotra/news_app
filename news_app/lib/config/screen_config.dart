import 'package:flutter/widgets.dart';

abstract class AppScreenConfig {
  static double? screenHeight;
  static double? screenWidth;
  static double? appBarHeight;

  static initializeScreenConfig(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    screenWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;
  }
}
