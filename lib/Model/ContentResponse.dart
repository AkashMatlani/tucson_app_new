/// contentMasterId : 137
/// schoolId : 13
/// contentTypeId : 23
/// contentTitle : "Latest Jobs"
/// schoolName : "Hiramani"
/// contentTransactionTypeJoin : [{"contentTransactionId":87,"contentMasterId":137,"contentTransTypeId":9,"objectName":"Administrative Assistant (Effective 2021-2022 SCHOOL YEAR)","objectPath":"https://jobs.tusd1.org/administrative-assistant-effective-2021-2022-school-year/job/16872708","contentTransTypeName":"Links"},{"contentTransactionId":88,"contentMasterId":137,"contentTransTypeId":9,"objectName":"Assistant Principal - Sabino High School (Effective 2021-2022 SCHOOL YEAR)","objectPath":"https://jobs.tusd1.org/assistant-principal-sabino-high-school-effective-2021-2022-school-year/job/16752914","contentTransTypeName":"Links"}]

class ContentResponse {
  late int _contentMasterId;
  late int _schoolId;
  late int _contentTypeId;
  late String _contentTitle;
  late String _schoolName;
  late List<ContentTransactionResponse> _contentTransactionTypeJoin;

  int get contentMasterId => _contentMasterId;
  int get schoolId => _schoolId;
  int get contentTypeId => _contentTypeId;
  String get contentTitle => _contentTitle;
  String get schoolName => _schoolName;
  List<ContentTransactionResponse> get contentTransactionTypeJoin => _contentTransactionTypeJoin;

  ContentResponse({
    required int contentMasterId,
    required int schoolId,
    required int contentTypeId,
    required String contentTitle,
    required String schoolName,
    required List<ContentTransactionResponse> contentTransactionTypeJoin}){
    _contentMasterId = contentMasterId;
    _schoolId = schoolId;
    _contentTypeId = contentTypeId;
    _contentTitle = contentTitle;
    _schoolName = schoolName;
    _contentTransactionTypeJoin = contentTransactionTypeJoin;
}

  ContentResponse.fromJson(dynamic json) {
    _contentMasterId = json["contentMasterId"];
    _schoolId = json["schoolId"];
    _contentTypeId = json["contentTypeId"];
    _contentTitle = json["contentTitle"];
    _schoolName = json["schoolName"];
    if (json["contentTransactionTypeJoin"] != null) {
      _contentTransactionTypeJoin = [];
      json["contentTransactionTypeJoin"].forEach((v) {
        _contentTransactionTypeJoin.add(ContentTransactionResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["contentMasterId"] = _contentMasterId;
    map["schoolId"] = _schoolId;
    map["contentTypeId"] = _contentTypeId;
    map["contentTitle"] = _contentTitle;
    map["schoolName"] = _schoolName;
    if (_contentTransactionTypeJoin != null) {
      map["contentTransactionTypeJoin"] = _contentTransactionTypeJoin.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// contentTransactionId : 87
/// contentMasterId : 137
/// contentTransTypeId : 9
/// objectName : "Administrative Assistant (Effective 2021-2022 SCHOOL YEAR)"
/// objectPath : "https://jobs.tusd1.org/administrative-assistant-effective-2021-2022-school-year/job/16872708"
/// contentTransTypeName : "Links"

class ContentTransactionResponse {
  late int _contentTransactionId;
  late int _contentMasterId;
  late int _contentTransTypeId;
  late String _objectName;
  late String _objectPath;
  late String _contentTransTypeName;

  int get contentTransactionId => _contentTransactionId;
  int get contentMasterId => _contentMasterId;
  int get contentTransTypeId => _contentTransTypeId;
  String get objectName => _objectName;
  String get objectPath => _objectPath;
  String get contentTransTypeName => _contentTransTypeName;

  ContentTransactionResponse({
    required int contentTransactionId,
    required int contentMasterId,
    required int contentTransTypeId,
    required String objectName,
    required String objectPath,
    required String contentTransTypeName}){
    _contentTransactionId = contentTransactionId;
    _contentMasterId = contentMasterId;
    _contentTransTypeId = contentTransTypeId;
    _objectName = objectName;
    _objectPath = objectPath;
    _contentTransTypeName = contentTransTypeName;
}

  ContentTransactionResponse.fromJson(dynamic json) {
    _contentTransactionId = json["contentTransactionId"];
    _contentMasterId = json["contentMasterId"];
    _contentTransTypeId = json["contentTransTypeId"];
    _objectName = json["objectName"];
    _objectPath = json["objectPath"];
    _contentTransTypeName = json["contentTransTypeName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["contentTransactionId"] = _contentTransactionId;
    map["contentMasterId"] = _contentMasterId;
    map["contentTransTypeId"] = _contentTransTypeId;
    map["objectName"] = _objectName;
    map["objectPath"] = _objectPath;
    map["contentTransTypeName"] = _contentTransTypeName;
    return map;
  }

}