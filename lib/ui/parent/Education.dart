import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/ArticlesScreen.dart';
import 'package:tucson_app/ui/EducationalWebsiteScreen.dart';
import 'package:tucson_app/ui/student/BlogScreen.dart';
import 'package:tucson_app/ui/student/VideoListScreen.dart';

import 'ActivitesScreen.dart';


class Education extends StatefulWidget {


  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<Education> {
   int schoolId=0;
  List<GridListItems> menuItems = [
    GridListItems(
      name: 'educational_website'.tr(), svgPicture: MyImage.educationalWebsiteIcon,
    ),
    GridListItems(name: 'videos'.tr(), svgPicture: MyImage.videosIcon),
    GridListItems(
        name: 'activites'.tr(), svgPicture: MyImage.activitesIcon),
    GridListItems(name: 'articles'.tr(), svgPicture: MyImage.articlesIcon),
    GridListItems(name: 'blogs'.tr(), svgPicture: MyImage.blogsIcon),
  ];

   String? schoolCategory;
  @override
  void initState() {
    super.initState();
/*

    Timer(Duration(milliseconds: 100), () async {
     // schoolId=PrefUtils.getValueFor(PrefUtils.schoolId) as String;
      print("schoolId-"+PrefUtils.getValueFor(PrefUtils.schoolId).toString());
      schoolId = PrefUtils.getInt(PrefUtils.schoolId)!;
      getSchoolType(0);
    });
*/

    Timer(Duration(milliseconds: 200), () {
      SharedPreferences.getInstance().then((prefs) async {
        PrefUtils.getUserDataFromPref();
        setState(() {
          schoolId = prefs.getInt(PrefUtils.schoolId)!;
          if (schoolId == null) {
            schoolId = 0;
          }
          getSchoolType();
        });
      });
    });

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
                        child: Text('education'.tr(),
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
                            if (index == 0) {
                              Utils.navigateToScreen(context, EducationalWebsiteScreen());
                            }
                            else if (index == 1) {
                              Utils.navigateToScreen(context, VideoListScreen('videos'.tr(),"Parent"));
                            }
                            else if (index == 2) {
                             // Utils.navigateToScreen(context, BlogScreen('activites'.tr(),"Parent"));
                              Utils.navigateToScreen(context, ActivitesScreen(schoolCategory!));
                            }
                            else if (index == 3) {
                              Utils.navigateToScreen(context, BlogScreen('articles'.tr(),"Parent"));
                            }
                            else if (index == 4) {
                              Utils.navigateToScreen(context, BlogScreen('blogs'.tr(),"Parent"));
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
                                      padding: EdgeInsets.fromLTRB(
                                          16.0, 10.0, 16.0, 8.0),
                                      child: SvgPicture.asset(
                                          menuItems[index].svgPicture)),
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

   void getSchoolType() {
     Utils.showLoader(true, context);
     var params = {"schoolId": 13};
     WebService.postAPICall(WebService.getSchoolCategoryType, params)
         .then((response) {
       Utils.showLoader(false, context);
       if (response.statusCode == 1) {
         schoolCategory = response.body["categoryName"];
         print("category Type-->>"+schoolCategory.toString());
     /*    if (index == 3) {
           if (schoolCategory!.compareTo("High") == 0) {
             getMentalSupportExistOrNot();
           } else {
             Utils.showToast(context, 'school_not_support'.tr(), Colors.red);
           }
         } else {
           Utils.navigateToScreen(context, CoolStuffScreen(schoolCategory!));
         }*/
       } else {
         Utils.showToast(context, response.message, Colors.red);
       }
     }).catchError((onError) {
       Utils.showLoader(false, context);
       Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
     });
   }
}
