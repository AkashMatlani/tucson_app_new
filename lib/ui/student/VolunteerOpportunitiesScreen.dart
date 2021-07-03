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
import 'package:tucson_app/ui/DisplayWebview.dart';

class VolunteerOpportunitiesScreen extends StatefulWidget {
  @override
  _VolunteerOpportunitiesScreenState createState() => _VolunteerOpportunitiesScreenState();
}

class _VolunteerOpportunitiesScreenState extends State<VolunteerOpportunitiesScreen> {

  bool isLoading = true;
  List<ContentTransactionResponse> _volunteerList = [];

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    if(schoolId == null){
      schoolId = 0;
    }
    _getVolunteerList(schoolId);
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
                        child: Text(LabelStr.lblVolunteerOpportunites,
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
                child: _volunteerList.length == 0 ? emptyListView() : SingleChildScrollView(
                  child:  ListView.builder(
                      itemCount: _volunteerList.length,
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
    return InkWell(
      onTap: (){
        Utils.navigateToScreen(context, DisplayWebview(_volunteerList[position].objectPath));
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
                child: Text(_volunteerList[position].objectName, style: AppTheme.regularTextStyle()),
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
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: isLoading ? Container() : Text(LabelStr.lblNoData, style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
      ),
    );
  }

  _getVolunteerList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params = {
      "schoolId": schoolId,
      "roleId": 0,
      "contentTypeName": "Volunteer"
    };
    Utils.showLoader(true, context);
    _contentViewModel.getContentList(params,context, (isSuccess, message){
      Utils.showLoader(false, context);
      isLoading = false;
      if(isSuccess){
        setState(() {
          _volunteerList = [];
          _volunteerList = _contentViewModel.contentList;
        });
      } else {
        setState(() {
          _volunteerList = [];
        });
      }
    });
  }
}
