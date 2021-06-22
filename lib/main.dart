// @dart=2.9
import 'package:flutter/material.dart';
import 'ui/parent/ParentGuardianDashBoard.dart';
import 'package:tucson_app/SignupScreen.dart';
import 'package:tucson_app/ui/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tucson App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParentDashBoardScreen(),
    );
  }
}
