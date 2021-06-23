import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/Model/GridListItems.dart';


class CommunityResources extends StatefulWidget {
  @override
  _CommunityResourcesScreenState createState() => _CommunityResourcesScreenState();
}

class _CommunityResourcesScreenState extends State<CommunityResources> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblEducationWebstite,
      svgPicture: MyImage.educationalWebsiteIcon,
    ),
    GridListItems(
        name: LabelStr.lblVideos, svgPicture: MyImage.videosIcon),
    GridListItems(
        name: LabelStr.lblActivites, svgPicture: MyImage.activitesIcon),
    GridListItems(
        name: LabelStr.lblArticles, svgPicture: MyImage.articlesIcon),
    GridListItems(
        name: LabelStr.lblBlogs, svgPicture: MyImage.blogsIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.08, 0, MediaQuery.of(context).size.height*0.04),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(LabelStr.lblEducation,
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontSize: 18, color: Colors.white))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(MediaQuery.of(context).size.height*0.08),
                            topRight: Radius.circular(MediaQuery.of(context).size.height*0.08)),
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
            top: MediaQuery.of(context).size.height*0.20,
            left: MediaQuery.of(context).size.height*0.03,
            right: MediaQuery.of(context).size.height*0.03,
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
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.01),
                        ),
                        color: HexColor.cardBackground,
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding:
                                EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                child: SvgPicture.asset(
                                    menuItems[index].svgPicture)),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    menuItems[index].name,
                                    style: AppTheme.regularTextStyle()
                                        .copyWith(color: Colors.black,fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  }),
            ),
          )
        ],
      ),
    );
  }
}