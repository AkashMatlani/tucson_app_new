import 'package:flutter/cupertino.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/WebViewEmpty.dart';

import 'ContentResponse.dart';

class ContentMasterViewModel{

  List<ContentTransactionResponse> contentList = [];

  getContentList(var params, BuildContext context, ResponseCallback callback){
    WebService.postAPICall(WebService.contentByType, params).then((response) {
      if (response.statusCode == 1) {
        contentList = [];
        for (var data in response.body[0]["contentTransactionTypeJoin"]) {
          contentList.add(ContentTransactionResponse.fromJson(data));
        }
        callback(true, "");
      } else {
        contentList = [];
        callback(false, response.message);
      }
    }).catchError((error) {
      contentList = [];
      print(error);
      callback(false, LabelStr.serverError);
      Utils.navigateToScreen(context, WebViewEmpty());
    });
  }
}