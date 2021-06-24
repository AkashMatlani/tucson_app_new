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
      length: 2,
      initialIndex: 0,
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
                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.03, 0, MediaQuery.of(context).size.height*0.03),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(LabelStr.lblCoolStuff,
                            style: AppTheme.regularTextStyle()
                                .copyWith(fontSize: 18, color: Colors.white)),
                      )
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
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.20,
            left: MediaQuery.of(context).size.height*0.015,
            right: MediaQuery.of(context).size.height*0.015,
            child: Container(
              height:500,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TabBar(
                    indicatorWeight: 10,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    isScrollable: false,
                    tabs: [
                      Tab(
                        child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width*50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.zero,
                                bottomRight: Radius.zero
                              ),
                              border: Border.all(width: 1, color: activeTabIndex==0?Colors.white:Colors.black54),
                              gradient: activeTabIndex == 0 ? LinearGradient(
                                colors: [
                                  HexColor("#6462AA"),
                                  HexColor("#4CA7DA"),
                                  HexColor("#20B69E"),
                                ],
                              ) : LinearGradient(colors: [Colors.white, Colors.white, Colors.white]),
                            ),
                            alignment: Alignment.center,
                            child: Text(LabelStr.lblElementary, style: AppTheme.regularTextStyle().copyWith(color: activeTabIndex == 0 ? Colors.white : Colors.black54))
                        )
                      ),
                      Tab(
                        child: Container(
                            height: tabHeight,
                            width: MediaQuery.of(context).size.width*0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                    topLeft: Radius.zero,
                                    bottomLeft: Radius.zero,
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                              border: Border.all(width: 1, color: activeTabIndex==1?Colors.white:Colors.black54),
                              gradient: activeTabIndex == 1 ? LinearGradient(
                                colors: [
                                  HexColor("#6462AA"),
                                  HexColor("#4CA7DA"),
                                  HexColor("#20B69E"),
                                ],
                              ) : LinearGradient(colors: [Colors.white, Colors.white, Colors.white]),
                            ),
                            alignment: Alignment.center,
                            child:Text(LabelStr.lblMiddleHigh, style: AppTheme.regularTextStyle().copyWith(color: activeTabIndex == 1 ? Colors.white : Colors.black54))
                        )
                      ),
                    ],
                    controller: _tabController,
                  ),
                  SizedBox(height:20),
                  Expanded(child: Container(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        ElementaryStuff(),
                        MiddleHighStuff()
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
