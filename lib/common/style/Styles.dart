import 'package:flutter/material.dart';

///颜色
class SetColors {
  ///主色调
  static const Color mainColor = Color(mainColorValue);
  static const int mainColorValue = 0xFF03A9F5;

  ///灰色
  static const Color lightLightGrey = Color(0xFFF5F5F5);
  static const Color lightGray = Color(0xFFEDEDED);
  static const Color darkGrey = Color(0xFFBABABA);
  static const Color darkDarkGrey = Color(0xFF8C8C8C);

  ///横线颜色灰色
  static const Color lineLightGray = Color(0xFFe0e0e0);

  ///分割线颜色
  static const Color dividerColor = Color(0xFFC1C1C1);
  static const Color dividerColor1 = Color(0xFFEFEFEF);

  ///主文字颜色值
  static const int defaultFontColorValue = 0xFF000000;

  static const Color gray = Color(0xFF767676);
  static const int grayValue = 0xFF767676;

  ///橙色
  static const Color orange = Color(orangeValue);
  static const int orangeValue = 0xFFFD8609;

  static const Color remarkColor = Color(0xFF22FF08);

  static const Color red = Colors.red;
  static const int redValue = 0xFFFF0000;

  ///浅海洋绿
  static const Color lightSeaGreen = Color(lightSeaGreenValue);
  static const int lightSeaGreenValue = 0xFF20B2AA;

  static const Color oneLevel = Color(0xFF2e9cc4);
  static const int oneLevelValue = 0xFF2e9cc4;
  static const Color twoLevel = Color(0xFF4bb7dd);
  static const int twoLevelValue = 0xFF4bb7dd;
  static const Color threeLevel = Color(0xFF3bafda);
  static const int threeLevelValue = 0xFF3bafda;

  static const Color selectLevel = Color(0xFF00668c);
  static const int selectLevelValue = 0xFF00668c;

  static const Color itemBodyColor = Color(0xFFeff9fd);
  static const int itemBodyColorValue = 0xFFeff9fd;

  static const Color completeColor = Color(0xFFFFB800);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color grey = Color(0xFF757575);

  static const Color transparent = Color(0x00000000);
}

///文本样式
class SetConstants {
  static const hugeTextSize = 28.0;
  static const veryLagerTextSize = 22.0;
  static const lagerTextSize = 20.0;
  static const bigTextSize = 18.0;
  static const middleTextSize = 16.0;
  static const normalTextSize = 14.0;
  static const smallTextSize = 12.0;
  static const bitSmallTextSize = 10.0;
}

class SetIcons {
  static const String DEFAULT_USER_ICON = 'assets/images/logo.png';
  static const String splash = 'assets/images/splash.png';
  static const String filter = 'assets/svg/filter.svg';
  static const String correct = 'assets/svg/correct.svg';
}
