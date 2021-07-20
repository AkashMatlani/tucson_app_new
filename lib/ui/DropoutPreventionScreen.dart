import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/Model/DropOutPreventionEmailsModel.dart';
import 'package:tucson_app/Model/SchoolListResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:http/http.dart' as http;
import 'package:tucson_app/ui/parent/DropOutPostScreen.dart';

class DropoutPreventionScreen extends StatefulWidget {
  @override
  _DropoutPreventionScreenState createState() =>
      _DropoutPreventionScreenState();
}

class _DropoutPreventionScreenState extends State<DropoutPreventionScreen> {
  bool isLoading = true;
  List<DropOutPreventionEmailsModel> _dropOutModelList = [];

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      _getSchoolList();
    });
  }

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
                  margin: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.03,
                      0,
                      MediaQuery.of(context).size.height * 0.03),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text('dropout_prevention'.tr(),
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

            ConstrainedBox(
                constraints:BoxConstraints(minHeight: 80,maxHeight: MediaQuery.of(context).size.height*0.30),
                    child:  ListView.builder(
                        itemCount: _dropOutModelList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.only(top: 20),
                        itemBuilder:
                            (BuildContext context, int position) {
                          return _listRowItem(context, position);
                        }),
                  ),
                  SizedBox(height: 20),
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
                      child: Text('enroll'.tr(),
                          style: AppTheme.customTextStyle(
                              MyFont.SSPro_regular, 16.0, Colors.white)),
                      onPressed: () {
                        Utils.navigateToScreen(context, DropOutPostScreen());
                      },
                    ),
                  ),
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
              child: Text('hippa_statement'.tr(),
                  style: AppTheme.customTextStyle(
                      MyFont.SSPro_semibold, 18.0, Color.fromRGBO(0, 0, 0, 1))),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 10),
              child: Text(
                'mental_health_popup_desc'.tr(),
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
                        child: Text('agree'.tr(),
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
                      child: Text('cancel'.tr(),
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

  _getSchoolList() {
    Utils.showLoader(true, context);
    WebService.getAPICallWithoutParmas(WebService.getAllDropoutSpeciality)
        .then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          setState(() {
            isLoading = false;
            Utils.showLoader(false, context);
            _dropOutModelList = [];
            //_schoolList.add(SchoolListResponse(id: 0, name: LabelStr.lblSelectSchool, schoolCategoryId: 0, schoolCategoryName: "",  createdBy: 0,  createdOn: "",  updatedBy: 0,  updatedOn: ""));
            for (var data in response.body) {
              _dropOutModelList
                  .add(DropOutPreventionEmailsModel.fromJson(data));
            }
          });
        } else {
          isLoading = false;
          Utils.showLoader(false, context);
        }
      } else {
        isLoading = false;
        Utils.showToast(context, response.message, Colors.red);
        print(
            "******************** ${response.message} ************************");
      }
    }).catchError((error) {
      isLoading = false;
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.88,
      child: isLoading
          ? Container()
          : Text('no_educational'.tr(),
              style: AppTheme.regularTextStyle()
                  .copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _listRowItem(BuildContext context, int position) {
    return InkWell(
      onTap: () {
        // Utils.navigateToScreen(context, DisplayWebview(_communityEventList[position].objectPath));
        // _launchURL(_communityEventList[position].objectPath);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Text(_dropOutModelList[position].specialistName,
                          style: AppTheme.regularTextStyle()
                              .copyWith(fontFamily: MyFont.SSPro_semibold))),
                  Expanded(
                      flex: 6,
                      child: Text(_dropOutModelList[position].specialistEmail,
                          style: AppTheme.regularTextStyle()
                              .copyWith(color: Colors.blueAccent)))
                ],
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
