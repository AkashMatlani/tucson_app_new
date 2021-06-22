import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

import 'Model/GridListItems.dart';

class BlogScreen extends StatefulWidget
{
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblMentalHealthSupport,
      svgPicture: 'assets/images/mental_health _support.svg',
    ),
    GridListItems(name: LabelStr.lblStudentServices, svgPicture: MyImage.studentServicesIcon),
    GridListItems(name: LabelStr.lblTakeItOut, svgPicture: 'assets/images/mental_health _support.svg'),
    GridListItems(name: LabelStr.lblDroupOutPrevention, svgPicture: MyImage.dropOutIcon),
    GridListItems(name: LabelStr.lblHealthServices, svgPicture: MyImage.healthServiceIcon),
    GridListItems(name: LabelStr.lblTranslationServices, svgPicture: MyImage.translationServiceIcon),
    GridListItems(name: LabelStr.lblTransporation, svgPicture: MyImage.transportationIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 25),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(LabelStr.lblBlogs,
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontSize: 18, color: Colors.white))
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
            top: 130,
            left: 25,
            right: 25,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: SingleChildScrollView(
               child: new ListView.builder
                 (
                   itemCount: menuItems.length,
                   itemBuilder: (BuildContext ctxt, int index) {
                     return new Text(menuItems[index].name);
                   })
              ),
            ),
          )
        ],
      ),
    );
  }
}

