import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/ui/SignInScreen.dart';

class SignInOptionScreen extends StatefulWidget {
  @override
  _SignInOptionScreenState createState() => _SignInOptionScreenState();
}

class _SignInOptionScreenState extends State<SignInOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    HexColor("#6462AA"),
                    HexColor("#4CA7DA"),
                    HexColor("#20B69E"),
                  ],
                ),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                child: Text(LabelStr.lblStudentOpt, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 20.0, Colors.white)),
                onPressed: (){
                  Utils.navigateToScreen(context, SignInScreen());
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    HexColor("#6462AA"),
                    HexColor("#4CA7DA"),
                    HexColor("#20B69E"),
                  ],
                ),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                child: Text(LabelStr.lblParentOpt, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 20.0, Colors.white)),
                onPressed: (){
                  Utils.navigateToScreen(context, SignInScreen());
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    HexColor("#6462AA"),
                    HexColor("#4CA7DA"),
                    HexColor("#20B69E"),
                  ],
                ),
              ),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                child: Text(LabelStr.lblCommunityOpt, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 20.0, Colors.white)),
                onPressed: (){
                  Utils.navigateToScreen(context, SignInScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
