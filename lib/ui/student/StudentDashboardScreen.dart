import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LanguageDropDownList.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/Model/StaticListItems.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'package:tucson_app/ui/student/CalendarEventScreen.dart';
import 'package:tucson_app/ui/student/CoolStuffScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../WebViewEmpty.dart';
import 'BlogScreen.dart';
import 'JobOpeningScreen.dart';
import 'MentalHealthSupportScreen.dart';
import 'ScholarshipInfoScreen.dart';
import 'VolunteerOpportunitiesScreen.dart';


class StudentDashboardScreen extends StatefulWidget {
  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  late String dob;
  bool allowClose = false;
  late List<GridListItems> menuItems = [
    GridListItems(
      name: 'cool_stuff'.tr(),
      svgPicture: MyImage.coolStuffIcon,
    ),
    GridListItems(name: 'student_blogs'.tr(), svgPicture: MyImage.studentIcon),
    GridListItems(
        name: 'scholarship_info'.tr(), svgPicture: MyImage.scholarshipIcon),
    GridListItems(
        name: 'mental_health_support'.tr(),
        svgPicture: MyImage.mentalHealthIcon),
    GridListItems(name: 'job_openings'.tr(), svgPicture: MyImage.jobsIcon),
    GridListItems(name: 'events'.tr(), svgPicture: MyImage.eventIcon),
    GridListItems(
        name: 'volunteer_opportunity'.tr(), svgPicture: MyImage.volunteerIcon),
    GridListItems(name: 'awareity'.tr(), svgPicture: MyImage.awarityIcon),
    GridListItems(name: 'sign_out'.tr(), svgPicture: MyImage.logoutIcon),
  ];

  String sortLanguageCode = "en";
  String languageName = "English";
  String firstName = "";
  String userProfile = "";
  String? schoolCategory;
  late int schoolId;
  bool languageChangeRequest = false;

