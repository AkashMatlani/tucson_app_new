import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'ColorExtension.dart';

class AppTheme {
  static TextStyle headerTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_semibold,
        fontSize: 18,
        color: Colors.black);
  }

  static TextStyle textFieldHintTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_regular,
        fontSize: 16,
        color: MyColor.hintTextColor());
  }

  static TextStyle regularSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_regular,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle mediumSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_medium,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle semiBoldSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_semibold,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle boldSFTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_bold,
        fontSize: 16,
        color: MyColor.normalTextColor());
  }

  static TextStyle sfProLightTextStyle() {
    return TextStyle(
        fontFamily: MyFont.SFPro_light,
        fontSize: 16,
        color:Colors.black);
  }
}

class MyFont {
  static const SFPro_medium = "SFPro_medium";
  static const SFPro_regular = "SFPro_regular";
  static const SFPro_semibold = "SFPro_semibold";
  static const SFPro_bold = "SFPro_bold";
  static const SFPro_light = "SFPro_light";
}

class MyImage {
  static const splashBgImage = "assets/bg_image/splash_bg.png";
  static const loginBgImage = "assets/bg_image/login_bg.png";
  static const noImagePlaceholder = "assets/bg_image/no_image_placeholder.png";
  static const profileHeaderBgImage = "assets/icons/profile_header_bg.svg";
  static const defaultProfile = "assets/icons/ic_default_user.svg";

  static const appLogoH = "assets/icons/app_logo_horizontal.svg";
  static const appLogoV = "assets/icons/app_logo_vertical.svg";
  static const ic_email = "assets/icons/ic_email.svg";
  static const ic_password = "assets/icons/ic_password.svg";
  static const ic_drawer = "assets/icons/ic_drawer.svg";
  static const ic_notification = "assets/icons/ic_notification.svg";
  static const ic_filter = "assets/icons/ic_filter.svg";
  static const ic_fill_circle = "assets/icons/ic_blue_circle.svg";
  static const ic_search = "assets/icons/ic_search.svg";
  static const ic_forword_blue = "assets/icons/ic_forword_blue.svg";
  static const ic_directory = "assets/icons/ic_directory.svg";
  static const ic_share = "assets/icons/ic_share.svg";
  static const ic_pdf_thumb = "assets/icons/ic_pdf_thumbnail.svg";
  static const ic_download = "assets/icons/ic_download.svg";
  static const ic_voice_chat = "assets/icons/ic_voice_chat.svg";
  static const ic_medical = "assets/icons/ic_medical.svg";
  static const ic_document = "assets/icons/ic_document.svg";
  static const ic_call_icons = "assets/icons/ic_call_icons.svg";

  static const home_icon = "assets/icons/ic_menu_home.svg";
  static const task_icon = "assets/icons/ic_menu_task.svg";
  static const icident_icon = "assets/icons/ic_menu_icident.svg";
  static const notification_icon = "assets/icons/ic_menu_notification.svg";
  static const profile_icon = "assets/icons/ic_menu_profile.svg";
  static const password_icon = "assets/icons/menu_password.svg";
  static const about_us_icon = "assets/icons/ic_menu_aboutUs.svg";
  static const logout_icon = "assets/icons/ic_menu_logout.svg";
  static const mic_icon = "assets/icons/mic.svg";
  static const equalizer_icon = "assets/icons/equalizer.svg";
  static const play_icon = "assets/icons/play.svg";
  static const ic_up_arrow = "assets/icons/ic_up_arrow.svg";
  static const ic_down_arrow = "assets/icons/ic_down_arrow.svg";
  static const ic_calender = "assets/icons/ic_calender.svg";
  static const ic_clock = "assets/icons/ic_clock.svg";
  static const ic_thumbUp = "assets/icons/ic_thumb_up.svg";
  static const ic_notification_icons = "assets/icons/ic_notification.png";
}

class MyColor {
  static Color hintTextColor() {
    return HexColor("#646464");
  }

  static Color normalTextColor() {
    return HexColor("#262626");
  }

  static Color textFieldBorderColor() {
    return HexColor("#D2D2D2");
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