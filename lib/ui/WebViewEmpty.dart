import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/student/StudentDashboardScreen.dart';

class WebViewEmpty extends StatefulWidget {
  @override
  _WebViewEmptyState createState() => _WebViewEmptyState();
}

class _WebViewEmptyState extends State<WebViewEmpty> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Utils.navigateReplaceToScreen(context, StudentDashboardScreen()),
      child: Scaffold(
        body: Stack(
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
                          child: Text(LabelStr.lblWebview,
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
              top: MediaQuery.of(context).size.height*0.12,
              left: MediaQuery.of(context).size.height*0.012,
              right: MediaQuery.of(context).size.height*0.012,
              child: Container(
                height: MediaQuery.of(context).size.height*0.88,
                child: emptyListView(),
              ),
            )
          ],
        ),
      ),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height*0.88,
      child: Text(LabelStr.lblNoData, style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }
}