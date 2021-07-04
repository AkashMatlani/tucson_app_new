/// tusdSupportId : 4
/// schoolId : 14
/// supportDocument : "https://www.youtube.com/watch?v=CKtpvm-cFwk"
/// contents : ""
/// healthButtonAction : "https://paloverdebh.com/"
/// talkSpaceButtonAction : "https://www.talkspace.com/"
/// nsphPhoneNumber : "1-800-273-8255"
/// nsphChatUrl : "https://suicidepreventionlifeline.org/chat"
/// createdBy : 0
/// createdOn : "2021-07-03T16:30:25.8799816"
/// updatedBy : 0
/// updatedOn : "2021-07-04T10:10:42.1277206"
/// tusdSupportNotifierModel : [{"tusdSupportNotifierId":4,"notifierTypeId":1,"supportId":4,"notifierName":"De","notifierEmail":"de@e.com","notifierTypeName":"SEAO","createdBy":0,"createdOn":"0001-01-01T00:00:00","updatedBy":0,"updatedOn":"0001-01-01T00:00:00"},{"tusdSupportNotifierId":7,"notifierTypeId":1,"supportId":4,"notifierName":"Demo","notifierEmail":"demo@t.com","notifierTypeName":"SEAO","createdBy":0,"createdOn":"0001-01-01T00:00:00","updatedBy":0,"updatedOn":"0001-01-01T00:00:00"}]

class HealthSupportResponse {
  late int _tusdSupportId;
  late int _schoolId;
  late String _supportDocument;
  late String _contents;
  late String _healthButtonAction;
  late String _talkSpaceButtonAction;
  late String _nsphPhoneNumber;
  late String _nsphChatUrl;
  late int _createdBy;
  late String _createdOn;
  late int _updatedBy;
  late String _updatedOn;
  late List<TusdSupportNotifierModel> _tusdSupportNotifierModel;

  int get tusdSupportId => _tusdSupportId;
  int get schoolId => _schoolId;
  String get supportDocument => _supportDocument;
  String get contents => _contents;
  String get healthButtonAction => _healthButtonAction;
  String get talkSpaceButtonAction => _talkSpaceButtonAction;
  String get nsphPhoneNumber => _nsphPhoneNumber;
  String get nsphChatUrl => _nsphChatUrl;
  int get createdBy => _createdBy;
  String get createdOn => _createdOn;
  int get updatedBy => _updatedBy;
  String get updatedOn => _updatedOn;
  List<TusdSupportNotifierModel> get tusdSupportNotifierModel => _tusdSupportNotifierModel;

  HealthSupportResponse({
      int? tusdSupportId,
      int? schoolId,
      String? supportDocument,
      String? contents,
      String? healthButtonAction,
      String? talkSpaceButtonAction,
      String? nsphPhoneNumber,
      String? nsphChatUrl,
      int? createdBy,
      String? createdOn,
      int? updatedBy,
      String? updatedOn,
      List<TusdSupportNotifierModel>? tusdSupportNotifierModel}){
    _tusdSupportId = tusdSupportId!;
    _schoolId = schoolId!;
    _supportDocument = supportDocument!;
    _contents = contents!;
    _healthButtonAction = healthButtonAction!;
    _talkSpaceButtonAction = talkSpaceButtonAction!;
    _nsphPhoneNumber = nsphPhoneNumber!;
    _nsphChatUrl = nsphChatUrl!;
    _createdBy = createdBy!;
    _createdOn = createdOn!;
    _updatedBy = updatedBy!;
    _updatedOn = updatedOn!;
    _tusdSupportNotifierModel = tusdSupportNotifierModel!;
}

