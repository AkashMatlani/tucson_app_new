import 'dart:async';
import 'dart:convert';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'package:tucson_app/ui/student/CalendarPage2.dart';
import 'package:tucson_app/ui/student/CoolStuffScreen.dart';
import 'package:http/http.dart' as http;
import '../DisplayWebview.dart';
import '../WebViewEmpty.dart';
import 'BlogScreen.dart';
import 'CalenderEvent.dart';
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
      name: LabelStr.lblCoolStuff,
      svgPicture: MyImage.coolStuffIcon,
    ),
    GridListItems(
        name: LabelStr.lblStudentBlogs, svgPicture: MyImage.studentIcon),
    GridListItems(
        name: LabelStr.lblScholerShipInfo, svgPicture: MyImage.scholarshipIcon),
    GridListItems(
        name: LabelStr.lblMentalHealthSupport,
        svgPicture: MyImage.mentalHealthIcon),
    GridListItems(name: LabelStr.lblJobOpnings, svgPicture: MyImage.jobsIcon),
    GridListItems(name: LabelStr.lblEvents, svgPicture: MyImage.eventIcon),
    GridListItems(
        name: LabelStr.lblVolunteerOpportunites,
        svgPicture: MyImage.volunteerIcon),
    GridListItems(name: LabelStr.lblAwarity, svgPicture: MyImage.awarityIcon),
    GridListItems(name: LabelStr.lblLogout, svgPicture: MyImage.logoutIcon),
  ];

  String language = "";
  String userName = "";
  late int schoolId;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getUserDataFromPref();
        setState(() {
          language = prefs.getString(PrefUtils.yourLanguage)!;
          userName = prefs.getString(PrefUtils.userFirstName)!;
          schoolId = prefs.getInt(PrefUtils.schoolId)!;
          dob = prefs.getString(PrefUtils.userDOB)!;
          if (schoolId == null) {
            schoolId = 0;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(LabelStr.lblHi,
                                    style: AppTheme.customTextStyle(
                                        MyFont.SSPro_regular,
                                        25.0,
                                        Colors.white)),
                                SizedBox(width: 5),
                                Text(userName,
                                    style: AppTheme.customTextStyle(
                                        MyFont.SSPro_semibold,
                                        25.0,
                                        Colors.white))
                              ],
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 60.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.limeAccent,
                                  size: 25.0,
                                ),
                                SizedBox(width: 5),
                                Text(language,
                                    style: AppTheme.regularTextStyle()
                                        .copyWith(color: Colors.white))
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
                                getSchoolType();
                              } else if (index == 1) {
                                Utils.navigateToScreen(context,
                                    BlogScreen(LabelStr.lblStudentBlogs));
                              } else if (index == 2) {
                                Utils.navigateToScreen(
                                    context, ScholarshipInfoScreen());
                              } else if (index == 3) {
                                getMentalSupportExistOrNot();
                                /*
                                }*/
                              } else if (index == 4) {
                                Utils.navigateToScreen(
                                    context, JobOpeningScreen());
                              } else if (index == 5) {
                                Utils.navigateToScreen(
                                    context, CalendarPage2());
                              } else if (index == 6) {
                                Utils.navigateToScreen(
                                    context, VolunteerOpportunitiesScreen());
                              } else if (index == 7) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "Awareity"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 8) {
                                _logoutFromApp(context);
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
                                          16.0, 12.0, 16.0, 8.0),
                                      child: SvgPicture.asset(
                                          menuItems[index].svgPicture)),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 12.0, 16.0, 8.0),
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
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
      background: Colors.red,
      backgroundRadius: 30,
    ));
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
          Utils.navigateToScreen(context, DisplayWebview(webUrl));
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      //Utils.showToast(context, LabelStr.serverError, Colors.red);
      Utils.navigateToScreen(context, WebViewEmpty());
    });
  }

  void getSchoolType() {
    Utils.showLoader(true, context);
    var params = {"schoolId": schoolId};
    WebService.postAPICall(WebService.getSchoolCategoryType, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        String schoolCategory = response.body["categoryName"];
        Utils.navigateToScreen(context, CoolStuffScreen(schoolCategory));
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((onError) {
      Utils.showLoader(false, context);
      Utils.showToast(context, LabelStr.connectionError, Colors.red);
    });
  }

  _logoutFromApp(BuildContext context) async {
    bool mentalPopUp = await PrefUtils.getValueFor(PrefUtils.mentalHealthpopUp);
    Utils.showLoader(true, context);
    PrefUtils.clearPref();
    Utils.showLoader(false, context);
    PrefUtils.setBoolValue(PrefUtils.mentalHealthpopUp, mentalPopUp);
    Utils.navigateWithClearState(context, SignInScreen());
  }

  Future<void> getMentalSupportExistOrNot() async {
    var url = WebService.baseUrl + WebService.getMentalSupportExist +"?id="+'$schoolId';
    print("Get Url :" + url);
    var postUri = Uri.parse(url);
    var headers = {"Content-Type": 'application/json'};
    var response;

    // String queryString = Uri().query;
      //var requestUrl = url + '?' + queryString;
      //var postUri = Uri.parse(url);
      response = await http.get(postUri, headers: headers);

    var result = response.body;
    if (response.statusCode == 200) {
      var jsValue = json.decode(result);
      bool value = jsValue["output"];
      if (value) {
        int age = Utils.calculateAge(DateTime.parse(dob));
        if (age >= 13) {
          Utils.navigateToScreen(context, MentalHealthSupportScreen());
        } else {
          Utils.showToast(
              context, LabelStr.lblMentalHealthUnderThirteen, Colors.red);
        }
      } else {
        Utils.showToast(context, LabelStr.lblNoMentalSupport, Colors.red);
      }
    } else {
      var jsValue = json.decode(response.body);
      var message = jsValue["errorMessage"];
      Utils.showToast(context, message, Colors.red);
    }
  }
}
