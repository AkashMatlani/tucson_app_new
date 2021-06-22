import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';

import '../../GeneralUtils/LabelStr.dart';
import '../../Model/GridListItems.dart';

class SchoolPrograms extends StatefulWidget {
  @override
  _SchoolProgramScreenState createState() => _SchoolProgramScreenState();
}

class _SchoolProgramScreenState extends State<SchoolPrograms> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblCatlogOfSchools,
      svgPicture: MyImage.websiteIcon,
    ),
    GridListItems(name: LabelStr.lblMassd, svgPicture: MyImage.websiteIcon),
    GridListItems(name: LabelStr.lblAassd, svgPicture: MyImage.websiteIcon),
    GridListItems(name: LabelStr.lblNassd, svgPicture: MyImage.websiteIcon),
    GridListItems(name: LabelStr.lblRssd, svgPicture: MyImage.websiteIcon),
    GridListItems(name: LabelStr.lblApssd, svgPicture: MyImage.websiteIcon),
    GridListItems(name: LabelStr.lblFace, svgPicture: MyImage.websiteIcon),
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
                      Text(LabelStr.lblSchoolsPrograms,
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
                child: GridView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 340,
                        childAspectRatio: 1 / 0.9,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: menuItems.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: HexColor.cardBackground,
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.0, 12.0, 16.0, 8.0),
                                  child: SvgPicture.asset(
                                      menuItems[index].svgPicture)),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      menuItems[index].name,
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

