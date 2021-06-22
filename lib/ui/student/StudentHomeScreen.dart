import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/ui/parent/Education.dart';


class StudentHomeScreen extends StatefulWidget {
  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {

  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblCoolStuff,
      svgPicture: MyImage.coolStuffIcon,
    ),
    GridListItems(
        name: LabelStr.lblStudentBlogs,
        svgPicture: MyImage.studentIcon),
    GridListItems(
        name: LabelStr.lblScholerShipInfo,
        svgPicture: MyImage.scholarshipIcon),
    GridListItems(
        name: LabelStr.lblMentalHealthSupport,
        svgPicture: MyImage.mentalHealthIcon),
    GridListItems(
        name: LabelStr.lblJobOpnings,
        svgPicture: MyImage.jobsIcon),
    GridListItems(
        name: LabelStr.lblEvents,
        svgPicture: MyImage.eventIcon),
    GridListItems(
        name: LabelStr.lblVolunteerOpportunites,
        svgPicture: MyImage.volunteerIcon),
    GridListItems(
        name: LabelStr.lblAwarity,
        svgPicture: MyImage.awarityIcon),
    GridListItems(
        name: LabelStr.lblLogout,
        svgPicture: MyImage.logoutIcon),
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
                  height: MediaQuery.of(context).size.height*0.25,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("John Dave", style: TextStyle(fontSize: 25)),
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
                            topRight: Radius.circular(50.0)
                        ),
                        color: Colors.white
                    ),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.2,
            left: MediaQuery.of(context).size.width*0.08,
            right: MediaQuery.of(context).size.width*0.08,
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
                            setState(() {
                              // ontap of each card, set the defined int to the grid view index
                              if (index == 0) {
                                Utils.navigateToScreen(context, Education());
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
}
