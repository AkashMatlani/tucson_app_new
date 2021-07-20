import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'BlogDetailsScreen.dart';

import '../../GeneralUtils/ColorExtension.dart';


class BlogScreen extends StatefulWidget {
  BlogScreen(this.title, this.fromScreen);

  String title;
  String fromScreen;

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool isLoading = true;
  List<ContentResponse> _contentList = [];
  String? languageCode;
  String svgPicture = "";

  @override
  void initState() {
    super.initState();
    if (widget.title.compareTo('student_blogs'.tr()) == 0 || widget.title.compareTo('blogs'.tr()) == 0 ) {
      svgPicture = MyImage.blogThubmail;
    } else if (widget.title.compareTo('stories'.tr()) == 0) {
      svgPicture = MyImage.storiesThubmail;
    } else if (widget.title.compareTo('articles'.tr()) == 0) {
      svgPicture = MyImage.articleThubmail;
    }else if (widget.title.compareTo('activites'.tr()) == 0) {
      svgPicture = MyImage.activitesIcon;
    }
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
        body: Stack(
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
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: IconButton(
                              icon: Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(widget.title,
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
                    height: MediaQuery.of(context).size.height * 0.88,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
                  )
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.12,
              left: MediaQuery.of(context).size.height * 0.012,
              right: MediaQuery.of(context).size.height * 0.012,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.88,
                child: _contentList.length == 0
                    ? emptyListView()
                    : SingleChildScrollView(
                        child: ListView.builder(
                            itemCount: _contentList.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.all(10),
                            itemBuilder: (BuildContext context, int position) {
                              return _listRowItems(context, position);
                            }),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        if (widget.title.compareTo('student_blogs'.tr()) == 0) {
          widget.title = 'blog_details'.tr();
        } else if (widget.title.compareTo('articles'.tr()) == 0) {
          widget.title = 'article_details'.tr();
        } else if (widget.title.compareTo('stories'.tr()) == 0) {
          widget.title = 'story_details'.tr();
        } else if (widget.title.compareTo('blogs'.tr()) == 0) {
          widget.title = 'blog_details'.tr();
        }else if (widget.title.compareTo('activites'.tr()) == 0) {
          widget.title = 'activity_details'.tr();
        }

        Utils.navigateToScreen(
            context, BlogDetailsScreen(widget.title, _contentList[index]));
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
              child:
                  /*ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            useOldImageOnUrlChange: false,
                            imageUrl: getVideoThumbinail(),
                            placeholder: (context, url) => Container(height: 40, width: 40, alignment: Alignment.center, child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset(MyImage.videoUrlImage),
                          ),
                        )*/
                  SvgPicture.asset(
                svgPicture,
                fit: BoxFit.fitWidth,
                height: MediaQuery.of(context).size.height * 0.24,
                width: 400,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  Utils.convertDate(_contentList[index].createdOn,
                      DateFormat("MMM dd, yyyy")),
                  style: AppTheme.regularTextStyle().copyWith(
                      fontSize: 14, color: Color.fromRGBO(111, 111, 111, 1)),
                )),
            Padding(
                padding: EdgeInsets.only(top: 5, bottom: 20),
                child: Text(_contentList[index].contentTitle,
                    style: AppTheme.customTextStyle(
                        MyFont.SSPro_bold, 20.0, Color.fromRGBO(0, 0, 0, 1))))
          ]),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.88,
      child: isLoading
          ? Container()
          : Text('no'.tr() + " " + widget.title + " " + 'found'.tr(),
              style: AppTheme.regularTextStyle()
                  .copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _getContentList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params;


    if (widget.title.compareTo('student_blogs'.tr()) == 0 || widget.title.compareTo('blogs'.tr()) == 0) {
      params = {
        "schoolId": schoolId,
        "roleId": 0,
        "contentTypeName": "blog"
      };
    } else if (widget.title.compareTo('articles'.tr()) == 0) {
      params = {
        "schoolId": schoolId,
        "roleId": 0,
        "contentTypeName": "Article"
      };
    }else if (widget.title.compareTo('activites'.tr()) == 0) {
      params = {
        "schoolId": schoolId,
        "roleId": 0,
        "contentTypeName": "Activities"
      };
    } else if (widget.title.compareTo('stories'.tr()) == 0) {
      params = {
        "schoolId": schoolId,
        "roleId": 0,
        "contentTypeName": "Stories"
      };
    }

    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, widget.fromScreen,
        (isSuccess, message) {
      if (isSuccess) {
        setState(() {
          _contentList = [];
          _contentList = _contentViewModel.contentList;
        });
        if (languageCode!.compareTo("en") != 0) {
          translateListData();
        } else {
          Utils.showLoader(false, context);
          isLoading = false;
        }
      } else {
        Utils.showLoader(false, context);
        isLoading = false;
        setState(() {
          _contentList = [];
        });
      }
    });
  }

  translateListData() {
    List<ContentResponse> tempList = [];
    List<String> blogNameList = [];
    for (var itemName in _contentList) {
      blogNameList.add(itemName.contentTitle);
    }
    String listStr = blogNameList.join("==)");
    WebService.translateApiCall(languageCode!, listStr, (isSuccess, response) {
      if (isSuccess) {
        List<String> resultArr = response.toString().split("==)");
        for (int i = 0; i < resultArr.length; i++) {
          tempList.add(ContentResponse(
              contentMasterId: _contentList[i].contentMasterId,
              schoolId: _contentList[i].schoolId,
              contentTypeId: _contentList[i].contentTypeId,
              categoryName: _contentList[i].categoryName,
              contentTitle: resultArr[i],
              content: _contentList[i].content,
              createdOn: _contentList[i].createdOn,
              schoolName: _contentList[i].schoolName,
              contentTransactionTypeJoin:
                  _contentList[i].contentTransactionTypeJoin));
        }
        if(_contentList.length == tempList.length){
          setState(() {
            _contentList = tempList;
          });
        }
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
    });
    isLoading = false;
    Utils.showLoader(false, context);
  }
}
