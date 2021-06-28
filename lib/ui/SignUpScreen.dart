import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/Model/SchoolListResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';


class SignUpScreen extends StatefulWidget {

  SignUpScreen(this.loginType);
  String  loginType;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  AuthViewModel _authViewModel = AuthViewModel();

  var _fnameController = TextEditingController();
  var _lnameController = TextEditingController();
  var _dobController = TextEditingController();
  var _emailController = TextEditingController();
  var _pwdController = TextEditingController();
  var _confPwdController = TextEditingController();
  String _userType = 'Student';
  String _formattedDob = "";
  DateTime currentDate = DateTime.now();

  bool _showPwd = true;
  bool _showConfPwd = true;

  List<SchoolListResponse> _schoolList = [];
  late SchoolListResponse _selectedSchool;

  @override
  void initState() {
    super.initState();
    setState(() {
      _fnameController.text = "john";
      _lnameController.text = "smith";
      _emailController.text = "john@gmail.com";
      _pwdController.text = "12345678";
      _confPwdController.text = "12345678";
      _formattedDob = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(currentDate);
      _dobController.text = Utils.convertDate(_formattedDob, DateFormat("MM-dd-yyyy"));
    });
    Timer(Duration(milliseconds: 100), () => _getSchoolList());
  }

  void _togglePwd() {
    setState(() {
      _showPwd = !_showPwd;
    });
  }

  void _toggleConfPwd() {
    setState(() {
      _showConfPwd = !_showConfPwd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.38,
              alignment: Alignment.topCenter,
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
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(LabelStr.lblSignUp, style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                        SizedBox(height: 20),
                        Text(LabelStr.lblSignUpAs, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        DropdownButton<String>(
                          value: _userType,
                          isExpanded: true,
                          itemHeight: 50,
                          underline: Container(
                            height: 1.3,
                            color: Colors.black45,
                          ),
                          style: AppTheme.regularTextStyle(),
                          icon: Icon(                // Add this
                            Icons.keyboard_arrow_down,
                            color: HexColor("#CCCCCC"),// Add this
                          ),
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              child: Text(LabelStr.lblStudent),
                              value: LabelStr.lblStudent,
                            ),
                            DropdownMenuItem(
                                child: Text(LabelStr.lblParent),
                                value: LabelStr.lblParent
                            ),
                            DropdownMenuItem(
                                child: Text(LabelStr.lblCommunity),
                                value: LabelStr.lblCommunity
                            )
                          ],
                          onChanged: (value){
                            setState(() {
                              _userType = value.toString();
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Text(LabelStr.lblFname, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblFname, _fnameController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                        SizedBox(height: 10),
                        Text(LabelStr.lblLname, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblLname, _lnameController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                        SizedBox(height: 10),
                        Text(LabelStr.lbldob, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lbldob, _dobController, readOnly: true, suffixIcon: InkWell(onTap:(){_selectDate(context);},child: Icon(Icons.calendar_today_outlined, size: 24))),
                        SizedBox(height: 10),
                        Text(LabelStr.lblEmail, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblEmail, _emailController, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress),
                        SizedBox(height: 10),
                        Text(LabelStr.lblSchoolName, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        _schoolList.length > 0 ? DropdownButton<SchoolListResponse>(
                          value: _schoolList[0],
                          isExpanded: true,
                          itemHeight: 50,
                          underline: Container(
                            height: 1.3,
                            color: Colors.black45,
                          ),
                          style: AppTheme.regularTextStyle(),
                          icon: Icon(                // Add this
                            Icons.keyboard_arrow_down,
                            color: HexColor("#CCCCCC"),// Add this
                          ),
                          items: _schoolList.map<DropdownMenuItem<SchoolListResponse>>((SchoolListResponse schoolDetails){
                            return DropdownMenuItem(
                                child: Text(schoolDetails.name),
                                value: schoolDetails
                            );
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              _selectedSchool = value!;
                            });
                          },
                        ) : Container(),
                        SizedBox(height: 10),
                        Text(LabelStr.lblPassword, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblPassword, _pwdController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, obscure:_showPwd, suffixIcon: InkWell(onTap:(){_togglePwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
                        SizedBox(height: 10),
                        Text(LabelStr.lblConfirmPwd, style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                        textFieldFor(LabelStr.lblConfirmPwd, _confPwdController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text, obscure:_showConfPwd, suffixIcon: InkWell(onTap:(){_toggleConfPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(MyImage.viewPwdIcon)))),
                        SizedBox(height: 30),
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
                            child: Text(LabelStr.lblSignUp.toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
                            onPressed: (){
                              _signUp(context);
                            },
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(LabelStr.lblAccExist, style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, HexColor("#383838"))),
                              SizedBox(width: 2),
                              InkWell(
                                  onTap: (){
                                    Utils.navigateReplaceToScreen(context, SignInScreen(widget.loginType));
                                  },
                                  child: Text(LabelStr.lblSignIn.toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, HexColor("#5772A8")))
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

  _getSchoolList(){
    Utils.showLoader(true, context);
    WebService.getAPICall(WebService.schoolList, {}).then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          _schoolList = [];
          setState(() {
            for(var data in response.body){
              _schoolList.add(SchoolListResponse.fromJson(data));
            }
          });
        }
        Utils.showLoader(false, context);
      } else {
        Utils.showLoader(false, context);
        print("******************** ${response.message} ************************");
      }
    }).catchError((error) {
      print(error);
      print("******************** ${LabelStr.serverError} ************************");
    });
  }

  _signUp(BuildContext context){

    String fname = _fnameController.text;
    String lname = _lnameController.text;
    String email = _emailController.text;
    String password = _pwdController.text;
    String confirmPwd = _confPwdController.text;

    Utils.showLoader(true, context);
    _authViewModel.signUpResult(_userType, fname, lname, _formattedDob, email, password, confirmPwd, _selectedSchool.id, (isSuccess, message) {
      Utils.showLoader(false, context);
      if(isSuccess){
        print("*************** User registered *****************");
        Utils.navigateReplaceToScreen(context, SignInScreen(widget.loginType));
      } else {
        print("*************** $message *****************");
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1960),
        lastDate: currentDate);
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        _formattedDob = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(currentDate);
        _dobController.text = Utils.convertDate(_formattedDob, DateFormat("MM-dd-yyyy"));
      });
  }
}