// @dart=2.9
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tucson_app/ui/SignInScreen.dart';
import 'ui/parent/ParentGuardianDashBoard.dart';
import 'package:tucson_app/PostJobsScreen.dart';
import 'package:tucson_app/ui/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tucson App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
