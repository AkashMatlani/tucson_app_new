import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/student/BlogDetailsScreen.dart';

class BlogScreenForParent extends StatefulWidget {

  BlogScreenForParent(this.title, this.fromScreen, this.contentList);
  List<ContentResponse> contentList;
  String title;
  String fromScreen;

  @override
  _BlogScreenForParentState createState() => _BlogScreenForParentState();
}

class _BlogScreenForParentState extends State<BlogScreenForParent> {

  String? languageCode;
  String svgPicture = MyImage.activitesIcon;

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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: widget.contentList.length == 0
              ? emptyListView()
              : SingleChildScrollView(
                  child: ListView.builder(
                      itemCount: widget.contentList.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      itemBuilder: (BuildContext context, int position) {
                        return _listRowItems(context, position);
                      }),
                ),
        ),
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        widget.title = 'activite_details'.tr();
        Utils.navigateToScreen(context, BlogDetailsScreen(widget.title, widget.contentList[index]));
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height * 0.24,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                svgPicture,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.24,
                width: 400,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  Utils.convertDate(widget.contentList[index].createdOn,
                      DateFormat("MMM dd, yyyy")),
                  style: AppTheme.regularTextStyle().copyWith(
                      fontSize: 14, color: Color.fromRGBO(111, 111, 111, 1)),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 20),
                child: Text(widget.contentList[index].contentTitle,
                    style: AppTheme.customTextStyle(
                        MyFont.SSPro_bold, 20.0, Color.fromRGBO(0, 0, 0, 1))))
          ]),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.88,
      child: Text('no'.tr() + " " + widget.title + " " + 'found'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red))
    );
  }

  translateListData() {
    List<ContentResponse> tempList = [];
    List<String> blogNameList = [];
    for (var itemName in widget.contentList) {
      blogNameList.add(itemName.contentTitle);
    }
    String listStr = blogNameList.join("==)");
    WebService.translateApiCall(languageCode!, listStr, (isSuccess, response) {
      if (isSuccess) {
        List<String> resultArr = response.toString().split("==)");
        for (int i = 0; i < resultArr.length; i++) {
          tempList.add(ContentResponse(
              contentMasterId: widget.contentList[i].contentMasterId,
              schoolId: widget.contentList[i].schoolId,
              contentTypeId: widget.contentList[i].contentTypeId,
              categoryName: widget.contentList[i].categoryName,
              contentTitle: resultArr[i],
              content: widget.contentList[i].content,
              createdOn: widget.contentList[i].createdOn,
              schoolName: widget.contentList[i].schoolName,
              contentTransactionTypeJoin:
              widget.contentList[i].contentTransactionTypeJoin));
        }
        if (widget.contentList.length == tempList.length) {
          setState(() {
            widget.contentList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
    });
    Utils.showLoader(false, context);
  }
}
