/// tusdEventId : 18
/// schoolId : 0
/// eventTypeId : 1
/// eventName : "Demo events for all the  school"
/// fromDateTime : "2021-07-11T00:00:00"
/// toDateTime : "2021-07-15T00:00:00"
/// eventDetail : "<h2>1. Compelling event descriptions</h2><p>The event description is one of the most crucial elements of the event website.</p><p>It needs to be clear, concise, and have a strong CTA to drive attendees to purchase a ticket or secure an RSVP. Don&#8217;t forget to make sure it&#8217;s written well, free of typos and grammar mistakes. Even though writing a few sentences may seem easy, it can still be a tricky task for less experienced writers. If you need a hand, you can always employ the writing help of writing services like&#160;<a href=\"https://www.essaysontime.com.au/\">EssaysOnTime</a>&#160;or Fiverr.<br><br></p><h2>2. Company info and contact information</h2><p>Adding company information and contacts is the idea which makes sense. This way, you will allow potential guests and clients to approach you and ask about the other details of your event, so don&#8217;t make a rookie mistake and forget to provide them with some basic information.</p><div class=\"wp-block-lazyblock-client-type-planners lazyblock-client-type-planners-Z18D4HD\"><a href=\"https://www.socialtables.com/signup/\"><div class=\"cta-block\"><h2>Bring successful</h2></div></a></div>"
/// freeFields1 : ""
/// freeFields2 : ""
/// freeFields3 : ""
/// freeFields4 : ""
/// isActive : true
/// shareMode : false
/// createdBy : 0
/// createdOn : "0001-01-01T00:00:00"
/// updatedBy : 0
/// updatedOn : "0001-01-01T00:00:00"
/// eventTypeName : "Virtual"
/// schoolName : null
/// startTime : "1:30 AM"
/// endTime : "3:30 AM"
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
  dynamic _schoolName;
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
  dynamic get schoolName => _schoolName;
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
      dynamic schoolName, 
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