  List<StaticListItems> languageList = [
    StaticListItems(name: "English", value: "en"),
    StaticListItems(name: "Arabic", value: "ar"),
    StaticListItems(name: "Somali", value: "so"),
    StaticListItems(name: "Spanish", value: "es"),
    StaticListItems(name: "Swahili", value: "sw"),
    StaticListItems(name: "Vietnamese", value: "vi")
  ];


  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 200), () {
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getUserDataFromPref();
        setState(() {
          sortLanguageCode = prefs.getString(PrefUtils.sortLanguageCode)!;
          languageName = prefs.getString(PrefUtils.yourLanguage)!;
          firstName = prefs.getString(PrefUtils.userFirstName)!;
          userProfile = prefs.getString(PrefUtils.userProfile)!;
          dob = prefs.getString(PrefUtils.userDOB)!;
          schoolId = prefs.getInt(PrefUtils.schoolId)!;
          if (schoolId == null) {
            schoolId = 0;
          }
          translateData(firstName, true);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: sortLanguageCode.compareTo("ar") == 0 ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: DoubleBack(
          condition: allowClose,
          onConditionFail: () {
            setState(() {
              allowClose = true;
            });
          },
          child: Stack(
            children: [
              Container(
                color: HexColor("#6462AA"),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('hi'.tr(),
                                        style: AppTheme.customTextStyle(
                                            MyFont.SSPro_regular,
                                            25.0,
                                            Colors.white)),
                                    Text(" "+firstName,
                                        style: AppTheme.customTextStyle(
                                            MyFont.SSPro_semibold,
                                            25.0,
                                            Colors.white))
                                  ],
                                )),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            margin: EdgeInsets.only(right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,
                                    imageUrl: userProfile,
                                    placeholder: (context, url) => new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.account_circle, color: Colors.white, size: 50),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        String translaterKey = await PrefUtils.getValueFor(PrefUtils.googleTranslateKey);
                                        if(translaterKey.isNotEmpty) {
                                          Utils.backWithNoTransition(context,
                                              LanguageDropDownList(
                                                  languageList, "Student",
                                                  StaticListItems(
                                                      name: languageName,
                                                      value: sortLanguageCode)));
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        child: Text(languageName, style: AppTheme.regularTextStyle().copyWith(color: Colors.white)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0)),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(20),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.08,
                right: MediaQuery.of(context).size.width * 0.08,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: SingleChildScrollView(
                    child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 20),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: menuItems.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  // ontap of each card, set the defined int to the grid view index
                                  if (index == 0) {
                                    getSchoolType(index);
                                  } else if (index == 1) {
                                    Utils.navigateToScreen(context, BlogScreen('student_blogs'.tr(), "Student"));
                                  } else if (index == 2) {
                                    Utils.navigateToScreen(context,
                                        ScholarshipInfoScreen("Student"));
                                  } else if (index == 3) {
                                    getSchoolType(index);
                                  } else if (index == 4) {
                                    Utils.navigateToScreen(
                                        context, JobOpeningScreen("Student"));
                                  } else if (index == 5) {
                                    Utils.navigateToScreen(
                                        context, CalendarEventScreen());
                                  } else if (index == 6) {
                                    Utils.navigateToScreen(context, VolunteerOpportunitiesScreen("Student"));
                                  } else if (index == 7) {
                                    var params = {
                                      "schoolId": schoolId,
                                      "roleId": 0,
                                      "contentTypeName": "Awareity"
                                    };
                                    getWebApiFromUrl(context, params);
                                  } else if (index == 8) {
                                    Utils.signoutAlert(context,
                                        (isSuccess, response) {
                                      if (isSuccess) {
                                        _logoutFromApp(context);
                                      }
                                    });
                                  }
                                });
                              },
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Color.fromRGBO(245, 246, 252, 1),
                                  elevation: 5,
                                  clipBehavior: Clip.antiAlias,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16.0, 10.0, 16.0, 8.0),
                                          child: SvgPicture.asset(
                                              menuItems[index].svgPicture)),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            16.0, 10.0, 16.0, 8.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            menuItems[index].name,
                                            style: AppTheme.regularTextStyle()
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )));
                        }),
                  ),
                ),
              ),
            ],
          ),
          waitForSecondBackPress: 5,
          textStyle: AppTheme.regularTextStyle().copyWith(color: Colors.white),
          background: HexColor("#6462AA"),
          backgroundRadius: 30,
        )),
      ),
    );
  }

  getWebApiFromUrl(BuildContext context, Map<String, Object> params) {
    Utils.showLoader(true, context);
    WebService.postAPICall(WebService.studentContentByType, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          String webUrl =
              response.body[0]["contentTransactionTypeJoin"][0]["objectPath"];
         // Utils.navigateToScreen(context, DisplayWebview(webUrl));
          _launchURL(webUrl);
        }
      } else {
        translateData(response.message, false);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      Utils.navigateToScreen(context, WebViewEmpty());
    });
  }

  void getSchoolType(int index) {
    Utils.showLoader(true, context);
    var params = {"schoolId": schoolId};
    WebService.postAPICall(WebService.getSchoolCategoryType, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        schoolCategory = response.body["categoryName"];
        if (index == 3) {
          if (schoolCategory!.compareTo("High") == 0) {
            getMentalSupportExistOrNot();
          } else {
            Utils.showToast(context, 'school_not_support'.tr(), Colors.red);
          }
        } else {
          Utils.navigateToScreen(context, CoolStuffScreen(schoolCategory!,sortLanguageCode));
        }
      } else {
        translateData(response.message, false);
      }
    }).catchError((onError) {
      Utils.showLoader(false, context);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  translateData(String text, bool isUserName) {
    if(sortLanguageCode.compareTo("en") != 0) {
      WebService.translateApiCall(sortLanguageCode, text, (isSuccess, response) {
        if (isSuccess) {
          if(isUserName) {
            setState(() {
              firstName = response.toString();
            });
          } else {
            Utils.showToast(context, response.toString(), Colors.red);
          }
        } else {
          Utils.showToast(context, "Page Translation Failed", Colors.red);
        }
      });
    }
  }

  _logoutFromApp(BuildContext context) async {
    Utils.showLoader(true, context);
    //bool mentalPopUpStudent = await PrefUtils.getValueFor(PrefUtils.mentalHealthpopUpForStudent);
    //bool mentalPopUpParent = await PrefUtils.getValueFor(PrefUtils.mentalHealthpopUpForParent);
    String apiKey = await PrefUtils.getValueFor(PrefUtils.googleTranslateKey);
    String langCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    String langName = await PrefUtils.getValueFor(PrefUtils.yourLanguage);
    PrefUtils.clearPref();
    //PrefUtils.setBoolValue(PrefUtils.mentalHealthpopUpForStudent, mentalPopUpStudent);
    //PrefUtils.setBoolValue(PrefUtils.mentalHealthpopUpForParent, mentalPopUpParent);
    PrefUtils.setStringValue(PrefUtils.sortLanguageCode, langCode);
    PrefUtils.setStringValue(PrefUtils.yourLanguage, langName);
    PrefUtils.setStringValue(PrefUtils.googleTranslateKey, apiKey);
    Utils.showLoader(false, context);
    Utils.navigateWithClearState(context, SignInScreen());
  }

  Future<void> getMentalSupportExistOrNot() async {
    var url = WebService.baseUrl +
        WebService.getMentalSupportExist +
        "?id=" +
        '$schoolId';
    print("Get Url :" + url);
    var postUri = Uri.parse(url);
    var headers = {"Content-Type": 'application/json'};
    var response;

    response = await http.get(postUri, headers: headers);

    var result = response.body;
    if (response.statusCode == 200) {
      var jsValue = json.decode(result);
      bool value = jsValue["output"];
      if (value) {
        int age = Utils.calculateAge(DateTime.parse(dob));
        if (age >= 13) {
          Utils.navigateToScreen(context, MentalHealthSupportScreen("Student"));
        } else {
          Utils.showToast(context, 'student_age_error'.tr(), Colors.red);
        }
      } else {
        Utils.showToast(context, 'school_not_support'.tr(), Colors.red);
      }
    } else {
      var jsValue = json.decode(response.body);
      translateData(jsValue["errorMessage"], false);
    }
  }

  void _launchURL(String path) async =>
      await canLaunch(path) ? await launch(path) : throw 'Could not launch $path';
}
