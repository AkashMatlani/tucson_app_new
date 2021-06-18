import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.38,
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(MyImage.userGroupImg),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height*0.28,
              bottom: 0.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)
                    ),
                    color: HexColor("#f9f9f9")
                ),
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(LabelStr.lblSignIn, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                      SizedBox(height: 20),
                      Text(LabelStr.lblSignIn, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}