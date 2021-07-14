import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';

class WebViewEmpty extends StatefulWidget {
  @override
  _WebViewEmptyState createState() => _WebViewEmptyState();
}

class _WebViewEmptyState extends State<WebViewEmpty> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Text('no_url'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18, color: Colors.red))
      ),
    );
  }
}
