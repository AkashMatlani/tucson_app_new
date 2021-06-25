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
}
