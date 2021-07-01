import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class BlogDetailsScreen extends StatefulWidget {
  @override
  _BlogDetailsScreenState createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
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
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 25),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(LabelStr.lblMentalHealthSupport,
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontSize: 18, color: Colors.white))
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
            top: MediaQuery.of(context).size.height*0.15,
            left: 15,
            right: 15,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Mar 23, 2021',style: AppTheme.regularTextStyle().copyWith(fontSize: 14,color: Color.fromRGBO(111, 111, 111, 1))),
                  SizedBox(height: 5),
                  Text('TUSD1 School Starts Tomorrow',style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 20.0, Color.fromRGBO(0, 0, 0, 1))),
                  SizedBox(height: 30),
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. In scelerisque urna sed arcu tincidunt cursus. Proin ac neque malesuada, luctus orci non, pellentesque justo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla egestas metus in sapien porttitor, at vestibulum dui porta. Nullam volutpat libero a purus maximus, sed pretium nulla volutpat. Nullam lobortis elit vel tortor condimentum, at fringilla sapien mollis. Phasellus ultricies malesuada nisl ut ornare. Donec in nulla neque. Aliquam vitae tincidunt arcu, fringilla convallis dui. Ut consequat ligula tellus, sit amet blandit mi rhoncus eu.',style: AppTheme.regularTextStyle().copyWith(fontSize: 14,color: Color.fromRGBO(111, 111, 111, 1))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
