
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tucson_app/GeneralUtils/ColorExtension.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/DonationResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class DonationScreen extends StatefulWidget {

  @override
  _DonationScreenState createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {

  String? languageCode;
  String donationDesc = "";
  late DonationResponse donationDetails;

  @override
  void initState() {
    super.initState();
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    getSharedPrefsData();
  }

  getSharedPrefsData() async {
    languageCode = await PrefUtils.getValueFor(PrefUtils.sortLanguageCode);
    if(languageCode == null){
      languageCode = "en";
    }
    setState(() {
      context.setLocale(Locale(languageCode!, 'US'));
      donationDesc = 'donation_desc'.tr();
    });
    getDonationAPICall();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
    textDirection: languageCode?.compareTo("ar") == 0 ? ui.TextDirection.rtl : ui.TextDirection.ltr,
    child:Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Html(
                  data: donationDesc,
                  style: {
                    "body" : Style(
                      fontFamily: MyFont.SSPro_regular,
                      fontSize: FontSize.medium,
                      color: Colors.black54
                    )
                  },
                ),
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
                      if(donationDetails != null) {
                       // Utils.navigateToScreen(context, DisplayWebview(donationDetails.objectPath!));
                        _launchURL(donationDetails.objectPath!);
                      } else {
                        getDonationAPICall();
                      }
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
    ));
  }

  void getDonationAPICall() {
    Utils.showLoader(true, context);
    WebService.getAPICallWithoutParmas(WebService.donationURL).then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        donationDetails = DonationResponse.fromJson(response.body);
        if(languageCode!.compareTo("en") != 0){
          translateDonationData();
        } else {
          setState(() {
            donationDesc = donationDetails.content!;
          });
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, 'check_connectivity'.tr(), Colors.red);
    });
  }

  translateDonationData(){
    if(languageCode!.compareTo("sr") == 0){
      languageCode = "so";
    }
    WebService.translateApiCall(languageCode!, donationDetails.content!, (isSuccess, response){
      if(isSuccess){
        setState(() {
          donationDesc = response.toString();
        });
      } else {
        Utils.showToast(context, "Page Translation Failed", Colors.red);
      }
    });
  }

  void _launchURL(String path) async =>
      await canLaunch(path) ? await launch(path) : throw 'Could not launch $path';
}
