import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DonationScreen.dart';
import 'package:tucson_app/ui/community/CommunityDashboardScreen.dart';
import 'package:tucson_app/ui/parent/ParentGuardianDashBoard.dart';
import 'package:tucson_app/ui/student/StudentDashboardScreen.dart';

import 'parent/ParentGuardianDashBoard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late int userId;
  late String role;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getUserDataFromPref();
        if(prefs.containsKey(PrefUtils.isLoggedIn) && prefs.getBool(PrefUtils.isLoggedIn)!){
         role= prefs.getString(PrefUtils.userRole)!;
          userId=prefs.getInt(PrefUtils.userId)!;
        checkUserStatus();
        } else {
          Utils.navigateReplaceToScreen(context, DonationScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImage.splashImage), fit: BoxFit.fill)
        ),
      ),
    );
  }

  checkUserStatus() {
    Utils.showLoader(true, context);
    var params = {"Id": userId};
    WebService.postAPICall(WebService.getUserStatus, params).then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          Utils.showToast(context, "Success", Colors.green);
          if(role.compareTo("Student") == 0){
            Utils.navigateReplaceToScreen(context, StudentDashboardScreen());
          } else if(role.compareTo("Community") == 0){
            Utils.navigateReplaceToScreen(context, CommunityDashboardScreen());
          } else {
            Utils.navigateReplaceToScreen(context, ParentDashBoardScreen());
          }
        } else {
          Utils.showToast(context, "Failure", Colors.red);
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, LabelStr.serverError, Colors.red);
    });
  }
}