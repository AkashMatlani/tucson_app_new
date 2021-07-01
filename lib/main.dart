// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/WebService/WebService.dart';

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

class MyApp extends StatelessWidget {
  String role;
  int userId;

  MyApp(this.role, this.userId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tucson Unified Connect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: (role == null)
            ? DonationScreen()
            : role.compareTo("Student") == 0
            ? StudentDashboardScreen()
            : role.compareTo("Community") == 0
            ? CommunityDashboardScreen
            : ParentDashBoardScreen());
  }

  checkUserStatus() {
    var params = {"Id": userId};
    WebService.postAPICall(WebService.getUserStatus, params).then((response){
      if(response.statusCode == 1){
        if (response.body != null) {
          Utils.showToast(context, response.message, Colors.green);
        } else {
          Utils.showToast(context, response.message, Colors.red);
        }
      } else {
        Utils.showToast(context, response.message, Colors.red);
      }
    }).catchError((error) {
      print(error);
      Utils.showToast(context, LabelStr.serverError, Colors.red);
    });
  }
}