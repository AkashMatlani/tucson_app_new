// @dart=2.9
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tucson_app/ui/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
        EasyLocalization(
            path: 'assets/locales',
            supportedLocales: [Locale('en', 'US'), Locale('ar', 'US'), Locale('so', 'US'), Locale('es', 'US'), Locale('sw', 'US'), Locale('vi', 'US')],
            child: MyApp()
        )
    );
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
        title: 'app_name'.tr(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
