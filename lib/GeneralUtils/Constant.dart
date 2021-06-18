import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'ColorExtension.dart';

class AppTheme {
  static TextStyle regularTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SSPro_regular,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle hintTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SSPro_regular,
        fontSize: 16,
        color: MyColor.hintTextColor());
  }

  static TextStyle customTextStyle(fontFamily, size, color) {
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        color: color);
  }
}

class MyFont {
  static const SSPro_bold = "SSPro_bold";
  static const SSPro_regular = "SSPro_regular";
  static const SSPro_semibold = "SSPro_semibold";
}

class MyImage {
  static const splashBg = "assets/images/bg_images/splash_bg.png";
  static const splashLogoImg = "assets/images/bg_images/splash_logo.png";
  static const splashBottomImg = "assets/images/bg_images/splash_bottom_img.png";
  static const userGroupImg = "assets/images/bg_images/user_group.svg";
}

class MyColor {
  static Color hintTextColor() {
    return HexColor("#A5A5A5");
  }

  static Color darkLblTextColor() {
    return HexColor("#3A3A3A");
  }

  static Color normalTextColor() {
    return HexColor("#323643");
  }

  static Color textFieldBorderColor() {
    return HexColor("#E1E3E8");
  }

  static Color backgroundColor() {
    return HexColor("#F8F8F7");
  }
}

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

class ValidationResult {
  var message = "";
  var isValid = false;

  ValidationResult(this.isValid, this.message);
}