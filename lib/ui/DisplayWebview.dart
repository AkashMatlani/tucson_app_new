import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/ProgressHUD.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayWebview extends StatefulWidget {

  String webViewUrl;
  DisplayWebview(this.webViewUrl);
  
  @override
  _DisplayWebviewState createState() => _DisplayWebviewState();
}

class _DisplayWebviewState extends State<DisplayWebview> {
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isBackPressed = false;
  //late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    print("WebUrl => ${widget.webViewUrl}");
    return Scaffold(
      body: SafeArea(
        child: ProgressHUD(
          child: WebView(
            initialUrl: widget.webViewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: pageFinishedLoading,
            /*onWebViewCreated: (WebViewController webViewController) {
               _controller = webViewController;
             }*/
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
  }

  /*void readJS(String url) async{
    String text = await _controller.evaluateJavascript("console.log(document.documentElement.innerHTML);");
    print(text);
    if(html.compareTo("Your password reset successfully.") == 0){
      Utils.showToast(context, "Success", Colors.green);
      Timer(Duration(seconds: 2), (){
        Utils.navigateReplaceToScreen(context, SignInScreen());
      });
    } else {
      Utils.showToast(context, "Failed", Colors.green);
    }
  }*/
}
