import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/student/BlogDetailsScreen.dart';


class BlogScreenForParent extends StatefulWidget {

  BlogScreenForParent(this.title, this.fromScreen, this.fromTab);
  String fromTab;
  String title;
  String fromScreen;

  @override
  _BlogScreenForParentState createState() => _BlogScreenForParentState();
}

class _BlogScreenForParentState extends State<BlogScreenForParent> {

  String? languageCode;
  String svgPicture = MyImage.articalIcon;

  List<ContentResponse> _elementryList = [];
  List<ContentResponse> _middleHighList = [];
  List<ContentResponse> _displayContentList = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getSchoolId();
  }

  _getSchoolId() async {
    int schoolId = await PrefUtils.getValueFor(PrefUtils.schoolId);
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if (schoolId == null) {
      schoolId = 0;
    }
    _getContentList(schoolId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: _displayContentList.length == 0
              ? emptyListView()
              : SingleChildScrollView(
            child: ListView.builder(
                itemCount: _displayContentList.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                itemBuilder: (BuildContext context, int position) {
                  return _listRowItems(context, position);
                }),
          ),
        ),
      ),
    );
  }

  _listRowItems(BuildContext ctx, int index) {
    return InkWell(
      onTap: () {
        widget.title = 'activity_details'.tr();
        Utils.navigateToScreen(context, BlogDetailsScreen(widget.title, _displayContentList[index]));
      },
      child: Card(
        elevation: 1,
        margin: EdgeInsets.all(5),
        child: Padding(
          padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: SvgPicture.asset(svgPicture, height: 50, width: 50),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_displayContentList[index].contentTitle, style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 16.0, MyColor.normalTextColor())),
                    SizedBox(height: 5),
                    Text(
                      Utils.convertDate(_displayContentList[index].createdOn,
                          DateFormat("MMM dd, yyyy")),
                      style: AppTheme.regularTextStyle().copyWith(
                          fontSize: 14, color: Color.fromRGBO(111, 111, 111, 1)),
                    )
                  ],
                ),
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
        height: MediaQuery.of(context).size.height * 0.88,
        child: isLoading ? Container() : Text('no'.tr() + " " + widget.title + " " + 'found'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red))
    );
  }

  _getContentList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params;
    params = {
      "schoolId": schoolId,
      "roleId": 0,
      "contentTypeName": "Activities"
    };

    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, "Parent", (isSuccess, message) {
      if (isSuccess) {
        setState(() {
          List<ContentResponse> _contentList = [];
          _contentList = _contentViewModel.contentList;
          _elementryList = [];
          for (int i = 0; i < _contentList.length; i++) {
            if (_contentList[i].contentTitle.compareTo("Elementary")==0) {
              _elementryList.add(_contentList[i]);
            } else if (_contentList[i].contentTitle.compareTo("Middle")==0 || _contentList[i].contentTitle.compareTo("High")==0) {
              _middleHighList.add(_contentList[i]);
            } else {
              _middleHighList.add(_contentList[i]);
              _elementryList.add(_contentList[i]);
            }
          }
          if(widget.fromTab.compareTo("Elementary") == 0){
            _displayContentList = _elementryList;
          } else {
            _displayContentList = _middleHighList;
          }
          if(_displayContentList.length > 0){
            if(languageCode!.compareTo("en") != 0) {
              if(languageCode!.compareTo("sr") == 0){
                languageCode = "so";
              }
              translateListData();
            } else {
              setState(() {
                isLoading = false;
              });
              Utils.showLoader(false, context);
            }
          } else {
            setState(() {
              _elementryList = [];
              _middleHighList=[];
              _displayContentList=[];
              isLoading = false;
            });
            Utils.showLoader(false, context);
          }
        });
      } else {
        Utils.showLoader(false, context);
        setState(() {
          _elementryList = [];
          _middleHighList=[];
          _displayContentList=[];
          isLoading = false;
        });
      }
    });
  }

  translateListData() {
    List<ContentResponse> tempList = [];
    List<String> blogNameList = [];
    for (var itemName in _displayContentList) {
      blogNameList.add(itemName.contentTitle);
    }
    String listStr = blogNameList.join("===");
    WebService.translateApiCall(languageCode!, listStr, (isSuccess, response) {
      if (isSuccess) {
        List<String> resultArr = response.toString().split("===");
        for (int i = 0; i < resultArr.length; i++) {
          tempList.add(ContentResponse(
              contentMasterId: _displayContentList[i].contentMasterId,
              schoolId: _displayContentList[i].schoolId,
              contentTypeId: _displayContentList[i].contentTypeId,
              categoryName: _displayContentList[i].categoryName,
              contentTitle: resultArr[i],
              content: _displayContentList[i].content,
              createdOn: _displayContentList[i].createdOn,
              schoolName: _displayContentList[i].schoolName,
              contentTransactionTypeJoin:
              _displayContentList[i].contentTransactionTypeJoin));
        }
        if (_displayContentList.length == tempList.length) {
          setState(() {
            _displayContentList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
      isLoading = false;
      Utils.showLoader(false, context);
    });
  }
}
