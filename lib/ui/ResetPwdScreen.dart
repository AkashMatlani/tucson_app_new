import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';


class ResetPwdScreen extends StatefulWidget {

  ResetPwdScreen(this.email);
  String email;

  @override
  _ResetPwdScreenState createState() => _ResetPwdScreenState();
}

class _ResetPwdScreenState extends State<ResetPwdScreen> {

  var _newPwdController = TextEditingController();
  var _confPwdController = TextEditingController();

  bool _showNewPwd = true;
  bool _showConfPwd = true;
  String? languageCode;

  void _toggleNewPwd() {
    setState(() {
      _showNewPwd = !_showNewPwd;
    });
  }

  void _toggleConfPwd() {
    setState(() {
      _showConfPwd = !_showConfPwd;
    });
  }

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
      onWillPop: ()=> Utils.backWithNoTransition(context, SignInScreen()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  alignment: Alignment.topCenter,
                  child: Image.asset(MyImage.passwordReset),
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).size.height*0.25,
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
                          Text('reset_password'.tr(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                          SizedBox(height: 20),
                          Text('new_password'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('new_password'.tr(), _newPwdController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, obscure:_showNewPwd, suffixIcon: InkWell(onTap:(){_toggleNewPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
                          SizedBox(height: 10),Text('confirm_password'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('confirm_password'.tr(), _confPwdController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, obscure:_showConfPwd, suffixIcon: InkWell(onTap:(){_toggleConfPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
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
                              child: Text('submit'.tr(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
                              onPressed: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                resetYourPwd(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetYourPwd(BuildContext context) {
    Utils.showLoader(true, context);
    String newPwd = _newPwdController.text.toString();
    String confirmPwd = _confPwdController.text.toString();
    AuthViewModel _authViewModel = AuthViewModel();
    _authViewModel.resetPwdResult(widget.email, newPwd, confirmPwd, (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        Utils.showToast(context, 'reset_successfully'.tr(), Colors.green);
        Timer(Duration(seconds: 2), (){
          Utils.navigateReplaceToScreen(context, SignInScreen());
        });
      } else {
        if(languageCode!.compareTo("en") != 0){
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
      }
    });
  }
}