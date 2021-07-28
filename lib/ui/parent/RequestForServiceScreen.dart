import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'DropoutPreventionScreen.dart';
import 'package:tucson_app/ui/WebViewEmpty.dart';
import 'package:tucson_app/ui/student/MentalHealthSupportScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
class RequestForServiceScreen extends StatefulWidget {
  RequestForServiceScreen(this.sortLanguageCodel);
  String sortLanguageCodel;
  @override
  _RequestForServiceScreenState createState() =>
      _RequestForServiceScreenState();
}

class _RequestForServiceScreenState extends State<RequestForServiceScreen> {
  late int schoolId;
  List<GridListItems> menuItems = [
    GridListItems(
      name: 'mental_health_support'.tr(),
      svgPicture: MyImage.mentalHealthIcon,
    ),
    /* GridListItems(
        name: 'student_services'.tr(), svgPicture: MyImage.studentServicesIcon),*/
    GridListItems(name: 'talk_it_out'.tr(), svgPicture: MyImage.takeItOut),
    GridListItems(name: 'dropout_prevention'.tr(), svgPicture: MyImage.dropOut),
    GridListItems(
        name: 'health_services'.tr(), svgPicture: MyImage.healthService),
    /* GridListItems(
        name: 'translation_services'.tr(), svgPicture: MyImage.translationServiceIcon),*/
    GridListItems(
        name: 'transportation'.tr(), svgPicture: MyImage.transporation),
  ];

  String? schoolCategory;
  String _languageSortCode = "en";

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    _languageSortCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
      if (schoolId == null) {
        schoolId = 0;
      }

  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
        textDirection: widget.sortLanguageCodel.compareTo("ar") == 0 ? ui.TextDirection.rtl : ui.TextDirection.ltr,
    child: Scaffold(
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
                      MediaQuery.of(context).size.height * 0.03,
                      0,
                      MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon:
                            Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('request_for_services'.tr(),
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
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.height * 0.03,
            right: MediaQuery.of(context).size.height * 0.03,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.87,
              child: SingleChildScrollView(
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: menuItems.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                          onTap: () {
                            if (index == 0) {
                              getSchoolType();
                            } else if (index == 1) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "TalkItOut"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 2) {
                              Utils.navigateToScreen(
                                  context, DropoutPreventionScreen());
                            } else if (index == 3) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "HealthServices"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 4) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "Transportation"
                              };
                              getWebApiFromUrl(context, params);
                            }
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
                                      padding: EdgeInsets.only(
                                          left: 20, top: 10, right: 20),
                                      child: SvgPicture.asset(
                                        menuItems[index].svgPicture,
                                        height: 50,
                                        width: 50,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 8.0, 16.0, 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          menuItems[index].name,
                                          style: AppTheme.regularTextStyle()
                                              .copyWith(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )));
                    }),
              ),
            ),
          )
        ],
      ),
    ));
  }

  getWebApiFromUrl(BuildContext context, Map<String, Object> params) {
    Utils.showLoader(true, context);
    WebService.postAPICall(WebService.parentContentByType, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          String webUrl =
              response.body[0]["contentTransactionTypeJoin"][0]["objectPath"];
          //  Utils.navigateToScreen(context, DisplayWebview(webUrl));
          _launchURL(webUrl);
        }
      } else {
        translateData(response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      Utils.navigateToScreen(context, WebViewEmpty());
    });
  }

  getSchoolType() {
    Utils.showLoader(true, context);
    var params = {"schoolId": schoolId};
    WebService.postAPICall(WebService.getSchoolCategoryType, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        schoolCategory = response.body["categoryName"];
        if (schoolCategory == null) {
          Utils.showToast(context, 'no_school_selected'.tr(), Colors.red);
        } else if (schoolCategory!.compareTo("High") == 0) {
          getMentalSupportExistOrNot();
        } else {
          Utils.showToast(context, 'school_not_support'.tr(), Colors.red);
        }
      } else {
        translateData(response.message, Colors.red);
      }
    }).catchError((onError) {
      Utils.showLoader(false, context);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  getMentalSupportExistOrNot() async {
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
        Utils.navigateToScreen(context, MentalHealthSupportScreen("Parent"));
      } else {
        Utils.showToast(context, 'school_not_support'.tr(), Colors.red);
      }
    } else {
      var jsValue = json.decode(response.body);
      translateData(jsValue["errorMessage"], Colors.red);
    }
  }

  translateData(String message, MaterialColor color){
    if(_languageSortCode.compareTo("en") != 0){
      if(_languageSortCode.compareTo("sr") == 0){
        _languageSortCode = "so";
      }
      WebService.translateApiCall(_languageSortCode, message, (isSuccess, response){
        if(isSuccess){
          Utils.showToast(context, response.toString(), color);
        } else {
          Utils.showToast(context, "Page Translation Failed", Colors.red);
        }
      });
    } else {
      Utils.showToast(context, message, Colors.red);
    }
  }

  void _launchURL(String path) async => await canLaunch(path)
      ? await launch(path)
      : throw 'Could not launch $path';
}
