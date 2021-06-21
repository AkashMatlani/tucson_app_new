import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';

import 'GeneralUtils/LabelStr.dart';

class Resources extends StatefulWidget {
  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<Resources> {
  List<GridListItems> menuItems = [
    GridListItems(
      name: LabelStr.lblCommunityFoodBank,
      svgPicture: 'assets/images/community_food _bank.svg',
    ),
    GridListItems(
        name: LabelStr.lblAutisumSocitey,
        svgPicture: 'assets/images/autisum_society.svg'),
    GridListItems(
        name: LabelStr.lblUACoopertiveExtension,
        svgPicture: 'assets/images/ua_cooperative.svg'),
    GridListItems(
        name: LabelStr.lblScholarship,
        svgPicture: 'assets/images/scholarship _Info.svg'),
    GridListItems(
        name: LabelStr.lblFamilyResourcesCenters,
        svgPicture: 'assets/images/family_resources.svg'),
    GridListItems(
        name: LabelStr.lblClothingBank,
        svgPicture: 'assets/images/clothing_bank.svg'),
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
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 25),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(LabelStr.lblResources,
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
