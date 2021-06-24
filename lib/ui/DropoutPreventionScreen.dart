import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class DropoutPreventionScreen extends StatefulWidget {
  @override
  _DropoutPreventionScreenState createState() =>
      _DropoutPreventionScreenState();
}

class _DropoutPreventionScreenState extends State<DropoutPreventionScreen> {
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
                        child: Text(LabelStr.lblDroupOutPrevention,
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
            top: MediaQuery.of(context).size.height * 0.15,
            left: 15,
            right: 15,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                  ),
                  SizedBox(height: 30),
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
                        children: [
                          Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(LabelStr.lblContactSpecialist,
                                      style: AppTheme.customTextStyle(
                                          MyFont.SSPro_semibold,
                                          16.0,
                                          Colors.white)))),
                          Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(Icons.keyboard_arrow_up,
                                  color: Colors.white, size: 30))
                        ],
                      ),
                      onPressed: () {
                        print("Call me");
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text("Talitha Byarse",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(
                                              fontFamily:
                                                  MyFont.SSPro_semibold))),
                              Expanded(
                                  flex: 6,
                                  child: Text("talitha.byarse@tusd1.org",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text("Talitha Byarse",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(
                                              fontFamily:
                                                  MyFont.SSPro_semibold))),
                              Expanded(
                                  flex: 6,
                                  child: Text("talitha.byarse@tusd1.org",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text("Talitha Byarse",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(
                                              fontFamily:
                                                  MyFont.SSPro_semibold))),
                              Expanded(
                                  flex: 6,
                                  child: Text("talitha.byarse@tusd1.org",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text("Talitha Byarse",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(
                                              fontFamily:
                                                  MyFont.SSPro_semibold))),
                              Expanded(
                                  flex: 6,
                                  child: Text("talitha.byarse@tusd1.org",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Text("Talitha Byarse",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(
                                              fontFamily:
                                                  MyFont.SSPro_semibold))),
                              Expanded(
                                  flex: 6,
                                  child: Text("talitha.byarse@tusd1.org",
                                      style: AppTheme.regularTextStyle()
                                          .copyWith(color: Colors.blueAccent)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black45, width: 1)),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Text(LabelStr.lblEnroll,
                          style: AppTheme.customTextStyle(
                              MyFont.SSPro_regular, 16.0, Colors.black)),
                      onPressed: () {
                        print("Call me");
                        bottomPopup();
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
