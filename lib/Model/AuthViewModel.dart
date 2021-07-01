import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/ArticleResponse.dart';
import 'package:tucson_app/Model/ContentTransactionTypeJoin.dart';
import 'package:tucson_app/Model/EventForMobileResponse.dart';
import 'package:tucson_app/Model/LoginResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';

class AuthViewModel {
  List<ContentTransactionTypeJoin> articleList = [];
  List<EventForMobileResponse> eventForMobileList = [];

  ValidationResult validateLogIn(String email, String password) {
    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if (!email.startsWith(RegExp(r'^[a-zA-Z]'))) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    } else if (!Utils.isValidEmail(email)) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    }

    if (password.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserPwd);
    } else if (password.length < 8) {
      return ValidationResult(false, LabelStr.invalidPassword);
    } else if (password.length > 15) {
      return ValidationResult(false, LabelStr.invalidPasswordMax);
    }
    return ValidationResult(true, "success");
  }

  void logInResult(String email, String password, ResponseCallback callback) {
    var params = {"userName": email, "password": password};
    var responseBody;
    var validateResult = validateLogIn(email, password);
    if (validateResult.isValid) {

      WebService.postAPICall(WebService.userLogin, params).then((response) {
        responseBody= response.body;
        if (response.statusCode == 1) {
          if (response.body != null) {
            PrefUtils.setStringValue(PrefUtils.Token,responseBody["accessToken"]);
            PrefUtils.saveUserDataToPref(LoginResponse.fromJson(response.body));
            callback(true, "");
          }
        } else {
          callback(false, response.message);
        }
      }).catchError((error) {
        print(error);
        callback(false, LabelStr.serverError);
      });
    } else {
      callback(false, validateResult.message);
    }
  }

  ValidationResult validateForgotPwd(String email) {
    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterRegisterEmail);
    } else if (!email.startsWith(RegExp(r'^[a-zA-Z]'))) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    } else if (!Utils.isValidEmail(email)) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    }
    return ValidationResult(true, "success");
  }

  void forgotPwdResult(String email,  ResponseCallback callback) {
    var params = {"Email": email};

    var validateResult = validateForgotPwd(email);
    if (validateResult.isValid) {
      WebService.getAPICall(WebService.forgotPassword, params).then((response) {
        if (response.statusCode == 1) {
          callback(true, LabelStr.checkMailLink);
        } else {
          callback(false, response.message);
        }
      }).catchError((error) {
        print(error);
        callback(false, LabelStr.serverError);
      });
    } else {
      callback(false, validateResult.message);
    }
  }

  ValidationResult validateSignUp(String userType, String fname, String lname, String zipCode, String email, String password, String confirmPwd) {

    if (fname.isEmpty) {
      return ValidationResult(false, LabelStr.enterFname);
    } else if (!fname.contains(RegExp(r'^[a-zA-Z]')) && fname.length < 3) {
      return ValidationResult(false, LabelStr.enterValidFname);
    }

    if (lname.isEmpty) {
      return ValidationResult(false, LabelStr.enterLname);
    } else if (!lname.contains(RegExp(r'^[a-zA-Z]')) && lname.length < 3) {
      return ValidationResult(false, LabelStr.enterValidLname);
    }

    if(userType.compareTo("ParentGuardian") == 0){
      if (zipCode.isEmpty) {
        return ValidationResult(false, LabelStr.enterZipCode);
      } else if(zipCode.length !=5){
        return ValidationResult(false, LabelStr.enterValidZipCode);
      }
    }

    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if (!email.startsWith(RegExp(r'^[a-zA-Z]'))) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    } else if (!Utils.isValidEmail(email)) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    }

    if (password.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserPwd);
    } else if (password.length < 8) {
      return ValidationResult(false, LabelStr.invalidPassword);
    } else if (password.length > 15) {
      return ValidationResult(false, LabelStr.invalidPasswordMax);
    }

    if (confirmPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterConfirmPwd);
    } else if (password.compareTo(confirmPwd) != 0) {
      return ValidationResult(false, LabelStr.pwdNotMatchError1);
    } else if (password.length > 15) {
      return ValidationResult(false, LabelStr.invalidPasswordMax);
    }
    return ValidationResult(true, "success");
  }

  void signUpResult(String userType, String fname, String lname, String dob, String zipCode, String email, String password, String confirmPwd, int schoolId, ResponseCallback callback) {
    late var params;
    String apiMethod="";
    if(schoolId == null){
      schoolId = 0;
    }
    if(userType.compareTo("Student") == 0){
      apiMethod = WebService.studentSignUp;
      params = {
        "password": password,
        "firstName": fname,
        "lastName": lname,
        "dob": dob,
        "email": email,
        "profileImageURL": "",
        "schoolId": schoolId,
        "role": userType,
        "isApprove": false,
        "isRejected": false,
      };
    } else if(userType.compareTo("Community") == 0){
      apiMethod = WebService.communitySignUp;
      params = {
        "password": password,
        "firstName": fname,
        "lastName": lname,
        "email": email,
        "profileImageURL": "",
        "schoolId": schoolId,
        "role": userType,
        "isApprove": false,
        "isRejected": false,
      };
    } else{
      apiMethod = WebService.parentSignUp;
      params = {
        "password": password,
        "firstName": fname,
        "lastName": lname,
        "zipCode": zipCode,
        "email": email,
        "profileImageURL": "",
        "schoolId": schoolId,
        "role": userType,
        "isApprove": false,
        "isRejected": false,
      };
    }
    var validateResult = validateSignUp(userType,  fname, lname, zipCode, email, password, confirmPwd);
    if (validateResult.isValid) {
      WebService.postAPICall(apiMethod, params).then((response) {
        if (response.statusCode == 1) {
          callback(true, LabelStr.lblRegistered);
        } else {
          callback(false, response.message);
        }
      }).catchError((error) {
        print(error);
        callback(false, LabelStr.serverError);
      });
    } else {
      callback(false, validateResult.message);
    }
  }

  void getAllEventForMobile(String schoolId, ResponseCallback callback) {
    var params = {"SchoolId": schoolId};
    WebService.getAPICall(WebService.parentGetAllEventForMobile, params).then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          eventForMobileList = [];
          for (var data in response.body) {
            eventForMobileList.add(EventForMobileResponse.fromJson(data));
          }
          callback(true, "");
        }
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }
}
