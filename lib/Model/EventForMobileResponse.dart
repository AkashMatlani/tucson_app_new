class EventForMobileResponse {
    late  int createdBy;
    late String createdOn;
    late String eventDetail;
    late  String eventName;
    late int eventTypeId;
    late String eventTypeName;
    late String freeFields1;
    late String freeFields2;
    late String freeFields3;
    late String freeFields4;
    late String fromDateTime;
    late  bool isActive;
    late int schoolId;
    late String schoolName;
    late bool shareMode;
    late String toDateTime;
    late int tusdEventId;
    late int updatedBy;
    late String updatedOn;

    EventForMobileResponse({required this.createdBy, required this.createdOn, required this.eventDetail, required this.eventName, required this.eventTypeId, required this.eventTypeName, required this.freeFields1, required this.freeFields2, required this.freeFields3, required this.freeFields4, required this.fromDateTime, required this.isActive, required this.schoolId, required this.schoolName, required this.shareMode, required this.toDateTime, required this.tusdEventId, required this.updatedBy, required this.updatedOn});

    factory EventForMobileResponse.fromJson(Map<String, dynamic> json) {
        return EventForMobileResponse(
            createdBy: json['createdBy'], 
            createdOn: json['createdOn'], 
            eventDetail: json['eventDetail'], 
            eventName: json['eventName'], 
            eventTypeId: json['eventTypeId'], 
            eventTypeName: json['eventTypeName'], 
            freeFields1: json['freeFields1'], 
            freeFields2: json['freeFields2'], 
            freeFields3: json['freeFields3'], 
            freeFields4: json['freeFields4'], 
            fromDateTime: json['fromDateTime'], 
            isActive: json['isActive'], 
            schoolId: json['schoolId'], 
            schoolName: json['schoolName'], 
            shareMode: json['shareMode'], 
            toDateTime: json['toDateTime'], 
            tusdEventId: json['tusdEventId'], 
            updatedBy: json['updatedBy'], 
            updatedOn: json['updatedOn'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createdBy'] = this.createdBy;
        data['createdOn'] = this.createdOn;
        data['eventDetail'] = this.eventDetail;
        data['eventName'] = this.eventName;
        data['eventTypeId'] = this.eventTypeId;
        data['eventTypeName'] = this.eventTypeName;
        data['freeFields1'] = this.freeFields1;
        data['freeFields2'] = this.freeFields2;
        data['freeFields3'] = this.freeFields3;
        data['freeFields4'] = this.freeFields4;
        data['fromDateTime'] = this.fromDateTime;
        data['isActive'] = this.isActive;
        data['schoolId'] = this.schoolId;
        data['schoolName'] = this.schoolName;
        data['shareMode'] = this.shareMode;
        data['toDateTime'] = this.toDateTime;
        data['tusdEventId'] = this.tusdEventId;
        data['updatedBy'] = this.updatedBy;
        data['updatedOn'] = this.updatedOn;
        return data;
    }
}