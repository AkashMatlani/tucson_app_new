import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ContentMasterViewModel.dart';
import 'package:tucson_app/Model/ContentResponse.dart';
import 'package:tucson_app/ui/BlogDetailsScreen.dart';
import '../../GeneralUtils/ColorExtension.dart';


class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  bool isLoading = true;
  List<ContentTransactionResponse> _blogList = [];

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
                        child: Text(LabelStr.lblStudentBlogs,
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
              child: _blogList.length == 0 ? emptyListView() : SingleChildScrollView(
                child:  ListView.builder(
                    itemCount: _blogList.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (BuildContext context, int position){
                      return _listRowItems(context, position);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  _listRowItems(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Utils.navigateToScreen(context, BlogDetailsScreen());
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.height,
                height:
                MediaQuery.of(context).size.height * 0.3,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Mar 23, 2021',
                  style: AppTheme.regularTextStyle().copyWith(
                      fontSize: 14,
                      color: Color.fromRGBO(111, 111, 111, 1)),
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 10, top: 10, bottom: 20),
                child: Text(
                    'TUSD1 Desire Wheeler Interscholastics Director',
                    style: AppTheme.customTextStyle(
                        MyFont.SSPro_bold,
                        20.0,
                        Color.fromRGBO(0, 0, 0, 1))))
          ]),
    );
  }

  emptyListView() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height*0.88,
      child: isLoading ? Container() : Text(LabelStr.lblNoData, style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red)),
    );
  }

  _getVolunteerList(int schoolId) {
    ContentMasterViewModel _contentViewModel = ContentMasterViewModel();
    var params = {
      "schoolId": schoolId,
      "roleId": 0,
      "contentTypeName": "blog"
    };
    Utils.showLoader(true, context);
    _contentViewModel.getContentList(context, params, "blog", (isSuccess, message){
      Utils.showLoader(false, context);
      isLoading = false;
      if(isSuccess){
        setState(() {
          _blogList = [];
          _blogList = _contentViewModel.contentList;
        });
      } else {
        setState(() {
          _blogList = [];
        });
      }
    });
  }

}
