import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class JobOpeningScreen extends StatefulWidget {
  @override
  _JobOpeningScreenState createState() => _JobOpeningScreenState();
}

class _JobOpeningScreenState extends State<JobOpeningScreen> {
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
                        child: Text(LabelStr.lblJobOpnings,
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
              top: MediaQuery.of(context).size.height*0.12,
              left: MediaQuery.of(context).size.height*0.012,
              right: MediaQuery.of(context).size.height*0.012,
              child: Container(
                height: MediaQuery.of(context).size.height*0.88,
                child: SingleChildScrollView(
                  child:  ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.only(top: 20),
                      itemBuilder: (BuildContext context, int position){
                        return _listRowItem(context, position);
                      }),
                ),
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
