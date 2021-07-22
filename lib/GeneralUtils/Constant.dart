import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
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

  static List<Color> headerColors = [HexColor("#6462AA"), HexColor("#EFBE61"), HexColor("#20C09E"), HexColor("#6462AA"), HexColor("#46747F"), HexColor("#EF6763"), HexColor("#4CA7DA")];
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
  static const passwordReset = "assets/images/bg_images/reset_pwd_header_bg.png";
  static const signup = "assets/images/bg_images/signup_header_bg.png";
  static const signIn = "assets/images/bg_images/signin_header_bg.png";
  static const forgotPassword = "assets/images/bg_images/forgot_pwd_header_bg.jpg";
  static const donationImg = "assets/images/bg_images/donation_img.svg";

  static const viewPwdIcon = "assets/images/icons/ic_visible.svg";
  static const hidePwdIcon = "assets/images/icons/ic_hide.svg";
  static const awarityIcon = "assets/images/icons/ic_awarity.svg";
  static const coolStuffIcon = "assets/images/icons/ic_cool_stuff.svg";
  static const eventIcon = "assets/images/icons/ic_event.svg";
  static const givingDonationIcon = "assets/images/icons/ic_donation.svg";
  static const tusdCounslingIcon = "assets/images/icons/ic_tusd_counsling.svg";
  static const tusdMcVenttoIcon = "assets/images/icons/ic_mcventto.svg";
  static const jobsIcon = "assets/images/icons/ic_jobs.svg";
  static const jobsOpening = "assets/images/icons/job_opnings.svg";
  static const logoutIcon = "assets/images/icons/ic_logout.svg";
  static const mentalHealthIcon = "assets/images/icons/ic_mental_health.svg";
  static const scholarshipIcon = "assets/images/icons/ic_scholarship.svg";
  static const studentIcon = "assets/images/icons/ic_student.svg";
  static const volunteerIcon = "assets/images/icons/ic_volunteer.svg";

  static const educationIcon = "assets/images/icons/ic_educational.svg";
  static const requestServiceIcon = "assets/images/icons/ic_request_service.svg";
  static const resourceIcon = "assets/images/icons/ic_resource.svg";
  static const schoolProgramsIcon = "assets/images/icons/ic_school_program.svg";
  static const smartChoiceIcon = "assets/images/icons/ic_smart_choice.svg";

  static const educationalWebsiteIcon="assets/images/icons/educational_website.svg";
  static const videosIcon ="assets/images/icons/videos.svg";
  static const activitesIcon="assets/images/icons/activites.svg";
  static const  articlesIcon= "assets/images/icons/articles.svg";
  static const  blogsIcon="assets/images/icons/blogs.svg";
  static const  calenderIcon="assets/images/icons/calender.svg";
  static const  universityIcon="assets/images/icons/parent_university.svg";
  static const  communityFoodBankIcon="assets/images/icons/community_food_bank.svg";
  static const autisumSocietyIcon="assets/images/icons/autisum_society.svg";
  static const uaCooperativeIcon="assets/images/icons/ua_cooperative.svg";
  static const scholarshipInfoIcon="assets/images/icons/scholarship_info.svg";
  static const familyResourcesCentersIcon="assets/images/icons/family_resources.svg";
  static const clothingBankIcon="assets/images/icons/clothing_bank.svg";
  static const websiteIcon="assets/images/icons/website.svg";
  static const massdIcon="assets/images/icons/ic_massd.svg";
  static const aasdIcon="assets/images/icons/ic_aasd.svg";
  static const nassdIcon="assets/images/icons/ic_nassd.svg";
  static const rssdIcon="assets/images/icons/ic_rssd.svg";
  static const apssdIcon="assets/images/icons/ic_apssd.svg";
  static const studentServicesIcon="assets/images/icons/student_services.svg";
  static const dropOutIcon="assets/images/icons/ic_dropout.svg";
  static const healthServiceIcon="assets/images/icons/ic_health_service.svg";
  static const translationServiceIcon="assets/images/icons/ic_translation_service.svg";
  static const transportationIcon="assets/images/icons/ic_transportation.svg";
  static const familyResourcesCenter="assets/images/icons/ic_family_resources_center.svg";
  static const takeItOut="assets/images/icons/ic_take_it_out.svg";
  static const dropOut="assets/images/icons/ic_drop_out.svg";
  static const healthService="assets/images/icons/ic_health_service.svg";
  static const transporation="assets/images/icons/ic_transporation.svg";

  static const listForwordIcon="assets/images/icons/ic_list_forword.svg";
  static const dummyIcon="assets/images/icons/ic_dummy.svg";
  static const volunteerOpportunities="assets/images/icons/volunteer_opportunities.svg";
  static const callIcon="assets/images/icons/ic_call.svg";
  static const messageIcon="assets/images/icons/ic_message.svg";
  static const healthSupportIcon="assets/images/icons/ic_health_support.svg";
  static const userChatIcon="assets/images/icons/ic_user_chat.svg";
  static const mentalHealthSupport="assets/images/icons/mental_health_support.svg";
  static const splashImage="assets/images/bg_images/launch_image.png";
  static const videoUrlImage = "assets/images/bg_images/default_video_thumb.png";
  static const audioUrlImage = "assets/images/bg_images/default_audio_thumb.jpg";
  static const articleThubmail = "assets/images/icons/article.svg";
  static const blogThubmail = "assets/images/icons/blog.svg";
  static const storiesThubmail = "assets/images/icons/stories.svg";
  static const youTubeThubmail = "assets/images/icons/youtube.svg";
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
  static List<Color> headerColors = [HexColor("#6462AA"), HexColor("#EFBE61"), HexColor("#20C09E"), HexColor("#6462AA"), HexColor("#46747F"), HexColor("#EF6763"), HexColor("#4CA7DA")];
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