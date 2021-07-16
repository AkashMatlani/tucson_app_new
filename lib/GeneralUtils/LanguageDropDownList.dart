import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/Model/StaticListItems.dart';


class LanguageDropDownList extends StatefulWidget {

  List<StaticListItems> languageList;
  StaticListItems itemDetails;
  LanguageDropDownList(this.languageList, this.itemDetails);

  @override
  _LanguageDropDownListState createState() => _LanguageDropDownListState();
}

class _LanguageDropDownListState extends State<LanguageDropDownList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.of(context).pop();
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
                            border: Border.all(color: HexColor("#6462AA"), width: 1)
                        ),
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(widget.languageList[position].name, style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: HexColor("#6462AA"))),
                      ),
                      onTap: (){
                        Navigator.of(context).pop(widget.languageList[position]);
                      },
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
