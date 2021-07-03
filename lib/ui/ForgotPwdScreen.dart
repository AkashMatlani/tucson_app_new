

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/SignInScreen.dart';

class ForgotPwdScreen extends StatefulWidget {

  @override
  _ForgotPwdScreenState createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {

  var _emailController = TextEditingController();
  AuthViewModel _authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.backWithNoTransition(context, SignInScreen()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.38,
                alignment: Alignment.topCenter,
                child: Image.asset(MyImage.forgotPassword),
              ),
              Positioned.fill(
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.2,
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
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(LabelStr.lblForgotPwd.substring(
                              0, LabelStr.lblForgotPwd.length - 1),
                              style: AppTheme.customTextStyle(
                                  MyFont.SSPro_bold, 30.0,
                                  MyColor.darkLblTextColor())),
                          SizedBox(height: 20),
                          Text(LabelStr.lblEmail,
                              style: AppTheme.regularTextStyle().copyWith(
                                  fontSize: 14)),
                          textFieldFor(LabelStr.lblEmail, _emailController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress),
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: TextButton(
                              child: Text(LabelStr.lblSubmit,
                                  style: AppTheme.customTextStyle(
                                      MyFont.SSPro_bold, 16.0, Colors.white)),
                              onPressed: () {
                                FocusScope.of(context).requestFocus(
                                    FocusNode());
                                _forgotPassword(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _forgotPassword(BuildContext context) {
    String email = _emailController.text.toString();
    Utils.showLoader(true, context);
    _authViewModel.forgotPwdResult(email, (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          _emailController.text = "";
        });

        Utils.showAlertDialog(context, message, (success, response) {
          if (success) {
            Utils.navigateWithClearState(context, SignInScreen());
            //Utils.navigateToScreen(context, DisplayWebview(message));
          }
        });
      } else {
        Utils.showToast(context, message, Colors.red);
        print("*************** $message *****************");
      }
    });
  }
}