import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/CustomDropDownList.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:tucson_app/Model/SchoolListResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';


class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  AuthViewModel _authViewModel = AuthViewModel();

  var _fnameController = TextEditingController();
  var _lnameController = TextEditingController();
  var _dobController = TextEditingController();
  var _zipController = TextEditingController();
  var _emailController = TextEditingController();
  var _pwdController = TextEditingController();
  var _confPwdController = TextEditingController();
  var _filterController = TextEditingController();
  String _userType = 'Student';
  String _formattedDob = "";
  DateTime currentDate = DateTime.now();

  bool _showPwd = true;
  bool _showConfPwd = true;

  List<SchoolListResponse> _schoolList = [];
  Map<String, SchoolListResponse> selectedValueMap = Map();
  late SchoolListResponse _selectedSchool;
  FocusNode defaultField = FocusNode();
  String? languageCode;
  String selectedSchoolName = LabelStr.lblSelectSchool;

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
    Timer(Duration(milliseconds: 100), () => _getSchoolList());
  }

  void _togglePwd() {
    setState(() {
      _showPwd = !_showPwd;
    });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _toggleConfPwd() {
    setState(() {
      _showConfPwd = !_showConfPwd;
    });
    FocusScope.of(context).requestFocus(FocusNode());
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
                child: Image.asset(MyImage.signup),
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('sign_up'.tr(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 30.0, MyColor.darkLblTextColor())),
                          SizedBox(height: 20),
                          Text('sign_up_as'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(right: 8),
                            child: DropdownButton<String>(
                              value: _userType,
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
                                  child: Text('student'.tr()),
                                  value: 'Student',
                                ),
                                DropdownMenuItem(
                                    child: Text('parent_guardian'.tr()),
                                    value: 'Parent-Guardian'
                                ),
                                DropdownMenuItem(
                                    child: Text('community'.tr()),
                                    value: 'Community'
                                )
                              ],
                              onChanged: (value){
                                setState(() {
                                  _userType = value.toString();
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height:1.3,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black45,
                          ),
                          SizedBox(height: 10),
                          Text('first_name'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('first_name'.tr(), _fnameController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text, focusNode: defaultField),
                          SizedBox(height: 10),
                          Text('last_name'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('last_name'.tr(), _lnameController, textInputAction: TextInputAction.next, keyboardType: TextInputType.text),
                          SizedBox(height: 10),
                          _userType.compareTo(LabelStr.lblStudent)==0 ? Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('date_of_birth'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                            textFieldFor('select_dob'.tr(), _dobController, readOnly: true, onTap:(){_selectDate(context);}, suffixIcon: InkWell(onTap:(){_selectDate(context);},child: Icon(Icons.calendar_today_outlined, size: 24))),
                            SizedBox(height: 10)
                          ]) : Container(),
                          _userType.compareTo(LabelStr.lblParentGuardian)==0 ? Column(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('zip_code'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                              textFieldFor('zip_code'.tr(), _zipController, textInputAction: TextInputAction.next, keyboardType: TextInputType.number),
                              SizedBox(height: 10),
                            ],
                          ) : Container(),
                          Text(_userType.compareTo(LabelStr.lblStudent)==0?'tusd_email'.tr():'email'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor(_userType.compareTo(LabelStr.lblStudent)==0?'tusd_email'.tr():'email'.tr(), _emailController, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress),
                          SizedBox(height: 10),
                          Text('school_name'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          (_schoolList.isNotEmpty && _schoolList.length > 0) ? Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                /*margin: EdgeInsets.only(right: 8),
                                child: DropdownButton<SchoolListResponse>(
                                  value: _selectedSchool,
                                  isExpanded: true,
                                  itemHeight: 50,
                                  isDense: true,
                                  underline: Container(
                                    height: 0,
                                    color: Colors.white,
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
                                ),*/
                                child: InkWell(
                                  onTap: (){
                                    //Utils.backWithNoTransition(context, CustomDropDownList(selectedSchoolName, _selectedSchool, _schoolList));
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomDropDownList(selectedSchoolName, _selectedSchool, _schoolList))).then((value){
                                      setState(() {
                                        _selectedSchool = value;
                                        selectedSchoolName = _selectedSchool.name;
                                      });
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(child: Text(selectedSchoolName, style: AppTheme.regularTextStyle())),
                                      Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54)
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height:1.3,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.black45,
                              ),
                            ],
                          ) : Container(),
                          SizedBox(height: 10),
                          Text('password'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('password'.tr(), _pwdController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text, obscure:_showPwd, suffixIcon: InkWell(onTap:(){_togglePwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(_showPwd ? MyImage.hidePwdIcon : MyImage.viewPwdIcon)))),
                          SizedBox(height: 10),
                          Text('confirm_password'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 14)),
                          textFieldFor('confirm_password'.tr(), _confPwdController, textInputAction: TextInputAction.done, keyboardType: TextInputType.text, obscure:_showConfPwd, suffixIcon: InkWell(onTap:(){_toggleConfPwd();},child: Padding(padding: EdgeInsets.fromLTRB(10, 15, 0, 15), child: SvgPicture.asset(_showConfPwd ? MyImage.hidePwdIcon : MyImage.viewPwdIcon)))),
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
                              child: Text('sign_up'.tr().toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_bold, 16.0, Colors.white)),
                              onPressed: (){
                                FocusScope.of(context).requestFocus(FocusNode());
                                _signUp(context);
                              },
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.1),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('have_account'.tr(), style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, HexColor("#383838"))),
                                InkWell(
                                    onTap: (){
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Utils.navigateReplaceToScreen(context, SignInScreen());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(2, 5, 5, 5),
                                      child: Text('sign_in'.tr().toUpperCase(), style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, HexColor("#5772A8"))),
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

  _getSchoolList(){
    Utils.showLoader(true, context);
    WebService.getAPICallWithoutParmas(WebService.schoolList).then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          _schoolList = [];
          setState(() {
            //_schoolList.add(SchoolListResponse(id: 0, name: LabelStr.lblSelectSchool, schoolCategoryId: 0, schoolCategoryName: "",  createdBy: 0,  createdOn: "",  updatedBy: 0,  updatedOn: ""));
            for(var data in response.body){
              _schoolList.add(SchoolListResponse.fromJson(data));
            }
            _selectedSchool = _schoolList[0];
            if(languageCode!.compareTo("en") == 1){
              _translateData();
            } else{
              Utils.showLoader(false, context);
            }
          });
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
        print("******************** ${response.message} ************************");
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  void _translateData() {
    List<String> schoolNameList=[];
    for(var data in _schoolList){
      schoolNameList.add(data.name);
    }
    String schoolName = schoolNameList.join("==)");
    WebService.translateApiCall(languageCode!, schoolName, (isSuccess, response){
      if(isSuccess){
        var resultArr = response.toString().split("==)");
        List<SchoolListResponse> tempList = [];
        for(int i=0; i<resultArr.length; i++){
          tempList.add(SchoolListResponse(id: _schoolList[i].id,
              schoolCategoryId: _schoolList[i].schoolCategoryId,
              schoolCategoryName: _schoolList[i].schoolCategoryName,
              name: resultArr[i],
              createdBy: _schoolList[i].createdBy,
              createdOn: _schoolList[i].createdOn,
              updatedBy: _schoolList[i].updatedBy,
              updatedOn: _schoolList[i].updatedOn));
        }
        setState(() {
          _schoolList = [];
          _schoolList.addAll(tempList);
          _selectedSchool = _schoolList[0];
        });
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      Utils.showLoader(false, context);
    });
  }

  _signUp(BuildContext context){

    String fname = _fnameController.text;
    String lname = _lnameController.text;
    String email = _emailController.text;
    String password = _pwdController.text;
    String confirmPwd = _confPwdController.text;
    String zipCode = _zipController.text;

    Utils.showLoader(true, context);
    _authViewModel.signUpResult(_userType, fname, lname, _formattedDob, zipCode,  email, password, confirmPwd, _selectedSchool.id, (isSuccess, message) {
      Utils.showLoader(false, context);
      if(isSuccess){
        setState(() {
          _fnameController.text = "";
          _lnameController.text = "";
          _emailController.text = "";
          _pwdController.text = "";
          _confPwdController.text = "";
          _dobController.text = "";
          _selectedSchool = _schoolList[0];
        });
        FocusScope.of(context).requestFocus(defaultField);
        if (_userType.compareTo(LabelStr.lblStudent) == 0) {
          message = 'student_registered'.tr();
        } else if (_userType.compareTo(LabelStr.lblCommunity) == 0) {
          message = 'community_registered'.tr();
        } else {
          message = 'parent_registered'.tr();
        }
        Utils.showAlertDialog(context, message, (success, response){
          if(success) {
            Utils.navigateReplaceToScreen(context, SignInScreen());
          }
        });
      } else {
        if(languageCode!.compareTo("en") == 1) {
          WebService.translateApiCall(
              languageCode!, message, (isSuccess, response) {
            if (isSuccess) {
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1920),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        _formattedDob = DateFormat("yyyy-MM-dd'T'hh:mm:ss").format(currentDate);
        _dobController.text = Utils.convertDate(_formattedDob, DateFormat("MM-dd-yyyy"));
      });
  }
}