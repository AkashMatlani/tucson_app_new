import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'dart:ui' as ui;

class ForgotPwdScreen extends StatefulWidget {

  @override
  _ForgotPwdScreenState createState() => _ForgotPwdScreenState();
}

class _ForgotPwdScreenState extends State<ForgotPwdScreen> {

  var _emailController = TextEditingController();
  AuthViewModel _authViewModel = AuthViewModel();
  String? languageCode;

  @override
  void initState() {
    super.initState();
    getSharedPrefsData();
  }

  getSharedPrefsData() async {
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(languageCode == null){
      languageCode = "en";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Utils.backWithNoTransition(context, SignInScreen()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  Directionality(
      textDirection: languageCode?.compareTo("ar") == 0
          ? ui.TextDirection.rtl
          : ui.TextDirection.ltr,
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
                      .height * 0.3,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    children: [
                      Image.asset(MyImage.forgotPassword),
                      Positioned(
                        top: MediaQuery.of(context).size.height*0.04,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.25,
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
                            Text('forgot_password'.tr().substring(0, 'forgot_password'.tr().length - 1),
                                style: AppTheme.customTextStyle(
                                    MyFont.SSPro_bold, 30.0,
                                    MyColor.darkLblTextColor())),
                            SizedBox(height: 20),
                            Text('email'.tr(),
                                style: AppTheme.regularTextStyle().copyWith(
                                    fontSize: 14)),
                            textFieldFor('email'.tr(), _emailController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.emailAddress,isRtl: languageCode?.compareTo("ar") == 0
                                  ? true
                                  : false,),
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
                                child: Text('submit'.tr(),
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
      ),
    ));
  }

  _forgotPassword(BuildContext context) {
    String email = _emailController.text.toString();
    Utils.showLoader(true, context);
    _authViewModel.forgotPwdResult(email, (isSuccess, message) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        Utils.showAlertDialog(context, 'check_mail_for_reset_pwd'.tr(), (success, response){
          if(success) {
            Utils.navigateReplaceToScreen(context, SignInScreen());
          }
        });
        //Utils.navigateWithClearState(context, ResetPwdScreen(email));
      } else {
        if(languageCode!.compareTo("en") != 0){
          if(languageCode!.compareTo("sr") == 0){
            languageCode = "so";
          }
          WebService.translateApiCall(languageCode!, message, (isSuccess, response){
            if(isSuccess){
              Utils.showToast(context, response.toString(), Colors.red);
            } else {
              Utils.showToast(context, "Page Translation Failed", Colors.red);
            }
          });
        } else {
          Utils.showToast(context, message, Colors.red);
        }
        print("*************** $message *****************");
      }
    });
  }
}