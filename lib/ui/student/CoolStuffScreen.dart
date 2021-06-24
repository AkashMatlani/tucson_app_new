import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import 'package:tucson_app/ui/student/ElementaryStuff.dart';
import 'package:tucson_app/ui/student/MiddleHighStuff.dart';

class CoolStuffScreen extends StatefulWidget {
  @override
  _CoolStuffScreenScreenState createState() => _CoolStuffScreenScreenState();
}

class _CoolStuffScreenScreenState extends State<CoolStuffScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 3,
      initialIndex: 1,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var tabWidth = (MediaQuery.of(context).size.width-80) / 2;
    var tabHeight = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: HexColor("#6462AA"),
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
                      Text(LabelStr.lblCoolStuff,
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
            child: Container(
              child: Column(
                children: <Widget>[
                  TabBar(
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Container(
                            width: tabWidth,
                            height: tabHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: activeTabIndex==0?1:0, color: activeTabIndex==0?Colors.white:Colors.black26),
                              gradient: activeTabIndex == 0 ? LinearGradient(
                                colors: [
                                  HexColor("#6462AA"),
                                  HexColor("#4CA7DA"),
                                  HexColor("#20B69E"),
                                ],
                              ) : LinearGradient(colors: []),
                            ),
                            child: Text(LabelStr.lblElementary, style: AppTheme.regularTextStyle().copyWith(color: activeTabIndex==0 ? Colors.white : MyColor.hintTextColor()))
                        )
                      ),
                      Tab(
                        child: Container(
                            width: tabWidth,
                            height: tabHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: activeTabIndex==1?1:0, color: activeTabIndex==0?Colors.white:Colors.black26),
                              gradient: activeTabIndex == 1 ? LinearGradient(
                                colors: [
                                  HexColor("#6462AA"),
                                  HexColor("#4CA7DA"),
                                  HexColor("#20B69E"),
                                ],
                              ) : LinearGradient(colors: []),
                            ),
                            child:Text(LabelStr.lblMiddleHigh, style: AppTheme.regularTextStyle().copyWith(color: activeTabIndex==1 ? Colors.white : MyColor.hintTextColor()))
                        )
                      ),
                    ],
                    controller: _tabController,
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: <Widget>[
                          ElementaryStuff(),
                          MiddleHighStuff()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
