// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/WebService/WebService.dart';
import 'package:tucson_app/ui/SplashScreen.dart';

import 'ui/DonationScreen.dart';
import 'ui/community/CommunityDashboardScreen.dart';
import 'ui/parent/ParentGuardianDashBoard.dart';
import 'ui/student/StudentDashboardScreen.dart';

void main() async {
  String role;
  int userId;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    PrefUtils.getUserDataFromPref();
    if (prefs.containsKey(PrefUtils.userRole)) {
      role = prefs.getString(PrefUtils.userRole);
      userId = prefs.getInt(PrefUtils.userId);
    }
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp(role, userId));
  });
}

class MyApp extends StatefulWidget {
  String role;
  int userId;

  MyApp(this.role, this.userId);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading=true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tucson Unified Connect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:SplashScreen());

      /*(widget.role == null)
            ? DonationScreen()
            : widget.role.compareTo("Student") == 0
                ? StudentDashboardScreen()
                : widget.role.compareTo("Community") == 0
                    ? CommunityDashboardScreen()
                    : ParentDashBoardScreen()*/

    }

  checkUserStatus(BuildContext context) {
    Utils.showLoader(true, context);
    var params = {"Id": widget.userId};
    WebService.postAPICall(WebService.getUserStatus, params).then((response) {
      Utils.showLoader(false, context);
      if (response.statusCode == 1) {
        if (response.body != null) {
          Utils.showToast(context, response.message, Colors.green);
          if (widget.role.compareTo("Student") == 0) {
            StudentDashboardScreen();
          } else if (widget.role.compareTo("Community") == 0) {
            CommunityDashboardScreen();
          } else {
            ParentDashBoardScreen();
          }
        } else {
          Utils.showToast(context, response.message, Colors.red);
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      Utils.showLoader(false, context);
      print(error);
      Utils.showToast(context, LabelStr.serverError, Colors.red);
    });
  }

}
