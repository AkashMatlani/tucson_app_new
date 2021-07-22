import 'package:easy_localization/easy_localization.dart';
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
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarshipInfoScreen extends StatefulWidget {

  String fromScreen;
  ScholarshipInfoScreen(this.fromScreen);

  @override
  _ScholarshipInfoScreenState createState() => _ScholarshipInfoScreenState();
}

class _ScholarshipInfoScreenState extends State<ScholarshipInfoScreen> {

  bool isLoading = true;
  String? languageCode;
  List<ContentTransactionResponse> _scholarshipInfoList = [];

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(schoolId == null){
      schoolId = 0;
    }
    _getScholarshipInfoList(schoolId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                          child: Text('scholarship_information'.tr(),
                              style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Colors.white)),
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
                    child: _scholarshipInfoList.length == 0 ? emptyListView() : SingleChildScrollView(
                      child:  ListView.builder(
                          itemCount: _scholarshipInfoList.length,
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
      ),
    );
  }

  _listRowItem(BuildContext context, int position) {
    return InkWell(
      onTap: (){
        _launchURL(_scholarshipInfoList[position].objectPath);
       // Utils.navigateToScreen(context, DisplayWebview(_scholarshipInfoList[position].objectPath));
      },
      child: Card(
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
                child: Text(_scholarshipInfoList[position].objectName, style: AppTheme.regularTextStyle()),
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
      ),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height*0.88,
      child: isLoading ? Container() : Text('no_scholarship'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _getScholarshipInfoList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params;
    if(widget.fromScreen.compareTo("Student") == 0) {
      params = {
        "schoolId": schoolId,
        "roleId": 0,
        "contentTypeName": "Scholarship"
      };
    } else {
      params = {
        "schoolId": schoolId,
        "roleId": 0,
        "contentTypeName": "Scholarship"
      };
    }
    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, widget.fromScreen, (isSuccess, message){
      if(isSuccess){
        setState(() {
          _scholarshipInfoList = [];
          for(var data in _contentViewModel.contentList){
            for(var listData in data.contentTransactionTypeJoin){
              _scholarshipInfoList.add(listData);
            }
          }
        });
        if(languageCode!.compareTo("en") != 0){
          translateListData();
        } else {
          Utils.showLoader(false, context);
          isLoading = false;
        }
      } else {
        Utils.showLoader(false, context);
        isLoading = false;
        setState(() {
          _scholarshipInfoList = [];
        });
      }
    });
  }

  translateListData(){
    List<String> nameList=[];
    List<ContentTransactionResponse> tempList =[];
    for(var items in _scholarshipInfoList){
      nameList.add(items.objectName);
    }
    String nameStr = nameList.join("==)");
    WebService.translateApiCall(languageCode!, nameStr, (isSuccess, response){
      if(isSuccess){
        List<String> resultArr = response.toString().split("==)");
        for(int i=0; i< resultArr.length; i++){
          tempList.add(ContentTransactionResponse(contentTransactionId: _scholarshipInfoList[i].contentTransactionId,
              contentMasterId: _scholarshipInfoList[i].contentMasterId,
              contentTransTypeId: _scholarshipInfoList[i].contentTransTypeId,
              objectName: resultArr[i],
              objectPath: _scholarshipInfoList[i].objectPath,
              contentTransTypeName: _scholarshipInfoList[i].contentTransTypeName));
        }

        if(_scholarshipInfoList.length == tempList.length){
          setState(() {
            _scholarshipInfoList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      isLoading = false;
      Utils.showLoader(false, context);
    });
  }

  void _launchURL(String path) async =>
      await canLaunch(path) ? await launch(path) : throw 'Could not launch $path';
}
