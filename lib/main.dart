// @dart=2.9
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/DonationScreen.dart';
import 'package:tucson_app/ui/community/CommunityDashboardScreen.dart';
import 'package:tucson_app/ui/parent/ParentGuardianDashBoard.dart';
import 'package:tucson_app/ui/student/StudentDashboardScreen.dart';

import 'GeneralUtils/PrefsUtils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  fetchTranslatorApiKey();
  String role;
  bool isActive = false;
  String languageCode = "en";

  SharedPreferences.getInstance().then((prefs) async {
    PrefUtils.getUserDataFromPref();
    if (prefs.containsKey(PrefUtils.isLoggedIn) &&
        prefs.getBool(PrefUtils.isLoggedIn)) {
      role = prefs.getString(PrefUtils.userRole);
      int userId = prefs.getInt(PrefUtils.userId);

      languageCode = prefs.getString(PrefUtils.sortLanguageCode);
      if (languageCode == null) {
        languageCode = "en";
      }

      var params = {"userId": userId};
      var headers = {"Content-Type": 'application/json'};
      String url = WebService.baseUrl + WebService.getUserStatus;
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(params), headers: headers);

      var jsValue = json.decode(response.body);
      if (jsValue["success"] == true) {
        isActive = jsValue["output"]["isActive"];
        print("result => $isActive");
      }
    } else {
      role = "";
    }
  });

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(EasyLocalization(
        path: 'assets/locales',
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'US'),
          Locale('sr', 'US'),
          Locale('es', 'US'),
          Locale('sw', 'US'),
          Locale('vi', 'US')
        ],
        child: MyApp(role, isActive, languageCode)));
  });
}

class MyApp extends StatefulWidget {
  String role;
  bool isActive;
  String languageCode;

  MyApp(this.role, this.isActive, this.languageCode);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_name'.tr(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Directionality(
            textDirection: widget.languageCode.compareTo("en") == 0
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: (widget.role.isEmpty || widget.role == null)
                ? DonationScreen()
                : widget.role.compareTo("Student") == 0
                    ? StudentDashboardScreen()
                    : widget.role.compareTo("Community") == 0
                        ? CommunityDashboardScreen()
                        : ParentDashBoardScreen()));
  }
}

fetchTranslatorApiKey() {
  var params = {"APIName": "Translator"};
  WebService.getAPICall(WebService.getTranslateApiKey, params).then((response) {
    if (response.statusCode == 1) {
      var translateKey = response.body["apiKey"];
      PrefUtils.setStringValue(PrefUtils.googleTranslateKey, translateKey);
    } else {
      PrefUtils.setStringValue(PrefUtils.googleTranslateKey, "");
      PrefUtils.setStringValue(PrefUtils.sortLanguageCode, "en");
      PrefUtils.setStringValue(PrefUtils.yourLanguage, "English");
    }
  }).catchError((onError) {
    PrefUtils.setStringValue(PrefUtils.googleTranslateKey, "");
    PrefUtils.setStringValue(PrefUtils.sortLanguageCode, "en");
    PrefUtils.setStringValue(PrefUtils.yourLanguage, "English");
  });
}
