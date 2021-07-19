import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:url_launcher/url_launcher.dart';


class CommunityEventScreen extends StatefulWidget {

  @override
  _CommunityEventScreenState createState() => _CommunityEventScreenState();
}

class _CommunityEventScreenState extends State<CommunityEventScreen> {

  bool isLoading = true;
  String? languageCode;
  List<ContentTransactionResponse> _communityEventList = [];

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
    _getCommunityEventList(schoolId);
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
                          child: Text('commmunity_events'.tr(),
                              style: AppTheme.regularTextStyle()
                                  .copyWith(fontSize: 18, color: Colors.white)),
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
                child: _communityEventList.length == 0 ? emptyListView() : SingleChildScrollView(
                  child:  ListView.builder(
                      itemCount: _communityEventList.length,
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
       // Utils.navigateToScreen(context, DisplayWebview(_communityEventList[position].objectPath));
        _launchURL(_communityEventList[position].objectPath);
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
                child: Text(_communityEventList[position].objectName, style: AppTheme.regularTextStyle()),
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
      child: isLoading ? Container() : Text('no'.tr()+" "+'commmunity_events'.tr()+" "+'found'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _getCommunityEventList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params = {
      "schoolId": schoolId,
      "roleId": 0,
      "contentTypeName": "CommunityEvents"
    };
    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, "Community", (isSuccess, message){
      if(isSuccess){
        setState(() {
          _communityEventList = [];
          for(var data in _contentViewModel.contentList){
            for(var listData in data.contentTransactionTypeJoin){
              _communityEventList.add(listData);
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
          _communityEventList = [];
        });
      }
    });
  }

  translateListData(){
    List<String> nameList=[];
    List<ContentTransactionResponse> tempList =[];
    for(var items in _communityEventList){
      nameList.add(items.objectName);
    }
    String nameStr = nameList.join("==)");
    WebService.translateApiCall(languageCode!, nameStr, (isSuccess, response){
      if(isSuccess){
        List<String> resultArr = response.toString().split("==)");
        for(int i=0; i< resultArr.length; i++){
          tempList.add(ContentTransactionResponse(contentTransactionId: _communityEventList[i].contentTransactionId,
              contentMasterId: _communityEventList[i].contentMasterId,
              contentTransTypeId: _communityEventList[i].contentTransTypeId,
              objectName: resultArr[i],
              objectPath: _communityEventList[i].objectPath,
              contentTransTypeName: _communityEventList[i].contentTransTypeName));
        }
        if(_communityEventList.length == tempList.length){
          setState(() {
            _communityEventList = tempList;
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
