import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'LabelStr.dart';


class Utils {

  static void showLoader(bool show, BuildContext context) {
    if(show){
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext ctx) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                    size: 80,
                  )
              ),
            );
          }
      );
    } else {
      Navigator.pop(context);
    }
  }

  static Future<dynamic> navigateToScreen(
      BuildContext context, Widget screen) async {
    var value = await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => screen));
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
      CupertinoPageRoute(
        builder: (BuildContext context) => screen),
      (route) => false,
    );
  }

  static backWithNoTransition(BuildContext context, Widget screen){
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_,__, ___) => screen,
          maintainState: true,
          transitionDuration: Duration(milliseconds: 100)),
    );
  }

  static signoutAlert(BuildContext context, ResponseCallback callback){
    AlertDialog alert = AlertDialog(
      content: Text('signout_alter_msg'.tr(), style: AppTheme.regularTextStyle().copyWith(fontSize: 18)),
      actions: [
        TextButton(
          child: Text('yes'.tr(), style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold, fontSize: 18)),
          onPressed: (){
            callback(true, "");
          },
        ),
        TextButton(
          child: Text('no'.tr(), style: AppTheme.regularTextStyle().copyWith(fontFamily: MyFont.SSPro_semibold, fontSize: 18)),
          onPressed: (){
            Navigator.of(context).pop();
            callback(false, "");
          },
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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

  static calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static void showToast(BuildContext context, String message, Color bgColor) {
    ToastView.dismiss();
    ToastView.createView(
        message,
        context,
        Toast.LENGTH_LONG,
        Toast.TOP,
        bgColor,
        Colors.white,
        10.0,
        Border.all(color: bgColor));
  }

  static showAlertDialog(BuildContext context, String message, ResponseCallback callback){
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Container(
        child: Text(message, style: AppTheme.regularTextStyle()),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text(LabelStr.lblOk.toUpperCase(),
              style: AppTheme.customTextStyle(MyFont.SSPro_semibold, 22.0, Colors.green)),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Discard");
            callback(true, "");
          },
        )
      ],
    );
    return showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return Theme(
              data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
              child: alert
          );
        });
  }

}

typedef ResponseCallback(bool success, dynamic response);