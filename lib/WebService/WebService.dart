import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tucson_app/GeneralUtils/LabelStr.dart';
import 'package:tucson_app/GeneralUtils/PrefsUtils.dart';
import 'package:tucson_app/GeneralUtils/Utils.dart';

class WebService {

  static const baseUrl = "http://35.231.45.54:99/api/";

  static const getTranslateApiKey = "User/GetAPIByName";
  static const userLogin = "User/Login";
  static const changePassword = "User/ChangePassword";
  static const resetPassword = "User/ResetPasswordForMobile";
  static const forgotPassword = "User/ForgotPassword";
  static const getUserStatus = "User/GetUserStatus";
  static const donationURL = "TUSDConfiguration/GetDonationURL";
  static const schoolList = "School/GetAllForMobile";
  static const studentSignUp = "Student/Create";
  static const employeeSignUp = "Employee/Create";
  static const communitySignUp = "Community/Create";
  static const parentSignUp = "ParentGuardian/Create";
  static const allEventForMobile= "Event/GetAllEventForMobile";
  static const contentByType = "ContentMaster/GetContentByType";
  static const studentContentByType = "Student/GetContentByType";
  static const parentContentByType = "ParentGuardian/GetContentByType";
  static const tusdSupportBySchoolID = "TUSDSupport/GetBySchoolId";
  static const getSchoolCategoryType = "ContentMaster/GetSchoolCategoryType";
  static const supportNotifierMail = "User/SupportNotifierMail";
  static const getMentalSupportExist = "TUSDSupport/IsMentalHealthSupportExists";
  static const getAllDropoutSpeciality = "TUSDConfiguration/GetAllDropoutSpecialist";
  static const getAllReason = "TUSDConfiguration/GetAllReasons";
  static const sendDropOutPrevantionEmail = "TUSDConfiguration/SendDropoutPreventionEmail";

  static const communityContentByType = "Community/GetContentByType";


  static Future<ServerResponse> getAPICall(String apiName, Map<String, dynamic> params) async {
    var url = baseUrl + apiName;
    print("Get Url :"+url);
    var postUri = Uri.parse(url);

    var headers = {
      "Content-Type": 'application/json'
    };

    var response;
    if(params != null){
      String queryString = Uri(queryParameters: params).query;
      var requestUrl = url + '?' + queryString;
      var postUri = Uri.parse(requestUrl);
      response = await http.get(postUri, headers: headers);
    } else {
      response = await http.get(postUri, headers: headers);
    }
    var result = response.body;
    if(response.body[0].contains("[")){
      result = response.body.substring(1, response.body.length-1);
    } else {
      result = response.body;
    }
    var jsValue = json.decode(result);
    ServerResponse serverResponse = ServerResponse.withJson(jsValue);
    return serverResponse;
  }

  static Future<ServerResponse> getAPICallWithoutParmas(String apiName) async {
    var url = baseUrl + apiName;
    print("Get Url :"+url);
    var postUri = Uri.parse(url);

    var headers = {
      "Content-Type": 'application/json'
    };
    var response = await http.get(postUri, headers: headers);

    var result = response.body;
    if(response.body[0].contains("[")){
      result = response.body.substring(1, response.body.length-1);
    } else {
      result = response.body;
    }
    var jsValue = json.decode(result);
    ServerResponse serverResponse = ServerResponse.withJson(jsValue);
    return serverResponse;
  }

  static Future<ServerResponse> postAPICall(
      String apiName, Map<String, dynamic> params) async {
    var url = baseUrl + apiName;
    var postUri = Uri.parse(url);

    print("\n");
    print("Request URL: $url");
    print("Request parameters: $params");
    print("\n");

    var completer = Completer<ServerResponse>();

    var headers = {
      "Content-Type": 'application/json'
    };
    http.post(postUri, body: jsonEncode(params), headers: headers).then((response) {

      var result = response.body;
      if(response.body[0].contains("[")){
        result = response.body.substring(1, response.body.length-1);
      } else {
        result = response.body;
      }
      var jsValue = json.decode(result);
      var serverResponseObj = ServerResponse.withJson(jsValue);
      completer.complete(serverResponseObj);
    }).catchError((error) {
      var response = ServerResponse();
      switch (error.runtimeType) {
        case SocketException:
          print("socekt exception");
          response.message = error.osError.message;
          break;
        default:
          response.message = error.toString();
          break;
      }
      response.statusCode = 0;
      completer.complete(response);
    });
    return completer.future;
  }

  static Future<ServerResponse> multiPartAPI(String apiName, Map<String, String> params, String imageKey, String filePath) async {
    var url = baseUrl + apiName;
    var postUri = Uri.parse(url);

    print("reqeust Url: \n$url");
    print("reqeust parameters: \n$params");
    var request = new MultipartRequest("POST", postUri);
    params.forEach((key, value) => {request.fields[key] = value});
    if (filePath != null) {
      var multiPart = await http.MultipartFile.fromPath(imageKey, filePath);
      request.files.add(multiPart);
    }

    var result = await request.send();
    var completer = Completer<ServerResponse>();

    result.stream.transform(utf8.decoder).listen((body) {
      var value = json.decode(body);
      print(value);
      var serverResponseObj = ServerResponse.withJson(value);
      completer.complete(serverResponseObj);
    });
    return completer.future;
  }

  static translateApiCall(String language, String data, ResponseCallback callback) async{
    String API_KEY = await PrefUtils.getValueFor(PrefUtils.googleTranslateKey);
    if(API_KEY.isNotEmpty){
      var url = "https://translation.googleapis.com/language/translate/v2?target=$language&key=$API_KEY&q=$data";
      var headers = {
        //"Content-Type": 'text/html'
        "Content-Type": 'application/json'
      };
      var response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var jsValue = json.decode(response.body);
        var responseList = jsValue["data"]["translations"] as List;
        var responseRow = responseList.first;
        var resultStr = responseRow["translatedText"];
        //var formattedResult = HtmlUnescape().convert(resultStr);
        callback(true, resultStr);
      } else {
        print("*********** Api Response Error *********************");
        callback(false, response.body.toString());
        print("ErrorCode ::${response.statusCode} \n ErrorMessage ::${response.body.toString()}");
        print("******************************************************");
      }
    }
  }
}

class ServerResponse {
  var message = LabelStr.connectionError;
  var body;
  var statusCode = 0;

  ServerResponse();

  ServerResponse.withJson(Map<String, dynamic> jsonObj) {
    if(jsonObj.containsKey("success")){
      if (jsonObj["output"] != null){
        this.statusCode = 1;
        this.message = "Success";
        this.body = jsonObj["output"];
        if(this.body.toString().compareTo("[]")==0){
          this.body = null;
        }
      } else {
        this.statusCode = 1;
        this.message = "Success";
        this.body = jsonObj;
      }
    } else {
      this.statusCode = 0;
      this.message = jsonObj["errorMessage"];
    }
    print("********************* parsing response done **************************");
  }
}