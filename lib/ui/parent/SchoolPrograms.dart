import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/WebViewEmpty.dart';

import '../../GeneralUtils/LabelStr.dart';
import '../../Model/GridListItems.dart';
import '../DisplayWebview.dart';


class SchoolPrograms extends StatefulWidget {
  @override
  _SchoolProgramScreenState createState() => _SchoolProgramScreenState();
}

class _SchoolProgramScreenState extends State<SchoolPrograms> {
  late int schoolId;
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblCatlogOfSchools,
      svgPicture: MyImage.websiteIcon,
    ),
    GridListItems(name: 'massd'.tr(), svgPicture: MyImage.massdIcon),
    GridListItems(name: 'aassd'.tr(), svgPicture: MyImage.aasdIcon),
    GridListItems(name: 'nassd'.tr(), svgPicture: MyImage.nassdIcon),
    GridListItems(name: 'rssd'.tr(), svgPicture: MyImage.rssdIcon),
    GridListItems(name: 'apssd'.tr(), svgPicture: MyImage.apssdIcon),
    GridListItems(name: 'face'.tr(), svgPicture: MyImage.websiteIcon),
  ];

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    if(schoolId == null){
      schoolId = 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('schools_programs'.tr(),
                            style: AppTheme.regularTextStyle()
                                .copyWith(fontSize: 18, color: Colors.white)),
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
            top: MediaQuery.of(context).size.height * 0.20,
            left: MediaQuery.of(context).size.height * 0.03,
            right: MediaQuery.of(context).size.height * 0.03,
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
                              if (index == 0) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "CatalogofSchools"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 1) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "MASSD"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 2) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "AASSD"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 3) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "NASSD"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 4) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "RSSD"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 5) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "APSSD"
                                };
                                getWebApiFromUrl(context, params);
                              } else if (index == 6) {
                                var params = {
                                  "schoolId": schoolId,
                                  "roleId": 0,
                                  "contentTypeName": "FACE"
                                };
                                getWebApiFromUrl(context, params);
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
                                      padding:
                                          EdgeInsets.only(left: 12, top: 10),
                                      child: SvgPicture.asset(
                                        menuItems[index].svgPicture,
                                        height: 60,
                                        width: 60,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 8.0),
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
    );
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
}
