import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';

class ArticlesScreen extends StatefulWidget {
  @override
  _ArticlesScreenState createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  AuthViewModel _authViewModel = AuthViewModel();
  //late List<ContentTransactionTypeJoin> articleList=[];
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
                        child: Text('articles'.tr(),
                            style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 18.0, Colors.white)),
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
                child: SingleChildScrollView(
                  child:  ListView.builder(
                      itemCount: 10,
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
    return Card(
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
              child: Text("abcd", style: AppTheme.regularTextStyle()),
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
    );
  }

  @override
  void initState() {
    super.initState();
   // Timer(Duration(milliseconds: 100), () => _getFilterItemList());

  }

 /* void _getFilterItemList() {
    Utils.showLoader(true, context);
    _authViewModel.getArticlesFromEducationParent("1","Article", (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        setState(() {
          articleList = _authViewModel.articleList.;
          print("schoool Id"+articleList[0].schoolId.toString());
        });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }*/
}
