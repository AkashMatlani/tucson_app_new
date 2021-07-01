// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';

import 'ui/DonationScreen.dart';
import 'ui/community/CommunityDashboardScreen.dart';
import 'ui/parent/ParentGuardianDashBoard.dart';
import 'ui/student/StudentDashboardScreen.dart';

void main() async {
  String role;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    PrefUtils.getUserDataFromPref();
    if (prefs.containsKey(PrefUtils.userRole)) {
      role = prefs.getString(PrefUtils.userRole);
    }
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp(role));
  });
}

class MyApp extends StatelessWidget {
  String role;

  MyApp(this.role);

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
}