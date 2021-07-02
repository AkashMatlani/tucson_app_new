
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ProgressHUD.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayWebview extends StatefulWidget {
  DisplayWebview(this.webViewUrl);
  String webViewUrl;
  @override
  _DisplayWebviewState createState() => _DisplayWebviewState();
}

class _DisplayWebviewState extends State<DisplayWebview> {
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProgressHUD(
          child: WebView(
             initialUrl: widget.webViewUrl,
             javascriptMode: JavascriptMode.unrestricted,
             onPageFinished: pageFinishedLoading,

          ),
          inAsyncCall: _isLoading,
          opacity: 0.0,
          key: _scaffoldKey,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  void pageFinishedLoading(String url) {
    if(url.compareTo("http://35.231.45.54:701/backoffice/resetpassword") == 0){
      Timer(Duration(seconds: 2), (){
        Utils.navigateReplaceToScreen(context, SignInScreen());
      });
    }
    setState(() {
      _isLoading = false;
    });
  }
}