import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static const String isLoggedIn = "com.TucsonApp.isLoggedIn";
  static const String nurseId = "com.TucsonApp.userId";
  static const String password = "com.TucsonApp.password";
  static const String email = "com.TucsonApp.email";
  static const String firstName = "com.TucsonApp.firstName";
  static const String MiddleName = "com.TucsonApp.middleName";
  static const String lastName = "com.TucsonApp.lastname";
  static const String fullName = "com.TucsonApp.fullname";
  static const String NurseImage = "com.TucsonApp.userImage";
  static const String Gender = "com.TucsonApp.gender";
  static const String DateOfBirth = "com.TucsonApp.dateOfBirth";
  static const String phoneNumber = "com.TucsonApp.phoneNumber";
  static const String zipCode = "com.TucsonApp.zipCode";
  static const String isFirstTimeLogin = "com.TucsonApp.isFirstTimeLogin";


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

  /*static void saveNurseDataToPref(NurseResponse nurseDetails, String from) {
    PrefUtils.setIntValue(PrefUtils.nurseId, nurseDetails.nurseid);
    PrefUtils.setStringValue(PrefUtils.email, nurseDetails.email);
    PrefUtils.setStringValue(PrefUtils.firstName, nurseDetails.firstName);
    PrefUtils.setStringValue(PrefUtils.MiddleName, nurseDetails.middleName);
    PrefUtils.setStringValue(PrefUtils.lastName, nurseDetails.lastName);

    String nurseName = nurseDetails.firstName + " "+nurseDetails.lastName;
    PrefUtils.setStringValue(PrefUtils.fullName, nurseName);

    if(nurseDetails.nurseImage.split('/').last.isNotEmpty){
      PrefUtils.setStringValue(PrefUtils.NurseImage, nurseDetails.nurseImage);
    }else{
      PrefUtils.setStringValue(PrefUtils.NurseImage, "");
    }

    PrefUtils.setStringValue(PrefUtils.Gender, nurseDetails.gender);
    PrefUtils.setStringValue(PrefUtils.DateOfBirth, nurseDetails.dateOfBirth);
    PrefUtils.setStringValue(PrefUtils.displayAddress, nurseDetails.displayAddress);
    PrefUtils.setStringValue(PrefUtils.addressLineOne, nurseDetails.address1);
    PrefUtils.setStringValue(PrefUtils.addressLineTwo, nurseDetails.address2);
    PrefUtils.setStringValue(PrefUtils.phoneNumber, nurseDetails.phoneNumber);
    PrefUtils.setStringValue(PrefUtils.zipCode, nurseDetails.zipCode);
    PrefUtils.setStringValue(PrefUtils.cityName, nurseDetails.cityName);
    PrefUtils.setStringValue(PrefUtils.stateName, nurseDetails.stateName);
    if(from.compareTo("FromLogin") == 0){
      PrefUtils.setBoolValue(PrefUtils.isFirstTimeLogin, nurseDetails.isFirstTimeLogin);
      PrefUtils.setIntValue(PrefUtils.visitId, 0);
      PrefUtils.setBoolValue(PrefUtils.isLoggedIn, true);
    }
  }

  static void getNurseDataFromPref() async {
    await getValueFor(PrefUtils.nurseId);
    await getValueFor(PrefUtils.isLoggedIn);
    await getValueFor(PrefUtils.isFirstTimeLogin);
    await getValueFor(PrefUtils.email);
    await getValueFor(PrefUtils.firstName);
    await getValueFor(PrefUtils.lastName);
    await getValueFor(PrefUtils.MiddleName);
    await getValueFor(PrefUtils.addressLineOne);
    await getValueFor(PrefUtils.addressLineTwo);
    await getValueFor(PrefUtils.zipCode);
    await getValueFor(PrefUtils.Gender);
    await getValueFor(PrefUtils.phoneNumber);
    await getValueFor(PrefUtils.DateOfBirth);
    await getValueFor(PrefUtils.NurseImage);
    await getValueFor(PrefUtils.stateName);
    await getValueFor(PrefUtils.cityName);
  }*/

  static Future getValueFor(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
