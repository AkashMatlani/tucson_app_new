import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/CustomDropDownList.dart';
import 'package:tucson_app/GeneralUtils/CustomDropDownTwo.dart';
import 'package:tucson_app/GeneralUtils/HelperWidgets.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GetAllReasonModel.dart';
import 'package:tucson_app/Model/SchoolListResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';

class DropOutPostScreen extends StatefulWidget {
  @override
  _DropOutPostScreenState createState() => _DropOutPostScreenState();
}

class _DropOutPostScreenState extends State<DropOutPostScreen> {
  var _firstNameRefredByController = TextEditingController();
  var _lastNameRefredByController = TextEditingController();
  var _contactRefredByController = TextEditingController();
  var _firstNameStudentController = TextEditingController();
  var _lastNameStudentController = TextEditingController();
  var _tusdMaticNumberController = TextEditingController();
  var _gradeController = TextEditingController();
  List<SchoolListResponse> _schoolList = [];
  List<GetAllReasonModel> _allReasonList = [];
  late GetAllReasonModel getAllReasonModel;
  late SchoolListResponse _selectedSchool;
  String selectedSchoolName = 'select_school'.tr();
  String selectedReasonForServiceRequest =
      'select_reason_for_service_request'.tr();
  String? languageCode;

  //List<MailForDropOut> _mailForDropDown = [];
  bool isLoading = true;
  int schoolId = 0;
  int reasonRequest = 0;
  bool isHTML = false;

  @override
  void initState() {
    super.initState();
    getSharedPrefsData();
  }

