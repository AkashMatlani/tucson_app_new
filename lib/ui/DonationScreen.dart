import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DisplayWebview.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';



class DonationScreen extends StatefulWidget {
  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {

  String? languageCode;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getSharedPrefsData();
  }

  getSharedPrefsData() async {
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(languageCode == null){
      languageCode = "en";
    }
    setState(() {
      context.setLocale(Locale(languageCode!, 'US'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(50, 80, 50, 0),
                  child: SvgPicture.asset(MyImage.donationImg),
                ),
                SizedBox(height: 10),
                Text(
                    'gifts_donations'.tr(),
                    style: AppTheme.regularTextStyle().copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center),
                SizedBox(height: 5),
                Text(
                    'donation_desc'.tr(),
                    style: AppTheme.regularTextStyle(),
                    textAlign: TextAlign.center),
                SizedBox(height: MediaQuery.of(context).size.height*0.1),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        HexColor("#6462AA"),
                        HexColor("#4CA7DA"),
                        HexColor("#20B69E"),
                      ],
                    ),
                  ),
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: TextButton(
                    child: Text('giving_donation'.tr(),
                        style: AppTheme.customTextStyle(
                            MyFont.SSPro_bold, 16.0, Colors.white)),
                    onPressed: () {
                      getDonationAPICall();
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    Utils.navigateReplaceToScreen(context, SignInScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('skip'.tr().toUpperCase(),
                        style: AppTheme.customTextStyle(
                            MyFont.SSPro_semibold, 16.0, HexColor("#5772A8"))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getDonationAPICall() {
    WebService.getAPICallWithoutParmas(WebService.donationURL).then((response) {
      if (response.statusCode == 1) {
        Utils.navigateToScreen(context, DisplayWebview(response.body.toString()));
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

}
