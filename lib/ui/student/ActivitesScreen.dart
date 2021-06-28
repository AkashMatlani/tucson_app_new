import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/ui/parent/ActivityElementary.dart';
import '../../GeneralUtils/ColorExtension.dart';

class ActivitesScreen extends StatefulWidget {
  @override
  _ActivitesScreenState createState() => _ActivitesScreenState();
}

class _ActivitesScreenState extends State<ActivitesScreen> with SingleTickerProviderStateMixin {
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
    var tabHeight = MediaQuery.of(context).size.height * 0.06;
    return Scaffold(
      body: Stack(
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
                        child: Text(LabelStr.lblActivites,
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
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height*0.16,
            left: MediaQuery.of(context).size.height*0.015,
            right: MediaQuery.of(context).size.height*0.015,
            child: Container(
              height:MediaQuery.of(context).size.height*40,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        height: tabHeight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black54)
                        ),
                      ),
                      Positioned(
                        child: Container(
                          height: tabHeight,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  HexColor("#6462AA"),
                                  HexColor("#4CA7DA"),
                                  HexColor("#20B69E"),
                                ],
                              ),
                              borderRadius: activeTabIndex==0 ? BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.zero,
                                  bottomRight: Radius.zero
                              ) : BorderRadius.only(
                                  topLeft: Radius.zero,
                                  bottomLeft: Radius.zero,
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.black54,
                            labelStyle: AppTheme.regularTextStyle(),
                            tabs: [
                              Tab(text: LabelStr.lblElementary),
                              Tab(text: LabelStr.lblMiddleHigh),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                      child: Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            ActivityElementary(),
                            ActivityElementary()
                          ],
                        ),
                      )
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