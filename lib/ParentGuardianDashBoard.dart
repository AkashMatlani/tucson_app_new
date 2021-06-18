import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class ParentDashBoardScreen extends StatefulWidget {
  @override
  _ParentDashBoardScreenState createState() => _ParentDashBoardScreenState();
}

class _ParentDashBoardScreenState extends State<ParentDashBoardScreen> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblCoolStuff,
      svgPicture: 'assets/images/cool_stuff.svg',
    ),
    GridListItems(
        name: LabelStr.lblStudentBlogs,
        svgPicture: 'assets/images/student_blog.svg'
    ),
    GridListItems(
        name: LabelStr.lblScholerShipInfo,
        svgPicture: 'assets/images/scholarship _Info.svg'
    ),
    GridListItems(
        name: LabelStr.lblMentalHealthSupport,
        svgPicture: 'assets/images/mental_health _support.svg'
    ),
    GridListItems(
        name: LabelStr.lblJobOpnings,
        svgPicture: 'assets/images/job_opnings.svg'
    ),
    GridListItems(
        name: LabelStr.lblEvents,
        svgPicture: 'assets/images/events.svg'
    ),
    GridListItems(
        name: LabelStr.lblVolunteerOpportunites,
        svgPicture: 'assets/images/volunteer_opportunities.svg'
    ),
    GridListItems(
        name: LabelStr.lblAwarity,
        svgPicture: 'assets/images/awarity.svg'
    ),
    GridListItems(
        name: LabelStr.lblLogout,
        svgPicture: 'assets/images/logout.svg'
    ),
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
                  height: 200,
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
            top: 150,
            left: 50,
            right: 50,
            child:
                GridView.builder(
                 physics: ScrollPhysics(),
                  shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: menuItems.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
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
                      ));
                    }),
            )
        ],
      ),
    );
  }
}

class GridListItems {
  String name;
  String svgPicture;

  GridListItems({
    required this.name,
    required this.svgPicture,
  });
}

