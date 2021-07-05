import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/GridListItems.dart';

import 'BlogScreen.dart';
import 'VideoListScreen.dart';

class MiddleHighStuff extends StatefulWidget {
  @override
  _MiddleHighStuffState createState() => _MiddleHighStuffState();
}

class _MiddleHighStuffState extends State<MiddleHighStuff> {

  List<GridListItems> menuItems = [
    GridListItems(
        name: LabelStr.lblVideos,
        svgPicture: MyImage.videosIcon),
    GridListItems(
        name: LabelStr.lblArticles,
        svgPicture: MyImage.calenderIcon),
    GridListItems(
        name: LabelStr.lblStories,
        svgPicture: MyImage.universityIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                      if(index == 0){
                        Utils.navigateToScreen(context, VideoListScreen(LabelStr.lblVideos));
                      } else if(index == 1){
                        Utils.navigateToScreen(context, BlogScreen(LabelStr.lblArticles));
                      } else {
                        Utils.navigateToScreen(context, BlogScreen(LabelStr.lblStories));
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
    );
  }
}
