/// id : 23
/// role : "Student"
/// accessToken : "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIyMyIsInJvbGUiOiJTdHVkZW50IiwiZXhwIjoxNjI0NTU0MzE2LCJpc3MiOiJUdWNvbkFQSSIsImF1ZCI6IlR1Y29uQVBJIn0.p_TyQYV7kasc1hm3Nf2Ut9h24NE28GcmxsbohkSEYZtCSXIYmVN3xiepZgkTzWztYPCMvQLIJE6iSA2BQvF8YQ"
/// email : "vinay@gmail.com"
/// firstName : "vinay"
/// lastName : "thakkar"
/// image : null
/// blob : null

class LoginResponse {
  late int _id;
  late String _role;
  late String _accessToken;
  late String _email;
  late String _firstName;
  late String _lastName;
  late dynamic _image;
  late dynamic _blob;

  int get id => _id;
  String get role => _role;
  String get accessToken => _accessToken;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  dynamic get image => _image;
  dynamic get blob => _blob;

  LoginResponse({
    required int id,
    required String role,
    required String accessToken,
    required String email,
    required String firstName,
    required String lastName,
      dynamic image, 
      dynamic blob}){
    _id = id;
    _role = role;
    _accessToken = accessToken;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _image = image;
    _blob = blob;
}

  LoginResponse.fromJson(dynamic json) {
    _id = json["id"];
    _role = json["role"];
    _accessToken = json["accessToken"];
    _email = json["email"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _image = json["image"];
    _blob = json["blob"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["role"] = _role;
    map["accessToken"] = _accessToken;
    map["email"] = _email;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["image"] = _image;
    map["blob"] = _blob;
    return map;
  }

}