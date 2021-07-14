import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/ui/student/ElementaryStuff.dart';
import 'package:tucson_app/ui/student/MiddleHighStuff.dart';


class CoolStuffScreen extends StatefulWidget {
  CoolStuffScreen(this.schoolCategory);

  String schoolCategory;

  @override
  _CoolStuffScreenScreenState createState() => _CoolStuffScreenScreenState();
}

class _CoolStuffScreenScreenState extends State<CoolStuffScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;
  late List<bool> _isDisabled;

  @override
  void initState() {
    super.initState();
    if (widget.schoolCategory.compareTo("Elementary") == 0) {
      _isDisabled = [false, true];
    } else if (widget.schoolCategory.compareTo("Middle") == 0) {
      _isDisabled = [true, false];
    } else if (widget.schoolCategory.compareTo("High") == 0) {
      _isDisabled = [true, false];
    } else {
      _isDisabled = [true, true];
    }

    activeTabIndex = (widget.schoolCategory.compareTo("Middle") == 0 || widget.schoolCategory.compareTo("High") == 0 ) ? 1 : 0;

    _tabController = TabController(
      length: 2,
      initialIndex: (widget.schoolCategory.compareTo("Middle") == 0 || widget.schoolCategory.compareTo("High") == 0 ) ? 1 : 0,
      vsync: this,
    );
    _tabController.addListener(onTap);
  }

  onTap() {
    if (widget.schoolCategory.compareTo("K-8") == 0) {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    } else {
      if (_isDisabled[_tabController.index]) {
        int index = _tabController.previousIndex;
        setState(() {
          _tabController.index = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var tabHeight = MediaQuery.of(context).size.height * 0.06;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: HexColor("#6462AA"),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.03, 0, MediaQuery.of(context).size.height*0.03),
                    height: MediaQuery.of(context).size.height*0.06,
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
                          child: Text('cool_stuff'.tr(),
                              style: AppTheme.regularTextStyle()
                                  .copyWith(fontSize: 18, color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        color: HexColor("FAFAFA")),
                    height: MediaQuery.of(context).size.height*0.88,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
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
                                Tab(text: 'elementary'.tr()),
                                Tab(text: 'middle_high'.tr()),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height:20),
                    Expanded(
                        child: Container(
                          child: TabBarView(
                            physics: widget.schoolCategory.compareTo("K-8") ==0 ? ScrollPhysics() : NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: <Widget>[
                              ElementaryStuff(),
                              MiddleHighStuff()
                            ],
                          ),
                        )
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