  getSharedPrefsData() async {
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if (languageCode == null) {
      languageCode = "en";
    }
    Timer(Duration(milliseconds: 100), () => _getSchoolList());
    _getAllReason();
  }

/*  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: HexColor("#6462AA"),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.03,
                      0,
                      MediaQuery
                          .of(context)
                          .size
                          .height * 0.03),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon:
                            Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('drop_out_prevention_enroll_form'.tr(),
                            style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Colors.white)),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: HexColor("FAFAFA")),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.15,
            left: MediaQuery.of(context).size.height*0.012,
            right: MediaQuery.of(context).size.height*0.012,
            child: Container(
              height: MediaQuery.of(context).size.height*0.85,
              margin: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Referred by: ",
                        style: AppTheme.customTextStyle(
                            MyFont.SSPro_bold, 18.0, MyColor.darkLblTextColor())),
                    SizedBox(height: 20),
                    textFieldFor('first_name'.tr(), _firstNameRefredByController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name, autofocus: true ),
                    SizedBox(height: 10),
                    textFieldFor('last_name'.tr(), _lastNameRefredByController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,autofocus: true),
                    SizedBox(height: 10),
                    textFieldFor('contact_phone'.tr(), _contactRefredByController,
                        textInputAction: TextInputAction.next, keyboardType: TextInputType.number,autofocus: true),
                    SizedBox(height: 40),
                    Text('student_information'.tr(),
                        style: AppTheme.customTextStyle(
                            MyFont.SSPro_bold, 18.0, MyColor.darkLblTextColor())),
                    textFieldFor('first_name'.tr(), _firstNameStudentController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,autofocus: true),
                    SizedBox(height: 10),
                    textFieldFor('last_name'.tr(), _lastNameStudentController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,autofocus: true),
                    SizedBox(height: 10),
                    textFieldFor(
                        'tusd_matric_number'.tr(), _tusdMaticNumberController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,autofocus: true),
                    SizedBox(height: 10),
                    textFieldFor('grade'.tr(), _gradeController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,autofocus: true),
                    SizedBox(height: 10),
                    (_schoolList.isNotEmpty && _schoolList.length > 0)
                        ? Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          child: InkWell(
                            onTap: () {
                              //Utils.backWithNoTransition(context, CustomDropDownList(selectedSchoolName, _selectedSchool, _schoolList));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomDropDownList(
                                              selectedSchoolName,
                                              _selectedSchool,
                                              _schoolList))).then((value) {
                                if (value == null) {
                                  setState(() {
                                    selectedSchoolName =
                                        'select_school'.tr();
                                  });
                                } else {
                                  setState(() {
                                    _selectedSchool = value;
                                    selectedSchoolName =
                                        _selectedSchool.name;
                                  });
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width-31)*0.95,
                                  child: Text(selectedSchoolName,
                                      style:
                                      AppTheme.regularTextStyle()),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width-31)*0.05,
                                  child: Icon(Icons.arrow_forward_ios,
                                      size: 18, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 1.3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Colors.black45,
                        ),
                      ],
                    )
                        : Container(),
                    SizedBox(height: 20),
                    (_allReasonList.isNotEmpty && _allReasonList.length > 0)
                        ? Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          child: InkWell(
                            onTap: () {
                              //Utils.backWithNoTransition(context, CustomDropDownList(selectedSchoolName, _selectedSchool, _schoolList));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CustomDropDownListTwo(
                                              selectedReasonForServiceRequest,
                                              getAllReasonModel,
                                              _allReasonList))).then(
                                      (value) {
                                    if (value == null) {
                                      setState(() {
                                        selectedReasonForServiceRequest =
                                            'select_reason_for_service_request'
                                                .tr();
                                      });
                                    } else {
                                      setState(() {
                                        getAllReasonModel = value;
                                        selectedReasonForServiceRequest =
                                            getAllReasonModel.reason;
                                      });
                                    }
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width-31)*0.95,
                                  child: Text(selectedReasonForServiceRequest,
                                      style:
                                      AppTheme.regularTextStyle()),
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width-31)*0.05,
                                  child: Icon(Icons.arrow_forward_ios,
                                      size: 18, color: Colors.black54),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 1.3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          color: Colors.black45,
                        ),
                      ],
                    ) : Container(),
                    SizedBox(
                      height: 20,
                    ),
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
                                MyFont.SSPro_regular, 16.0, Colors.white)),
                        onPressed: () {
                          if (_firstNameRefredByController.text.isEmpty) {
                            Utils.showToast(
                                context, 'enter_first_name'.tr(), Colors.red);
                          } else if (_lastNameRefredByController.text.isEmpty) {
                            Utils.showToast(
                                context, 'enter_last_name'.tr(), Colors.red);
                          } else if (_contactRefredByController.text.isEmpty) {
                            Utils.showToast(context,
                                'enter_contact_phone'.tr(), Colors.red);
                          } else if (_firstNameStudentController.text.isEmpty) {
                            Utils.showToast(context,
                                'enter_student_first_name'.tr(), Colors.red);
                          } else if (_lastNameStudentController.text.isEmpty) {
                            Utils.showToast(context,
                                'enter_student_last_name'.tr(), Colors.red);
                          } else if (_lastNameStudentController.text.isEmpty) {
                            Utils.showToast(context,
                                'enter_tusd_matric_number'.tr(), Colors.red);
                          } else if (_gradeController.text.isEmpty) {
                            Utils.showToast(
                                context, 'enter_grade'.tr(), Colors.red);
                          } else {
                            getWebApiFromUrl(context);
                          }
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
    ));
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(MyImage.splashBg), fit: BoxFit.fill)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                color: HexColor("#6462AA"),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0,
                          MediaQuery.of(context).size.height * 0.03,
                          0,
                          MediaQuery.of(context).size.height * 0.03),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text('drop_out_prevention_enroll_form'.tr(),
                                style: AppTheme.customTextStyle(
                                    MyFont.SSPro_semibold, 18.0, Colors.white)),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0)),
                            color: HexColor("FAFAFA")),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                      ),
                    )
                  ],
                ),
              ),
              Positioned.fill(
                top: MediaQuery.of(context).size.height * 0.15,
                bottom: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                      color: HexColor("#f9f9f9")),
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('referred_by'.tr(),
                              style: AppTheme.customTextStyle(MyFont.SSPro_bold,
                                  18.0, MyColor.darkLblTextColor())),
                          SizedBox(height: 20),
                          textFieldFor(
                              'first_name'.tr(), _firstNameRefredByController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              autofocus: true),
                          SizedBox(height: 10),
                          textFieldFor(
                              'last_name'.tr(), _lastNameRefredByController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              autofocus: true),
                          SizedBox(height: 10),
                          textFieldFor(
                            'contact_phone'.tr(),
                            _contactRefredByController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            autofocus: true,
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(11)
                            ],
                          ),
                          SizedBox(height: 40),
                          Text('student_information'.tr(),
                              style: AppTheme.customTextStyle(MyFont.SSPro_bold,
                                  18.0, MyColor.darkLblTextColor())),
                          textFieldFor(
                              'first_name'.tr(), _firstNameStudentController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              autofocus: true),
                          SizedBox(height: 10),
                          textFieldFor(
                              'last_name'.tr(), _lastNameStudentController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              autofocus: true),
                          SizedBox(height: 10),
                          textFieldFor(
                            'tusd_matric_number'.tr(),
                            _tusdMaticNumberController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.numberWithOptions(signed: true),
                            autofocus: true,
                          ),
                          SizedBox(height: 10),
                          textFieldFor('grade'.tr(), _gradeController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              autofocus: true),
                          SizedBox(height: 10),
                          (_schoolList.isNotEmpty && _schoolList.length > 0)
                              ? Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          //Utils.backWithNoTransition(context, CustomDropDownList(selectedSchoolName, _selectedSchool, _schoolList));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomDropDownList(
                                                          selectedSchoolName,
                                                          _selectedSchool,
                                                          _schoolList))).then(
                                              (value) {
                                            if (value == null) {
                                              setState(() {
                                                selectedSchoolName =
                                                    'select_school'.tr();
                                              });
                                            } else {
                                              setState(() {
                                                _selectedSchool = value;
                                                selectedSchoolName =
                                                    _selectedSchool.name;
                                              });
                                            }
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(selectedSchoolName,
                                                  style: AppTheme
                                                      .regularTextStyle()),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                size: 18, color: Colors.black54)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 1.3,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.black45,
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(height: 20),
                          (_allReasonList.isNotEmpty &&
                                  _allReasonList.length > 0)
                              ? Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Container(
                                      child: InkWell(
                                        onTap: () {
                                          //Utils.backWithNoTransition(context, CustomDropDownList(selectedSchoolName, _selectedSchool, _schoolList));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomDropDownListTwo(
                                                          selectedReasonForServiceRequest,
                                                          getAllReasonModel,
                                                          _allReasonList))).then(
                                              (value) {
                                            if (value == null) {
                                              setState(() {
                                                selectedReasonForServiceRequest =
                                                    'select_reason_for_service_request'
                                                        .tr();
                                              });
                                            } else {
                                              setState(() {
                                                getAllReasonModel = value;
                                                selectedReasonForServiceRequest =
                                                    getAllReasonModel.reason;
                                              });
                                            }
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  selectedReasonForServiceRequest,
                                                  style: AppTheme
                                                      .regularTextStyle()),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                size: 18, color: Colors.black54)
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 1.3,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.black45,
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
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
                              child: Text('submit'.tr(),
                                  style: AppTheme.customTextStyle(
                                      MyFont.SSPro_regular,
                                      16.0,
                                      Colors.white)),
                              onPressed: () {
                                if (_firstNameRefredByController.text.isEmpty) {
                                  Utils.showToast(context,
                                      'enter_first_name'.tr(), Colors.red);
                                } else if (_lastNameRefredByController
                                    .text.isEmpty) {
                                  Utils.showToast(context,
                                      'enter_last_name'.tr(), Colors.red);
                                } else if (_contactRefredByController
                                    .text.isEmpty) {
                                  Utils.showToast(context,
                                      'enter_contact_phone'.tr(), Colors.red);
                                } else if (_firstNameStudentController
                                    .text.isEmpty) {
                                  Utils.showToast(
                                      context,
                                      'enter_student_first_name'.tr(),
                                      Colors.red);
                                } else if (_lastNameStudentController
                                    .text.isEmpty) {
                                  Utils.showToast(
                                      context,
                                      'enter_student_last_name'.tr(),
                                      Colors.red);
                                } /*else if (_lastNameStudentController
                                    .text.isEmpty) {
                                  Utils.showToast(
                                      context,
                                      'enter_tusd_matric_number'.tr(),
                                      Colors.red);
                                }*/ else if (_gradeController.text.isEmpty) {
                                  Utils.showToast(
                                      context, 'enter_grade'.tr(), Colors.red);
                                } else {
                                  getWebApiFromUrl(context);
                                }
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