  HealthSupportResponse.fromJson(dynamic json) {
    _tusdSupportId = json["tusdSupportId"];
    _schoolId = json["schoolId"];
    _supportDocument = json["supportDocument"];
    _contents = json["contents"];
    _healthButtonAction = json["healthButtonAction"];
    _talkSpaceButtonAction = json["talkSpaceButtonAction"];
    _nsphPhoneNumber = json["nsphPhoneNumber"];
    _nsphChatUrl = json["nsphChatUrl"];
    _createdBy = json["createdBy"];
    _createdOn = json["createdOn"];
    _updatedBy = json["updatedBy"];
    _updatedOn = json["updatedOn"];
    if (json["tusdSupportNotifierModel"] != null) {
      _tusdSupportNotifierModel = [];
      json["tusdSupportNotifierModel"].forEach((v) {
        _tusdSupportNotifierModel.add(TusdSupportNotifierModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["tusdSupportId"] = _tusdSupportId;
    map["schoolId"] = _schoolId;
    map["supportDocument"] = _supportDocument;
    map["contents"] = _contents;
    map["healthButtonAction"] = _healthButtonAction;
    map["talkSpaceButtonAction"] = _talkSpaceButtonAction;
    map["nsphPhoneNumber"] = _nsphPhoneNumber;
    map["nsphChatUrl"] = _nsphChatUrl;
    map["createdBy"] = _createdBy;
    map["createdOn"] = _createdOn;
    map["updatedBy"] = _updatedBy;
    map["updatedOn"] = _updatedOn;
    if (_tusdSupportNotifierModel != null) {
      map["tusdSupportNotifierModel"] = _tusdSupportNotifierModel.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// tusdSupportNotifierId : 4
/// notifierTypeId : 1
/// supportId : 4
/// notifierName : "De"
/// notifierEmail : "de@e.com"
/// notifierTypeName : "SEAO"
/// createdBy : 0
/// createdOn : "0001-01-01T00:00:00"
/// updatedBy : 0
/// updatedOn : "0001-01-01T00:00:00"

class TusdSupportNotifierModel {
  late int _tusdSupportNotifierId;
  late int _notifierTypeId;
  late int _supportId;
  late String _notifierName;
  late String _notifierEmail;
  late String _notifierTypeName;
  late int _createdBy;
  late String _createdOn;
  late int _updatedBy;
  late String _updatedOn;

  int get tusdSupportNotifierId => _tusdSupportNotifierId;
  int get notifierTypeId => _notifierTypeId;
  int get supportId => _supportId;
  String get notifierName => _notifierName;
  String get notifierEmail => _notifierEmail;
  String get notifierTypeName => _notifierTypeName;
  int get createdBy => _createdBy;
  String get createdOn => _createdOn;
  int get updatedBy => _updatedBy;
  String get updatedOn => _updatedOn;

  TusdSupportNotifierModel({
      int? tusdSupportNotifierId,
      int? notifierTypeId,
      int? supportId,
      String? notifierName,
      String? notifierEmail,
      String? notifierTypeName,
      int? createdBy,
      String? createdOn,
      int? updatedBy,
      String? updatedOn}){
    _tusdSupportNotifierId = tusdSupportNotifierId!;
    _notifierTypeId = notifierTypeId!;
    _supportId = supportId!;
    _notifierName = notifierName!;
    _notifierEmail = notifierEmail!;
    _notifierTypeName = notifierTypeName!;
    _createdBy = createdBy!;
    _createdOn = createdOn!;
    _updatedBy = updatedBy!;
    _updatedOn = updatedOn!;
}

  TusdSupportNotifierModel.fromJson(dynamic json) {
    _tusdSupportNotifierId = json["tusdSupportNotifierId"];
    _notifierTypeId = json["notifierTypeId"];
    _supportId = json["supportId"];
    _notifierName = json["notifierName"];
    _notifierEmail = json["notifierEmail"];
    _notifierTypeName = json["notifierTypeName"];
    _createdBy = json["createdBy"];
    _createdOn = json["createdOn"];
    _updatedBy = json["updatedBy"];
    _updatedOn = json["updatedOn"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["tusdSupportNotifierId"] = _tusdSupportNotifierId;
    map["notifierTypeId"] = _notifierTypeId;
    map["supportId"] = _supportId;
    map["notifierName"] = _notifierName;
    map["notifierEmail"] = _notifierEmail;
    map["notifierTypeName"] = _notifierTypeName;
    map["createdBy"] = _createdBy;
    map["createdOn"] = _createdOn;
    map["updatedBy"] = _updatedBy;
    map["updatedOn"] = _updatedOn;
    return map;
  }

}