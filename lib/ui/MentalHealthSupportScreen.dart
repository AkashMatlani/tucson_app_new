import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class MentalHealthSupportScreen extends StatefulWidget {
  @override
  _MentalHealthSupportScreenState createState() => _MentalHealthSupportScreenState();
}

class _MentalHealthSupportScreenState extends State<MentalHealthSupportScreen> {
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
                      Text(LabelStr.lblMentalHealthSupport,
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
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color.fromRGBO(245, 246, 252, 1),
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        12.0, 12.0, 12.0, 8.0),
                                    child: SvgPicture.asset(
                                        MyImage.healthSupportIcon)),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        LabelStr.lblBehaviorialHealth,
                                        style: AppTheme.regularTextStyle()
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Color.fromRGBO(245, 246, 252, 1),
                            elevation: 5,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        12.0, 12.0, 12.0, 8.0),
                                    child: SvgPicture.asset(
                                        MyImage.userChatIcon)),
                                SizedBox(height: 5),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        LabelStr.lblTalkSpace,
                                        style: AppTheme.regularTextStyle()
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 3)
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          HexColor("#6462AA"),
                          HexColor("#4CA7DA"),
                          HexColor("#20B69E"),
                        ],
                      ),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: SvgPicture.asset(MyImage.callIcon),
                          ),
                          SizedBox(width: 10),
                          Text(LabelStr.lblSuicideLifeline, style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, Colors.white))
                        ],
                      ),
                      onPressed: (){
                        print("Call me");
                        bottomPopup();
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(LabelStr.lblSuicideLifelineNo, style: AppTheme.regularTextStyle().copyWith(fontSize: 30)),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black45, width: 1)
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: SvgPicture.asset(MyImage.messageIcon),
                          ),
                          SizedBox(width: 10),
                          Text(LabelStr.lblSuicideLifeline, style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, Colors.black))
                        ],
                      ),
                      onPressed: (){
                        bottomPopup();
                        print("Call me");
                      },
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
  void bottomPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 40, 10, 10),
              child: Text(LabelStr.lblHippaStatement,
                  style: AppTheme.customTextStyle(
                      MyFont.SSPro_semibold, 18.0, Color.fromRGBO(0, 0, 0, 1))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
              child: Text(
                LabelStr.dummyContentMentalHealth,
                style: AppTheme.regularTextStyle()
                    .copyWith(fontSize: 16, color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Divider(
                  thickness: 1, color: Color.fromRGBO(223, 223, 223, 4)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2, 2, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            HexColor("#6462AA"),
                            HexColor("#4CA7DA"),
                            HexColor("#20B69E"),
                          ],
                        ),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextButton(
                        child: Text(LabelStr.lblAgree,
                            style: AppTheme.customTextStyle(MyFont.SSPro_bold,
                                16.0, Color.fromRGBO(255, 255, 255, 1))),
                        onPressed: () {
                          print("Call me");
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(204, 204, 204, 1)),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButton(
                      child: Text(LabelStr.lblCancel,
                          style: AppTheme.customTextStyle(MyFont.SSPro_bold,
                              16.0, Color.fromRGBO(255, 255, 255, 1))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
