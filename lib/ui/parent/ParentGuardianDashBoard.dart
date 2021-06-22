import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/BlogScreen.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/ui/parent/Event.dart';
import 'package:tucson_app/ui/parent/RequestForServiceScreen.dart';
import 'package:tucson_app/ui/parent/Resuorces.dart';
import 'package:tucson_app/ui/parent/SchoolPrograms.dart';
import 'Education.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';

class ParentDashBoardScreen extends StatefulWidget {
  @override
  _ParentDashBoardScreenState createState() => _ParentDashBoardScreenState();
}

class _ParentDashBoardScreenState extends State<ParentDashBoardScreen> {
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
        name: LabelStr.lblSchoolPrograms,
        svgPicture: MyImage.schoolProgramsIcon),
    GridListItems(
        name: LabelStr.lblRqForService, svgPicture: MyImage.requestServiceIcon),
    GridListItems(name: LabelStr.lblAwarity, svgPicture: MyImage.awarityIcon),
    GridListItems(name: LabelStr.lblLogout, svgPicture: MyImage.logoutIcon)
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
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:
                              Text("John Dave", style: TextStyle(fontSize: 25)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.pink,
                            size: 60.0,
                          ),
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
                              if (index == 0) {
                                Utils.navigateToScreen(context, Education());
                              } else if (index == 1) {
                                Utils.navigateToScreen(context, Event());
                              } else if (index == 2) {
                                Utils.navigateToScreen(context, Resources());
                              } else if (index == 4) {
                                Utils.navigateToScreen(context, SchoolPrograms());
                              } else if (index == 4) {
                                Utils.navigateToScreen(context, RequestForServiceScreen());
                              } else if (index == 1) {
                                Utils.navigateToScreen(context, Event());
                              } else if (index == 2) {
                                Utils.navigateToScreen(context, Resources());
                              } else if (index == 3) {
                                Utils.navigateToScreen(
                                    context, SchoolPrograms());
                              } else if (index == 4) {
                                Utils.navigateToScreen(
                                    context, RequestForServiceScreen());
                              } else if (index == 5) {
                                Utils.navigateToScreen(context, BlogScreen());
                              }
                            });
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: HexColor.cardBackground,
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
                              ))
                          /*  child:
                       Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*50,
                          child: Card(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                      ),
                        color: Colors.amberAccent,
                        child: Column(
                          children:[
                            SvgPicture.asset(menuItems[index].svgPicture),
                            SizedBox(height: 10,),
                            Container(
                              child: Text(menuItems[index].name),
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(15)),
                            ),

                          ]
                        ),
                      ))*/
                          );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
