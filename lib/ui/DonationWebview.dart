import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ProgressHUD.dart';
import 'package:tucson_app/Model/AuthViewModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DonationWebview extends StatefulWidget {
  DonationWebview(this.webViewUrl);
  String webViewUrl;
  @override
  _DonationWebviewState createState() => _DonationWebviewState();
}

class _DonationWebviewState extends State<DonationWebview> {
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: WebView(
            initialUrl: widget.webViewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: pageFinishedLoading
        ),
        inAsyncCall: _isLoading,
        opacity: 0.0,
        key: _scaffoldKey,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
    });
  }
}