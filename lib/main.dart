// @dart=2.9
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tucson_app/ui/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool allowClose = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tucson Unified Connect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DoubleBack(
          condition: allowClose,
          onConditionFail: () {
            setState(() {
              allowClose = true;
            });
          },
          child: SplashScreen(),
          waitForSecondBackPress: 3,
          // default 2
          textStyle: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
          background: Colors.red,
          backgroundRadius: 30,
        ));
  }
}
