import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/Model/GridListItems.dart';
import '../student/BlogDetailsScreen.dart';

class ActivityElementary extends StatefulWidget {
  @override
  _ActivityElementaryState createState() => _ActivityElementaryState();
}

class _ActivityElementaryState extends State<ActivityElementary> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: Positioned(
            top: 130,
            left: 25,
            right: 25,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: new ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () {
                        var content = ContentResponse(contentMasterId: 0, schoolId: 0, contentTypeId: 0, contentTitle: "", content: "", createdOn: "", schoolName: "", contentTransactionTypeJoin: []);
                        Utils.navigateToScreen(context, BlogDetailsScreen('elementary'.tr(), content));
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Container(
                                color: Colors.red,
                                width: MediaQuery.of(context).size.height,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Mar 23, 2021',
                                  style: AppTheme.regularTextStyle().copyWith(
                                      fontSize: 14,
                                      color: Color.fromRGBO(111, 111, 111, 1)),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 20),
                                child: Text(
                                    'TUSD1 Desire Wheeler Interscholastics Director',
                                    style: AppTheme.customTextStyle(
                                        MyFont.SSPro_bold,
                                        20.0,
                                        Color.fromRGBO(0, 0, 0, 1))))
                          ]),
                    );
                  }),
            ),
          )),
    );
  }
}
