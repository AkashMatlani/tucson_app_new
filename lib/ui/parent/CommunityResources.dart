import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/WebViewEmpty.dart';


class CommunityResources extends StatefulWidget {
  @override
  _CommunityResourcesScreenState createState() => _CommunityResourcesScreenState();
}

class _CommunityResourcesScreenState extends State<CommunityResources> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblCommunityFoodBank,
      svgPicture: MyImage.educationalWebsiteIcon,
    ),
    GridListItems(
        name: LabelStr.lblAutisumSocitey, svgPicture: MyImage.videosIcon),
    GridListItems(
        name: LabelStr.lblUACoopertiveExtension, svgPicture: MyImage.activitesIcon),
    GridListItems(
        name: LabelStr.lblScholarship, svgPicture: MyImage.articlesIcon),
    GridListItems(
        name: LabelStr.lblFamilyResourcesCenters, svgPicture: MyImage.familyResourcesCenter),
    GridListItems(
        name: LabelStr.lblClothingBank, svgPicture: MyImage.blogsIcon),
    GridListItems(
        name: LabelStr.lbltusdCounselling, svgPicture: MyImage.blogsIcon),
    GridListItems(
        name: LabelStr.lblMckinneyVento, svgPicture: MyImage.blogsIcon),
  ];

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
                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.03, 0, MediaQuery.of(context).size.height*0.03),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(LabelStr.lblResources,
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
            top: MediaQuery.of(context).size.height*0.20,
            left: MediaQuery.of(context).size.height*0.03,
            right: MediaQuery.of(context).size.height*0.03,
            child: Container(
              height: MediaQuery.of(context).size.height*0.8,
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
                            if (index == 0) {
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "Community FoodBank"
                              };
                              getWebApiFromUrl(context, params);
                            } else if (index == 1) {
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "Autisum Society"
                              };
                              getWebApiFromUrl(context, params);
                            }else if (index == 2) {
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "UA Cooperative Extension"
                              };
                              getWebApiFromUrl(context, params);
                            }else if (index == 4) {
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "Family Resource Centers"
                              };
                              getWebApiFromUrl(context, params);
                            }else if (index == 5) {
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "Clothing Bank"
                              };
                              getWebApiFromUrl(context, params);
                            }else if (index == 6 ){
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "TUSD Counselling"
                              };
                              getWebApiFromUrl(context, params);
                            }else if (index == 7) {
                              var params = {
                                "schoolId": 13,
                                "roleId": 0,
                                "contentTypeName": "McKinney Vento"
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
                                          left: 20,top: 10,right: 20),
                                      child: SvgPicture.asset(
                                          menuItems[index].svgPicture,height: 50,width: 50,)),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 12.0, 16.0, 8.0),
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
                              )
                          )
                      );
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
          if(webUrl.isNotEmpty)
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
