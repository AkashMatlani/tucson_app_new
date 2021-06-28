import 'package:tucson_app/GeneralUtils/Constant.dart';
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';
import 'package:tucson_app/Model/LoginResponse.dart';
import 'package:tucson_app/WebService/WebService.dart';


class AuthViewModel {

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
    } else if (password.length < 6) {
      return ValidationResult(false, LabelStr.invalidPassword);
    }
    return ValidationResult(true, "success");
  }

  void logInResult(String email, String password, ResponseCallback callback) {
    var params = {"userName": email, "password": password};

    var validateResult = validateLogIn(email, password);
    if (validateResult.isValid) {
      WebService.postAPICall(WebService.userLogin, params).then((response) {
        if (response.statusCode == 1) {
          if (response.body != null) {
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

  ValidationResult validateSignUp(String fname, String lname, String email, String password, String confirmPwd) {

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

    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if (!email.startsWith(RegExp(r'^[a-zA-Z]'))) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    } else if (!Utils.isValidEmail(email)) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    }

    if (password.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserPwd);
    } else if (password.length < 6) {
      return ValidationResult(false, LabelStr.invalidPassword);
    }

    if (confirmPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterConfirmPwd);
    } else if (password.compareTo(confirmPwd) != 0) {
      return ValidationResult(false, LabelStr.pwdNotMatchError);
    }
    return ValidationResult(true, "success");
  }

  void signUpResult(String userType, String fname, String lname, String dob, String email, String password, String confirmPwd, int schoolId, ResponseCallback callback) {
    var params = {
      "password": password,
      "firstName": fname,
      "lastName": lname,
      "dob": dob,
      "email": email,
      "phoneNumber": "",
      "profileImageURL": "",
      if(userType.compareTo("Student") == 0)
        "schoolId": schoolId,
      "role": userType
    };

    String apiMethod="";
    if(userType.compareTo("Student") == 0){
      apiMethod = WebService.studentSignUp;
    } else if(userType.compareTo("Community") == 0){
      apiMethod = WebService.communitySignUp;
    } else{
      apiMethod = WebService.parentSignUp;
    }
    var validateResult = validateSignUp(fname, lname, email, password, confirmPwd);
    if (validateResult.isValid) {
      WebService.postAPICall(apiMethod, params).then((response) {
        if (response.statusCode == 1) {
          callback(true, "");
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

  void getDonationAPICall( ResponseCallback callback) {
    WebService.getAPICallWithoutParmas(WebService.donationURL).then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          callback(true, response.body);
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
