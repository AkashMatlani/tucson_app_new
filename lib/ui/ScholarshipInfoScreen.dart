import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class ScholarshipInfoScreen extends StatefulWidget {
  @override
  _ScholarshipInfoScreenState createState() => _ScholarshipInfoScreenState();
}

class _ScholarshipInfoScreenState extends State<ScholarshipInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: HexColor("#6462AA"),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 25),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(LabelStr.lblScholerShipInformation,
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontSize: 18, color: Colors.white))
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
            top: MediaQuery.of(context).size.height*0.15,
            left: 15,
            right: 15,
            child: Container(
              child: ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  primary: false,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int position){
                    return _listRowItem(context, position);
                  }),
            ),
          )
        ],
      ),
    );
  }

  _listRowItem(BuildContext context, int position) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.all(5),
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Padding(padding:EdgeInsets.all(10),child: SvgPicture.asset(MyImage.dummyIcon)),
            ),
            Expanded(
              child: Text("Lorem Ipsum is simply dummy  the printing and typesetting.", style: AppTheme.regularTextStyle()),
            ),
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              padding: EdgeInsets.all(8),
              child: SvgPicture.asset(MyImage.listForwordIcon),
            )
          ],
        ),
      ),
    );
  }
}
