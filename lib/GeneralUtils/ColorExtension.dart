import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {

  static HexColor cardBackground = HexColor("#efefef");
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class AppColors {
  static var mainThemeColor = MaterialColor(500, <int, Color>{
    50: Color.fromRGBO(230, 33, 41, 1),
    100: Color.fromRGBO(230, 33, 41, 1),
    200: Color.fromRGBO(230, 33, 41, 1),
    300: Color.fromRGBO(230, 33, 41, 1),
    400: Color.fromRGBO(230, 33, 41, 1),
    500: Color.fromRGBO(230, 33, 41, 1),
    600: Color.fromRGBO(230, 33, 41, 1),
    700: Color.fromRGBO(230, 33, 41, 1),
    800: Color.fromRGBO(230, 33, 41, 1),
    900: Color.fromRGBO(230, 33, 41, 1),
  });
}