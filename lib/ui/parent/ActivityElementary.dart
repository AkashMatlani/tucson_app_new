import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/ui/BlogDetailsScreen.dart';

class ActivityElementary extends StatefulWidget {
  @override
  _ActivityElementaryState createState() => _ActivityElementaryState();
}

class _ActivityElementaryState extends State<ActivityElementary> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblMentalHealthSupport,
      svgPicture: MyImage.mentalHealthSupport,
    ),
    GridListItems(
        name: LabelStr.lblStudentServices,
        svgPicture: MyImage.studentServicesIcon),
    GridListItems(
        name: LabelStr.lblTakeItOut,
        svgPicture: MyImage.mentalHealthSupport),
    GridListItems(
        name: LabelStr.lblDroupOutPrevention, svgPicture: MyImage.dropOutIcon),
    GridListItems(
        name: LabelStr.lblHealthServices,
        svgPicture: MyImage.healthServiceIcon),
    GridListItems(
        name: LabelStr.lblTranslationServices,
        svgPicture: MyImage.translationServiceIcon),
    GridListItems(
        name: LabelStr.lblTransporation,
        svgPicture: MyImage.transportationIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Positioned(
            top: 130,
            left: 25,
            right: 25,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: new ListView.builder(
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () {
                        Utils.navigateToScreen(context, BlogDetailsScreen());
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                color: Colors.red,
                                width: MediaQuery.of(context).size.height,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Mar 23, 2021',
                                  style: AppTheme.regularTextStyle().copyWith(
                                      fontSize: 14,
                                      color: Color.fromRGBO(111, 111, 111, 1)),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 20),
                                child: Text(
                                    'TUSD1 Desire Wheeler Interscholastics Director',
                                    style: AppTheme.customTextStyle(
                                        MyFont.SSPro_bold,
                                        20.0,
                                        Color.fromRGBO(0, 0, 0, 1))))
                          ]),
                    );
                  }),
            ),
          )),
    );
  }
}
