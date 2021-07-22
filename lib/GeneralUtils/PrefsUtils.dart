import 'package:shared_preferences/shared_preferences.dart';
import 'package:tucson_app/Model/LoginResponse.dart';

class PrefUtils {
  static const String isLoggedIn = "com.TucsonApp.isLoggedIn";
  static const String Token = "com.TucsonApp.token";
  static const String userId = "com.TucsonApp.userId";
  static const String userRole = "com.TucsonApp.userRole";
  static const String userEmail = "com.TucsonApp.userEmail";
  static const String userProfile = "com.TucsonApp.userProfile";
  static const String userFirstName = "com.TucsonApp.userFirstName";
  static const String userLastName = "com.TucsonApp.userLastName";
  static const String userDOB = "com.TucsonApp.userDOB";
  static const String userToken = "com.TucsonApp.userToken";
  static const String schoolId = "com.TucsonApp.schoolId";
  static const String yourLanguage = "com.TucsonApp.yourLanguage";
  static const String sortLanguageCode = "com.TucsonApp.sortLanguageCode";
  /*static const String mentalHealthpopUpForStudent = "com.TucsonApp.healthPopUpForStudent";
  static const String mentalHealthpopUpForParent = "com.TucsonApp.healthPopUpForParent";*/


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
    //PrefUtils.setBoolValue(PrefUtils.isLoggedIn, false);
    //PrefUtils.setIntValue(PrefUtils.userId, 0);
    await prefs.clear();
  }

  static void saveUserDataToPref(LoginResponse userDetails) {
    PrefUtils.setBoolValue(PrefUtils.isLoggedIn, true);
    PrefUtils.setIntValue(PrefUtils.userId, userDetails.id);
    PrefUtils.setStringValue(PrefUtils.userRole, userDetails.role);
    PrefUtils.setStringValue(PrefUtils.userEmail, userDetails.email);
    PrefUtils.setStringValue(PrefUtils.userFirstName, userDetails.firstName);
    PrefUtils.setStringValue(PrefUtils.userLastName, userDetails.lastName);
    PrefUtils.setStringValue(PrefUtils.userProfile, userDetails.image);
    PrefUtils.setStringValue(PrefUtils.userDOB, userDetails.dob);
    PrefUtils.setStringValue(PrefUtils.userToken, userDetails.accessToken);
    if(userDetails.schoolId == null){
      PrefUtils.setIntValue(PrefUtils.schoolId, 0);
    } else {
      PrefUtils.setIntValue(PrefUtils.schoolId, userDetails.schoolId);
    }
  }

  static void getUserDataFromPref() async {
    await getValueFor(PrefUtils.userToken);
    await getValueFor(PrefUtils.isLoggedIn);
    await getValueFor(PrefUtils.userId);
    await getValueFor(PrefUtils.userRole);
    await getValueFor(PrefUtils.userEmail);
    await getValueFor(PrefUtils.userFirstName);
    await getValueFor(PrefUtils.userLastName);
    await getValueFor(PrefUtils.userProfile);
    await getValueFor(PrefUtils.userDOB);
    await getValueFor(PrefUtils.schoolId);
    await getValueFor(PrefUtils.yourLanguage);
  }

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
