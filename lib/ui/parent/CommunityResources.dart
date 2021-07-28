import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/WebViewEmpty.dart';
import 'package:tucson_app/ui/student/ScholarshipInfoScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class CommunityResources extends StatefulWidget {

  String fromScreen;
  CommunityResources(this.fromScreen,this.sortLanguageCode);

  String sortLanguageCode;
  @override
  _CommunityResourcesScreenState createState() =>
      _CommunityResourcesScreenState();
}

class _CommunityResourcesScreenState extends State<CommunityResources> {

  List<GridListItems> menuItems = [
    GridListItems(
      name: 'community_food_bank'.tr(), svgPicture: MyImage.communityFoodBankIcon,
    ),
    GridListItems(
        name: 'autisum_society'.tr(), svgPicture: MyImage.autisumSocietyIcon),
    GridListItems(
        name: 'cooperative_extension'.tr(), svgPicture: MyImage.uaCooperativeIcon),
    GridListItems(
        name: 'scholarship'.tr(), svgPicture: MyImage.scholarshipIcon),
    GridListItems(
        name: 'family_resources_centers'.tr(),
        svgPicture: MyImage.familyResourcesCenter),
    GridListItems(
        name: 'clothing_bank'.tr(), svgPicture: MyImage.clothingBankIcon),
    GridListItems(
        name: 'tusd_counselling'.tr(), svgPicture: MyImage.tusdCounslingIcon),
    GridListItems(
        name: 'mckinney_vento'.tr(), svgPicture: MyImage.tusdMcVenttoIcon),
  ];

  String? languageCode;
  late int schoolId;

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(schoolId == null){
      schoolId = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
        textDirection: widget.sortLanguageCode.compareTo("ar") == 0
        ? ui.TextDirection.rtl
        : ui.TextDirection.ltr, child:Scaffold(
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
                        child: Text('resources'.tr(),
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
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "CommunityFoodBank"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 1) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "AutisumSociety"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 2) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "UACooperativeExtension"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 3) {
                              Utils.navigateToScreen(context, ScholarshipInfoScreen(widget.fromScreen));
                            } else if (index == 4) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "FamilyResourceCenters"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 5) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "ClothingBank"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 6) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "TUSDCounselling"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 7) {
                              var params = {
                                "schoolId": schoolId,
                                "roleId": 0,
                                "contentTypeName": "McKinneyVento"
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
    String webMethod;
    if(widget.fromScreen.compareTo("Parent") == 0){
      webMethod = WebService.parentContentByType;
    } else {
      webMethod = WebService.communityContentByType;
    }
    WebService.postAPICall(webMethod, params)
        .then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          String webUrl = response.body[0]["contentTransactionTypeJoin"][0]["objectPath"];
        //  Utils.navigateToScreen(context, DisplayWebview(webUrl));
          _launchURL(webUrl);
        } else {
          Utils.navigateToScreen(context, WebViewEmpty());
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      Utils.navigateToScreen(context, WebViewEmpty());
    });
  }

  void _launchURL(String path) async =>
      await canLaunch(path) ? await launch(path) : throw 'Could not launch $path';
}
