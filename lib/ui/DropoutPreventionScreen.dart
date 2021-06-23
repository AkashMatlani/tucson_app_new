import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class DropoutPreventionScreen extends StatefulWidget {
  @override
  _DropoutPreventionScreenState createState() => _DropoutPreventionScreenState();
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
                  margin: EdgeInsets.fromLTRB(0, 45, 0, 25),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      Text(LabelStr.lblDroupOutPrevention,
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
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue
                    ),
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
                          Expanded(child: Container(margin:EdgeInsets.only(left: 5), child: Text(LabelStr.lblContactSpecialist, style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, Colors.white)))),
                          Container(margin:EdgeInsets.only(right: 5),child: Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 30))
                        ],
                      ),
                      onPressed: (){
                        print("Call me");
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex:4, child: Text("Talitha Byarse", style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold))),
                              Expanded(flex:6, child: Text("talitha.byarse@tusd1.org", style: AppTheme.regularTextStyle().copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(flex:4, child: Text("Talitha Byarse", style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold))),
                              Expanded(flex:6, child: Text("talitha.byarse@tusd1.org", style: AppTheme.regularTextStyle().copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(flex:4, child: Text("Talitha Byarse", style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold))),
                              Expanded(flex:6, child: Text("talitha.byarse@tusd1.org", style: AppTheme.regularTextStyle().copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(flex:4, child: Text("Talitha Byarse", style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold))),
                              Expanded(flex:6, child: Text("talitha.byarse@tusd1.org", style: AppTheme.regularTextStyle().copyWith(color: Colors.blueAccent)))
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(flex:4, child: Text("Talitha Byarse", style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold))),
                              Expanded(flex:6, child: Text("talitha.byarse@tusd1.org", style: AppTheme.regularTextStyle().copyWith(color: Colors.blueAccent)))
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
                      border: Border.all(color: Colors.black45, width: 1)
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: Text(LabelStr.lblEnroll, style: AppTheme.customTextStyle(MyFont.SSPro_regular, 16.0, Colors.black)),
                      onPressed: (){
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
}