  _getSchoolList() {
    Utils.showLoader(true, context);
    WebService.getAPICallWithoutParmas(WebService.schoolList).then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          _schoolList = [];
          setState(() {
            //_schoolList.add(SchoolListResponse(id: 0, name: LabelStr.lblSelectSchool, schoolCategoryId: 0, schoolCategoryName: "",  createdBy: 0,  createdOn: "",  updatedBy: 0,  updatedOn: ""));
            for (var data in response.body) {
              _schoolList.add(SchoolListResponse.fromJson(data));
            }
            _selectedSchool = _schoolList[0];
            if (languageCode!.compareTo("en") != 0) {
              _translateData();
            } else {
              Utils.showLoader(false, context);
            }
          });
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
        print(
            "******************** ${response.message} ************************");
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  _getAllReason() {
    Utils.showLoader(true, context);
    WebService.getAPICallWithoutParmas(WebService.getAllReason)
        .then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          _allReasonList = [];
          setState(() {
            //_schoolList.add(SchoolListResponse(id: 0, name: LabelStr.lblSelectSchool, schoolCategoryId: 0, schoolCategoryName: "",  createdBy: 0,  createdOn: "",  updatedBy: 0,  updatedOn: ""));
            for (var data in response.body) {
              _allReasonList.add(GetAllReasonModel.fromJson(data));
            }
            getAllReasonModel = _allReasonList[0];
            if (languageCode!.compareTo("en") != 0) {
              _translateData();
            } else {
              Utils.showLoader(false, context);
            }
          });
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
        print(
            "******************** ${response.message} ************************");
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  void _translateData() {
    List<String> schoolNameList = [];
    for (var data in _schoolList) {
      schoolNameList.add(data.name);
    }
    String schoolName = schoolNameList.join("===");
    WebService.translateApiCall(languageCode!, schoolName,
        (isSuccess, response) {
      if (isSuccess) {
        var resultArr = response.toString().split("===");
        List<SchoolListResponse> tempList = [];
        for (int i = 0; i < resultArr.length; i++) {
          tempList.add(SchoolListResponse(
              id: _schoolList[i].id,
              schoolCategoryId: _schoolList[i].schoolCategoryId,
              schoolCategoryName: _schoolList[i].schoolCategoryName,
              name: resultArr[i],
              createdBy: _schoolList[i].createdBy,
              createdOn: _schoolList[i].createdOn,
              updatedBy: _schoolList[i].updatedBy,
              updatedOn: _schoolList[i].updatedOn));
        }

        if (_schoolList.length == tempList.length) {
          setState(() {
            _schoolList = tempList;
            _selectedSchool = _schoolList[0];
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      Utils.showLoader(false, context);
    });
  }

  getWebApiFromUrl(BuildContext context) {
    Utils.showLoader(true, context);
    var params = {
      "referFirstName": _firstNameRefredByController.text,
      "referLastName": _lastNameRefredByController.text,
      "referContactPhone": _contactRefredByController.text,
      "studentFirstName": _firstNameStudentController.text,
      "studentLastName": _lastNameRefredByController.text,
      "tusdMatricNumber": _tusdMaticNumberController.text,
      "grade": _gradeController.text,
      "school": _selectedSchool.name,
      "reason": getAllReasonModel.reason
    };
    WebService.postAPICall(WebService.sendDropOutPrevantionEmail, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          setState(() {
            isLoading = false;
            Utils.showLoader(false, context);
            //  _mailForDropDown = [];
            //_schoolList.add(SchoolListResponse(id: 0, name: LabelStr.lblSelectSchool, schoolCategoryId: 0, schoolCategoryName: "",  createdBy: 0,  createdOn: "",  updatedBy: 0,  updatedOn: ""));
            /* for (var data in response.body["messages"]) {
              _mailForDropDown.add(MailForDropOut.fromJson(data));
            }*/

            // response.body[0]["messages"][0]["messageText"];

            Utils.showToast(context,
                response.body["messages"][0]["messageText"],Colors.green);
          });
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
    });
  }


}
