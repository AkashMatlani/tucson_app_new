/// configurationId : 3
/// contentTransTypeID : 6
/// contentTransType : null
/// objectName : "Giving/Donation"
/// objectPath : "https://az-tucson-lite.intouchreceipting.com/fundraisers"
/// content : "<blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><blockquote style=\"margin-bottom: 0px; margin-left: 40px; border: none; padding: 0px;\"><div class=\"iKJnec\" aria-level=\"3\" role=\"heading\"><div class=\"iKJnec\" aria-level=\"3\" role=\"heading\"><font face=\"Calibri\"><span style=\"font-weight: bolder;\">Gifts &amp; Donations</span></font></div></div></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote></blockquote><div class=\"iKJnec\" aria-level=\"3\" role=\"heading\"><div class=\"iKJnec\" aria-level=\"3\" role=\"heading\"><font face=\"Times New Roman\"><br></font></div><div class=\"iKJnec\" aria-level=\"3\" role=\"heading\"><font face=\"Calibri\">Private support allows us to infuse additional resources into programs and services that enhance and enrich experiences for students and families.&nbsp;</font></div></div>"
/// createdBy : 1
/// createdOn : "2021-06-25T13:52:26.79628"
/// updatedBy : 0
/// updatedOn : "2021-07-13T17:49:47.226327"

class DonationResponse {
  int? _configurationId;
  int? _contentTransTypeID;
  dynamic _contentTransType;
  String? _objectName;
  String? _objectPath;
  String? _content;
  int? _createdBy;
  String? _createdOn;
  int? _updatedBy;
  String? _updatedOn;

  int? get configurationId => _configurationId;
  int? get contentTransTypeID => _contentTransTypeID;
  dynamic get contentTransType => _contentTransType;
  String? get objectName => _objectName;
  String? get objectPath => _objectPath;
  String? get content => _content;
  int? get createdBy => _createdBy;
  String? get createdOn => _createdOn;
  int? get updatedBy => _updatedBy;
  String? get updatedOn => _updatedOn;

  DonationResponse({
      int? configurationId,
      int? contentTransTypeID,
      dynamic contentTransType,
      String? objectName,
      String? objectPath,
      String? content,
      int? createdBy,
      String? createdOn,
      int? updatedBy,
      String? updatedOn}){
    _configurationId = configurationId;
    _contentTransTypeID = contentTransTypeID;
    _contentTransType = contentTransType;
    _objectName = objectName;
    _objectPath = objectPath;
    _content = content;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _updatedBy = updatedBy;
    _updatedOn = updatedOn;
}

  DonationResponse.fromJson(dynamic json) {
    _configurationId = json["configurationId"];
    _contentTransTypeID = json["contentTransTypeID"];
    _contentTransType = json["contentTransType"];
    _objectName = json["objectName"];
    _objectPath = json["objectPath"];
    _content = json["content"];
    _createdBy = json["createdBy"];
    _createdOn = json["createdOn"];
    _updatedBy = json["updatedBy"];
    _updatedOn = json["updatedOn"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["configurationId"] = _configurationId;
    map["contentTransTypeID"] = _contentTransTypeID;
    map["contentTransType"] = _contentTransType;
    map["objectName"] = _objectName;
    map["objectPath"] = _objectPath;
    map["content"] = _content;
    map["createdBy"] = _createdBy;
    map["createdOn"] = _createdOn;
    map["updatedBy"] = _updatedBy;
    map["updatedOn"] = _updatedOn;
    return map;
  }

}