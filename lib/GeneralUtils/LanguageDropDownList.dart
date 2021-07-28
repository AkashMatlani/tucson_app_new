import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/StaticListItems.dart';
import 'package:tucson_app/ui/community/CommunityDashboardScreen.dart';
import 'package:tucson_app/ui/parent/ParentGuardianDashBoard.dart';
import 'package:tucson_app/ui/student/StudentDashboardScreen.dart';


class LanguageDropDownList extends StatefulWidget {

  List<StaticListItems> languageList;
  StaticListItems itemDetails;
  String fromScreen;
  LanguageDropDownList(this.languageList, this.fromScreen, this.itemDetails);

  @override
  _LanguageDropDownListState createState() => _LanguageDropDownListState();
}

class _LanguageDropDownListState extends State<LanguageDropDownList> {

  late int selectedPosition = 0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 100), (){
      for(int i = 0; i <widget.languageList.length; i++){
        if(widget.languageList[i].name.compareTo(widget.itemDetails.name) == 0){
          setState(() {
            selectedPosition = i;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>backToPrevPage(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: (){
                      backToPrevPage();
                    },
                    icon: Icon(Icons.clear, size: 30, color: HexColor("#6462AA")),
                  ),
                ),
                ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: widget.languageList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (BuildContext context, int position){
                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: HexColor("#6462AA"), width: 1),
                            color: position == selectedPosition ? HexColor("#e0dfee") : HexColor("#fbfbfb")
                          ),
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(widget.languageList[position].name, style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: HexColor("#6462AA"))),
                        ),
                        onTap: (){
                          setState(() {
                            selectedPosition = position;
                            context.setLocale(Locale(widget.languageList[position].value, 'US'));
                            PrefUtils.setStringValue(PrefUtils.yourLanguage, widget.languageList[position].name);
                            PrefUtils.setStringValue(PrefUtils.sortLanguageCode, widget.languageList[position].value);
                          });
                          backToPrevPage();
                          //Navigator.of(context).pop(widget.languageList[position]);
                        },
                      );
                    }
                )
              ],
            ),
          ),
        ),
      ),
    );
 }

 backToPrevPage(){
   Timer(Duration(milliseconds: 50), () async {
     String langCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
     if(widget.fromScreen.compareTo("Student") == 0){
       Utils.backWithNoTransition(context, StudentDashboardScreen(langCode));
     } else if(widget.fromScreen.compareTo("Parent") == 0){
       Utils.backWithNoTransition(context, ParentDashBoardScreen(langCode));
     } else if(widget.fromScreen.compareTo("Community") == 0){
       Utils.backWithNoTransition(context, CommunityDashboardScreen(langCode));
     }
   });
 }
}
