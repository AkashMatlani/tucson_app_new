/// tusdEventId : 26
/// schoolId : 0
/// eventTypeId : 2
/// eventName : "Back-to-School Sport-Physical Fair"
/// fromDateTime : "2021-07-25T18:30:00"
/// toDateTime : "2021-07-30T18:30:00"
/// eventDetail : "<span style=\"font-family: AvenirNext-DemiBold; font-size: 15px;\">Silbermond is a German female fronted rock and pop band from Bautzen in the district of Saxony. They were formed in 2000, at first under a different name and singing only in English language. In 2001, they changed their name into Silbermond and started to write songs only in German language. Their first album&nbsp;</span><em style=\"font-family: AvenirNext-DemiBold; font-size: 15px;\">Verschwende deine Zeit&nbsp;</em><span style=\"font-family: AvenirNext-DemiBold; font-size: 15px;\">(</span><em style=\"font-family: AvenirNext-DemiBold; font-size: 15px;\">Waste Your Time</em><span style=\"font-family: AvenirNext-DemiBold; font-size: 15px;\">) came out in 2004 and reached double platinum status in Germany and Austria. The rise of Silbermond began the general hype for female fronted rock bands in Germany, that brought them and similar bands like \"Wir sind Helden\" or \"Juli\" big success.</span>"
/// freeFields1 : ""
/// freeFields2 : ""
/// freeFields3 : ""
/// freeFields4 : ""
/// isActive : true
/// shareMode : true
/// createdBy : 0
/// createdOn : "0001-01-01T00:00:00"
/// updatedBy : 0
/// updatedOn : "0001-01-01T00:00:00"
/// eventTypeName : "Venue/Location"
/// schoolName : "Doolen Middle School"
/// startTime : "2:00 AM"
/// endTime : "9:00 PM"
/// schoolIds : null

class EventForMobileResponse {
  int? _tusdEventId;
  int? _schoolId;
  int? _eventTypeId;
  String? _eventName;
  String? _fromDateTime;
  String? _toDateTime;
  String? _eventDetail;
  String? _freeFields1;
  String? _freeFields2;
  String? _freeFields3;
  String? _freeFields4;
  bool? _isActive;
  bool? _shareMode;
  int? _createdBy;
  String? _createdOn;
  int? _updatedBy;
  String? _updatedOn;
  String? _eventTypeName;
  String? _schoolName;
  String? _startTime;
  String? _endTime;
  dynamic _schoolIds;

  int get tusdEventId => _tusdEventId!;
  int get schoolId => _schoolId!;
  int get eventTypeId => _eventTypeId!;
  String get eventName => _eventName!;
  String get fromDateTime => _fromDateTime!;
  String get toDateTime => _toDateTime!;
  String get eventDetail => _eventDetail!;
  String get freeFields1 => _freeFields1!;
  String get freeFields2 => _freeFields2!;
  String get freeFields3 => _freeFields3!;
  String get freeFields4 => _freeFields4!;
  bool get isActive => _isActive!;
  bool get shareMode => _shareMode!;
  int get createdBy => _createdBy!;
  String get createdOn => _createdOn!;
  int get updatedBy => _updatedBy!;
  String get updatedOn => _updatedOn!;
  String get eventTypeName => _eventTypeName!;
  String get schoolName => _schoolName!;
  String get startTime => _startTime!;
  String get endTime => _endTime!;
  dynamic get schoolIds => _schoolIds;

  EventForMobileResponse({
      int? tusdEventId,
      int? schoolId,
      int? eventTypeId,
      String? eventName,
      String? fromDateTime,
      String? toDateTime,
      String? eventDetail,
      String? freeFields1,
      String? freeFields2,
      String? freeFields3,
      String? freeFields4,
      bool? isActive,
      bool? shareMode,
      int? createdBy,
      String? createdOn,
      int? updatedBy,
      String? updatedOn,
      String? eventTypeName,
      String? schoolName,
      String? startTime,
      String? endTime,
      dynamic schoolIds}){
    _tusdEventId = tusdEventId;
    _schoolId = schoolId;
    _eventTypeId = eventTypeId;
    _eventName = eventName;
    _fromDateTime = fromDateTime;
    _toDateTime = toDateTime;
    _eventDetail = eventDetail;
    _freeFields1 = freeFields1;
    _freeFields2 = freeFields2;
    _freeFields3 = freeFields3;
    _freeFields4 = freeFields4;
    _isActive = isActive;
    _shareMode = shareMode;
    _createdBy = createdBy;
    _createdOn = createdOn;
    _updatedBy = updatedBy;
    _updatedOn = updatedOn;
    _eventTypeName = eventTypeName;
    _schoolName = schoolName;
    _startTime = startTime;
    _endTime = endTime;
    _schoolIds = schoolIds;
}

  EventForMobileResponse.fromJson(dynamic json) {
    _tusdEventId = json["tusdEventId"];
    _schoolId = json["schoolId"];
    _eventTypeId = json["eventTypeId"];
    _eventName = json["eventName"];
    _fromDateTime = json["fromDateTime"];
    _toDateTime = json["toDateTime"];
    _eventDetail = json["eventDetail"];
    _freeFields1 = json["freeFields1"];
    _freeFields2 = json["freeFields2"];
    _freeFields3 = json["freeFields3"];
    _freeFields4 = json["freeFields4"];
    _isActive = json["isActive"];
    _shareMode = json["shareMode"];
    _createdBy = json["createdBy"];
    _createdOn = json["createdOn"];
    _updatedBy = json["updatedBy"];
    _updatedOn = json["updatedOn"];
    _eventTypeName = json["eventTypeName"];
    _schoolName = json["schoolName"];
    _startTime = json["startTime"];
    _endTime = json["endTime"];
    _schoolIds = json["schoolIds"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["tusdEventId"] = _tusdEventId;
    map["schoolId"] = _schoolId;
    map["eventTypeId"] = _eventTypeId;
    map["eventName"] = _eventName;
    map["fromDateTime"] = _fromDateTime;
    map["toDateTime"] = _toDateTime;
    map["eventDetail"] = _eventDetail;
    map["freeFields1"] = _freeFields1;
    map["freeFields2"] = _freeFields2;
    map["freeFields3"] = _freeFields3;
    map["freeFields4"] = _freeFields4;
    map["isActive"] = _isActive;
    map["shareMode"] = _shareMode;
    map["createdBy"] = _createdBy;
    map["createdOn"] = _createdOn;
    map["updatedBy"] = _updatedBy;
    map["updatedOn"] = _updatedOn;
    map["eventTypeName"] = _eventTypeName;
    map["schoolName"] = _schoolName;
    map["startTime"] = _startTime;
    map["endTime"] = _endTime;
    map["schoolIds"] = _schoolIds;
    return map;
  }
}