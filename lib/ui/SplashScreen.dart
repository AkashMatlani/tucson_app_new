import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
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

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getUserDataFromPref();
        if(prefs.containsKey(PrefUtils.isLoggedIn) && prefs.getBool(PrefUtils.isLoggedIn)!){
          String role = prefs.getString(PrefUtils.userRole)!;
          if(role.compareTo("Student") == 0){
            Utils.navigateReplaceToScreen(context, StudentDashboardScreen());
          } else if(role.compareTo("Community") == 0){
            Utils.navigateReplaceToScreen(context, CommunityDashboardScreen());
          } else {
            Utils.navigateReplaceToScreen(context, ParentDashBoardScreen());
          }
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
            image: DecorationImage(image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.fromLTRB(100, 80, 100, 0),
                child: Image.asset(MyImage.splashLogoImg),
              )
            ),
            Image.asset(MyImage.splashBottomImg, fit: BoxFit.fitWidth)
          ],
        ),
      ),
    );
  }
}