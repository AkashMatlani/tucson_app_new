import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/ui/ForgotPwdScreen.dart';
import 'package:tucson_app/ui/community/CommunityDashboardScreen.dart';

import 'SignUpScreen.dart';
import 'parent/ParentGuardianDashBoard.dart';
import 'student/StudentDashboardScreen.dart';


class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  var _emailController = TextEditingController();
  var _pwdController = TextEditingController();
  String _outputLanguage = 'en';
  bool _showPwd = true;

  AuthViewModel _authViewModel = AuthViewModel();


  void _togglePwd() {
    setState(() {
      _showPwd = !_showPwd;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

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
              height: MediaQuery.of(context).size.height*0.33,
              alignment: Alignment.topCenter,
              child: Image.asset(MyImage.signIn),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height*0.33,
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
                        Text(LabelStr.lblSignIn, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                        SizedBox(height: 20),
                        Text(LabelStr.lblSigninEmail, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblSigninEmail, _emailController, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress),
                        SizedBox(height: 10),
                        Text(LabelStr.lblPassword, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblPassword, _pwdController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text, obscure:_showPwd, suffixIcon: InkWell(onTap:(){_togglePwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(_showPwd ? MyImage.hidePwdIcon : MyImage.viewPwdIcon)))),
                        SizedBox(height: 10),
                        Text(LabelStr.lblSelectLanguage, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(right: 8),
                          child: DropdownButton<String>(
                            value: _outputLanguage,
                            isExpanded: true,
                            itemHeight: 50,
                            isDense: true,
                            underline: Container(
                              height: 0,
                              color: Colors.black45,
                            ),
                            style: AppTheme.regularTextStyle(),
                            icon: Icon(                // Add this
                              Icons.keyboard_arrow_down,
                              color: HexColor("#CCCCCC"),// Add this
                            ),
                            items: <DropdownMenuItem<String>>[
                              DropdownMenuItem(
                                child: Text('English'),
                                value: 'en',
                              ),
                              DropdownMenuItem(
                                  child: Text('Arabic'),
                                  value: 'ar'
                              ),
                              DropdownMenuItem(
                                  child: Text('Kirundi'),
                                  value: 'ru'
                              ),
                              DropdownMenuItem(
                                  child: Text('Somali'),
                                  value: 'so'
                              ),
                              DropdownMenuItem(
                                  child: Text('Spanish'),
                                  value: 'es'
                              ),
                              DropdownMenuItem(
                                  child: Text('Swahili'),
                                  value: 'sw'
                              ),
                              DropdownMenuItem(
                                  child: Text('Vietnamese'),
                                  value: 'vi'
                              )
                            ],
                            onChanged: (value){
                              setState(() {
                                _outputLanguage = value.toString();
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height:1.3,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black45,
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
                            child: Text(LabelStr.lblSignIn.toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
                            onPressed: (){
                              FocusScope.of(context).requestFocus(FocusNode());
                              _signIn(context);
                            },
                          ),
                        ),
                        SizedBox(height: 5),
                        InkWell(
                          onTap: (){
                            FocusScope.of(context).requestFocus(FocusNode());
                            Utils.navigateToScreen(context, ForgotPwdScreen());
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            child: Text(LabelStr.lblForgotPwd.toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, HexColor("#5772A8"))),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(LabelStr.lblNoAcc, style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, HexColor("#383838"))),
                              InkWell(
                                  onTap: (){
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    Utils.navigateToScreen(context, SignUpScreen());
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(2, 5, 5, 5),
                                    child: Text(LabelStr.lblSignUp.toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, HexColor("#5772A8"))),
                                  )
                              )
                            ],
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
    );
  }

  _signIn(BuildContext context) async {
    var _email = _emailController.text.trim();
    var _password = _pwdController.text.trim();
    Utils.showLoader(true, context);
    _authViewModel.logInResult(_email, _password, (isValid, message) {
      Utils.showLoader(false, context);
      if(isValid){
        print("*************** Login Successful *****************");
        _getUserType();
      } else {
        Utils.showToast(context, message, Colors.red);
        print("*************** $message *****************");
      }
    });
  }

  _getUserType() async{
    String role = await PrefUtils.getValueFor(PrefUtils.userRole);
    if(role.compareTo(LabelStr.lblStudent) == 0){
      Utils.navigateReplaceToScreen(context, StudentDashboardScreen());
    } else if(role.compareTo(LabelStr.lblCommunity) == 0){
      Utils.navigateReplaceToScreen(context, CommunityDashboardScreen());
    } else {
      Utils.navigateReplaceToScreen(context, ParentDashBoardScreen());
    }
  }
}