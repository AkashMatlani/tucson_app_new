import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/ui/DonationScreen.dart';
import 'package:tucson_app/ui/student/CoolStuffScreen.dart';

import 'parent/ParentGuardianDashBoard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => Utils.navigateReplaceToScreen(context, DonationScreen()));
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