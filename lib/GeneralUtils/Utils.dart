import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


class Utils {

  static void showLoader(bool show, BuildContext context) {
    if (show) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(
                child: SpinKitCircle(
              color: Colors.black,
              size: 80,
            ));
          });
    } else {
      Navigator.of(context, rootNavigator: true).pop("");
    }
  }

  static Future<dynamic> navigateToScreen(
      BuildContext context, Widget screen) async {
    var value = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => screen));
    return value;
  }

  /*static Future<dynamic> navigateWithReloadScreen(BuildContext context, Widget screen) async {
    var value = await Navigator.push(context, MaterialPageRoute<String>(builder: (context) => screen)).then((String data){
      ToastUtils.showToast(context, "Pop with "+data, Colors.indigo);
    });
    return value;
  }*/

  static navigateReplaceToScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static navigateWithClearState(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => screen),
      (route) => false,
    );
  }

  //r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"
  static bool isValidEmail(String email) {
    bool result = RegExp(r"^^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(email);
    return result;
  }

  static bool isValidQuestion(String question) {
    bool result = RegExp(r"^[a-zA-Z ]{5,}").hasMatch(question);
    return result;
  }

  //r"(?=.*[A-Za-z])(?=.*\d)(?=.*[!@£$%^&*()#€])[A-Za-z\d!@£$%^&*()#€]{6,}$")
  static bool isValidPassword(String password) {
    bool result = RegExp(r"(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$").hasMatch(password);
    return result;
  }

  static String convertDate(String date, DateFormat outputFormat){
    DateTime tempDate = new DateFormat("yyyy-MM-dd'T'hh:mm:ss").parse(date);
    return outputFormat.format(tempDate);
  }

  static String convertTime(String time){
    if(time.compareTo("00:00") == 0){
      return "00:00:00";
    } else {
      TimeOfDay releaseTime = TimeOfDay(hour: int.parse(time.split(":")[0]),
          minute: int.parse(time.split(":")[1]));
      final now = new DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, releaseTime.hour, releaseTime.minute);
      return DateFormat("hh:mm a").format(dt);
    }
  }
}

typedef ResponseCallback(bool success, dynamic response);