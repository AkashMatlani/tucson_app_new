import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:tucson_app/GeneralUtils/LabelStr.dart';

class WebService {

  static const baseUrl = "http://35.231.45.54:99/api/";

  static const userLogin = "User/Login";
  static const changePassword = "User/ChangePassword";
  static const resetPassword = "User/ResetPassword";
  static const forgotPassword = "User/ForgotPassword";


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
    var jsValue = json.decode(response.body);
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

    var jsValue = json.decode(response.body);
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
      print(response.body);
      var jsValue = json.decode(response.body);
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
}

class ServerResponse {
  var message = LabelStr.serverError;
  var body;
  var statusCode = 0;

  ServerResponse();

  ServerResponse.withJson(Map<String, dynamic> jsonObj) {
    if(jsonObj.containsKey("success")){
      this.statusCode = 1;
      if (jsonObj["output"] != null)
        this.body = jsonObj["output"];
      else
        this.body = jsonObj;

      this.message = "Success";
    } else {
      this.statusCode = 0;
      this.message = jsonObj[0]["errorMessage"];
      print("========= ${this.message}  =========");
    }
    print("********************* parsing response done **************************");
  }
}