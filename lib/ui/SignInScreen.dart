import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/ForgotPwdScreen.dart';
import 'package:tucson_app/ui/community/CommunityDashboardScreen.dart';
import 'package:tucson_app/ui/student/StudentDashboardScreen.dart';

import 'SignUpScreen.dart';
import 'parent/ParentGuardianDashBoard.dart';


class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  var _emailController = TextEditingController();
  var _pwdController = TextEditingController();
  String _languageSortCode = "en";
  String _languageName = "English";
  bool _showPwd = true;

  AuthViewModel _authViewModel = AuthViewModel();

  void _togglePwd() {
    setState(() {
      _showPwd = !_showPwd;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefsData();
    _emailController.text="pamela.leeper12@yopmail.com";
    _pwdController.text="12345678";
    _emailController.selection = TextSelection.fromPosition(TextPosition(offset: _emailController.text.length));
   /* _emailController.text="akash.maltani@dashtechinc.com";
    _pwdController.text="12345678";*/
   /* _emailController.text="Test@gmail.com";
    _pwdController.text="12345678";*/
   /*  _emailController.text="pamela.leeper12@yopmail.com";
    _pwdController.text="12345678";*/
  }

  getSharedPrefsData() async {
    var code = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(code == null){
      code = "en";
    }
    setState(() {
      _languageSortCode = code;
      context.setLocale(Locale(_languageSortCode, 'US'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                child: Image.asset(MyImage.signIn),
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
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('sign_in'.tr(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                          SizedBox(height: 20),
                          Text('email'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('email'.tr(), _emailController, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress),
                          SizedBox(height: 10),
                          Text('password'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('password'.tr(), _pwdController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text, obscure:_showPwd, suffixIcon: InkWell(onTap:(){_togglePwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(_showPwd ? MyImage.hidePwdIcon : MyImage.viewPwdIcon)))),
                          SizedBox(height: 10),
                          Text('select_language'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            child: DropdownButton<String>(
                              value: _languageSortCode,
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
                                  _languageSortCode = value.toString();
                                  context.setLocale(Locale(_languageSortCode, 'US'));

                                  if(_languageSortCode.compareTo("en") == 0){
                                    _languageName = "English";
                                  } else if(_languageSortCode.compareTo("ar") == 0){
                                    _languageName = "Arabic";
                                  } else if(_languageSortCode.compareTo("so") == 0){
                                    _languageName = "Somali";
                                  } else if(_languageSortCode.compareTo("es") == 0){
                                    _languageName = "Spanish";
                                  }  else if(_languageSortCode.compareTo("sw") == 0){
                                    _languageName = "Swahili";
                                  }  else if(_languageSortCode.compareTo("vi") == 0){
                                    _languageName = "Vietnamese";;
                                  }
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
                              child: Text('sign_in'.tr().toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
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
                              child: Text('forgot_password'.tr().toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, HexColor("#5772A8"))),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.03),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('no_account'.tr(), style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, HexColor("#383838"))),
                                InkWell(
                                    onTap: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Utils.navigateToScreen(context, SignUpScreen());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(2, 5, 5, 5),
                                      child: Text('sign_up'.tr().toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, HexColor("#5772A8"))),
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
        PrefUtils.setStringValue(PrefUtils.yourLanguage, _languageName);
        PrefUtils.setStringValue(PrefUtils.sortLanguageCode, _languageSortCode);
        _getUserType();
      } else {
        if(_languageSortCode.compareTo("en") == 1){
          WebService.translateApiCall(_languageSortCode, message, (isSuccess, response){
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

  _getUserType() async{
    String role = await PrefUtils.getValueFor(PrefUtils.userRole);
    if(role.compareTo(LabelStr.lblStudent) == 0){
      Utils.navigateWithClearState(context, StudentDashboardScreen());
    } else if(role.compareTo(LabelStr.lblCommunity) == 0){
      Utils.navigateWithClearState(context, CommunityDashboardScreen());
    } else {
      Utils.navigateWithClearState(context, ParentDashBoardScreen());
    }
  }
}