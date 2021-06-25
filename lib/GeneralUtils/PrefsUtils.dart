import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/Model/LoginResponse.dart';

class PrefUtils {
  static const String isLoggedIn = "com.TucsonApp.isLoggedIn";
  static const String userId = "com.TucsonApp.userId";
  static const String userRole = "com.TucsonApp.userRole";
  static const String userEmail = "com.TucsonApp.userEmail";
  static const String userFirstName = "com.TucsonApp.userFirstName";
  static const String userLastName = "com.TucsonApp.userLastName";
  static const String userToken = "com.TucsonApp.userToken";


  static setStringValue(String key, String defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, defaultValue);
  }

  static setIntValue(String key, int defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, defaultValue);
  }

  static setDoubleValue(String key, double defaultValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, defaultValue);
  }

  static setBoolValue(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    PrefUtils.setBoolValue(PrefUtils.isLoggedIn, false);
    prefs.clear();
  }

  static void saveUserDataToPref(LoginResponse userDetails) {
    PrefUtils.setIntValue(PrefUtils.userId, userDetails.id);
    PrefUtils.setStringValue(PrefUtils.userRole, userDetails.role);
    PrefUtils.setStringValue(PrefUtils.userEmail, userDetails.email);
    PrefUtils.setStringValue(PrefUtils.userFirstName, userDetails.firstName);
    PrefUtils.setStringValue(PrefUtils.userLastName, userDetails.lastName);
    PrefUtils.setStringValue(PrefUtils.userToken, userDetails.accessToken);
  }

  static void getNurseDataFromPref() async {
    await getValueFor(PrefUtils.userToken);
    await getValueFor(PrefUtils.isLoggedIn);
    await getValueFor(PrefUtils.userId);
    await getValueFor(PrefUtils.userRole);
    await getValueFor(PrefUtils.userEmail);
    await getValueFor(PrefUtils.userFirstName);
    await getValueFor(PrefUtils.userLastName);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
