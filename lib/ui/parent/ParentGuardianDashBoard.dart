import 'dart:async';

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
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'package:tucson_app/ui/WebViewEmpty.dart';
import 'package:tucson_app/ui/parent/Event.dart';
import 'package:tucson_app/ui/parent/RequestForServiceScreen.dart';
import 'package:tucson_app/ui/parent/SchoolPrograms.dart';

import 'CommunityResources.dart';
import 'Education.dart';

class ParentDashBoardScreen extends StatefulWidget {
  @override
  _ParentDashBoardScreenState createState() => _ParentDashBoardScreenState();
}

class _ParentDashBoardScreenState extends State<ParentDashBoardScreen> {
  bool allowClose = false;
  late List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblEducation,
      svgPicture: MyImage.educationIcon,
    ),
    GridListItems(name: LabelStr.lblEvents, svgPicture: MyImage.eventIcon),
    GridListItems(
        name: LabelStr.lblResources, svgPicture: MyImage.resourceIcon),
    GridListItems(
        name: LabelStr.lblSmartChoice, svgPicture: MyImage.smartChoiceIcon),
    GridListItems(
        name: LabelStr.lblParentVUE, svgPicture: MyImage.smartChoiceIcon),
    GridListItems(
        name: LabelStr.lblSchoolPrograms,
        svgPicture: MyImage.schoolProgramsIcon),
    GridListItems(
        name: LabelStr.lblRqForService, svgPicture: MyImage.requestServiceIcon),
    GridListItems(name: LabelStr.lblAwarity, svgPicture: MyImage.awarityIcon),
    GridListItems(name: LabelStr.lblLogout, svgPicture: MyImage.logoutIcon)
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
            // message: "Press back again to exit",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 2 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                          itemCount: menuItems.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (index == 0) {
                                      Utils.navigateToScreen(
                                          context, Education());
                                    } else if (index == 1) {
                                      Utils.navigateToScreen(context, Event());
                                    } else if (index == 2) {
                                      Utils.navigateToScreen(context, CommunityResources("Parent"));
                                    } else if (index == 3) {
                                      var params = {
                                        "schoolId": 1,
                                        "roleId": 0,
                                        "contentTypeName": "SmartChoice"
                                      };
                                      getWebApiFromUrl(context, params);
                                    } else if (index == 4) {
                                      var params = {
                                        "schoolId": 1,
                                        "roleId": 0,
                                        "contentTypeName": "ParentVUE"
                                      };
                                      getWebApiFromUrl(context, params);
                                    } else if (index == 5) {
                                      Utils.navigateToScreen(
                                          context, SchoolPrograms());
                                    } else if (index == 6) {
                                      Utils.navigateToScreen(
                                          context, RequestForServiceScreen());
                                    } else if (index == 7) {
                                      var params = {
                                        "schoolId": 1,
                                        "roleId": 0,
                                        "contentTypeName": "Awareity"
                                      };
                                      getWebApiFromUrl(context, params);
                                    } else if (index == 8) {
                                      Utils.signoutAlert(context, (isSuccess, response){
                                        if(isSuccess){
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  .copyWith(
                                                      color: Colors.black),
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
            // default 2
            textStyle:
                AppTheme.regularTextStyle().copyWith(color: Colors.white),
            background: HexColor("#6462AA"),
            backgroundRadius: 30));
  }

  getWebApiFromUrl(BuildContext context, Map<String, Object> params) {
    Utils.showLoader(true, context);
    WebService.postAPICall(WebService.parentContentByType, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          String webUrl = response.body[0]["contentTransactionTypeJoin"][0]["objectPath"];
          Utils.navigateToScreen(context, DisplayWebview(webUrl));
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      Utils.navigateToScreen(context, WebViewEmpty());
    });
  }

  _logoutFromApp(BuildContext context) async {
    bool mentalPopUp = await PrefUtils.getValueFor(PrefUtils.mentalHealthpopUp);
    String langCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    String langName = await PrefUtils.getValueFor(PrefUtils.yourLanguage);
    Utils.showLoader(true, context);
    PrefUtils.clearPref();
    Utils.showLoader(false, context);
    PrefUtils.setBoolValue(PrefUtils.mentalHealthpopUp, mentalPopUp);
    PrefUtils.setStringValue(PrefUtils.sortLanguageCode, langCode);
    PrefUtils.setStringValue(PrefUtils.yourLanguage, langName);
    Utils.navigateWithClearState(context, SignInScreen());
  }
}
