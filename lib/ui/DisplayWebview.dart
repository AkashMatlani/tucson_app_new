
import 'dart:async';
import 'dart:html';

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
  late WebViewController _controller;

  NavigationDelegate? navigationDelegate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProgressHUD(
          child: WebView(
             initialUrl: widget.webViewUrl,
             javascriptMode: JavascriptMode.unrestricted,
             onPageFinished: pageFinishedLoading,
             onWebViewCreated: (WebViewController webViewController) {
               _controller = webViewController;
             },
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
    setState(() {
      _isLoading = false;
    });
    readJS(url);
  }

  void readJS(String url) async{
    String html = await _controller.evaluateJavascript("window.document.getElementsByTagName('html')[0].outerHTML;");
    print(html);
    if(html.compareTo("Your password reset successfully.") == 0){
      Utils.showToast(context, "Success", Colors.green);
      /*Timer(Duration(seconds: 2), (){
        Utils.navigateReplaceToScreen(context, SignInScreen());
      });*/
    } else {
      Utils.showToast(context, "Failed", Colors.green);
    }
  }
}