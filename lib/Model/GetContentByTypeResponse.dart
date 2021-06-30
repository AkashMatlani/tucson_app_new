import 'package:tucson_app/Model/ContentTransactionTypeJoin.dart';

/*
class GetContentByTypeResponse {
    int contentMasterId;
    String contentTitle;
    List<ContentTransactionTypeJoin> contentTransactionTypeJoin;
    int contentTypeId;
    int schoolId;
    String schoolName;

    GetContentByTypeResponse({required this.contentMasterId, required this.contentTitle, required this.contentTransactionTypeJoin, required this.contentTypeId, required this.schoolId, required this.schoolName});

    factory GetContentByTypeResponse.fromJson(Map<String, dynamic> json) {
        return GetContentByTypeResponse(
            contentMasterId: json['contentMasterId'], 
            contentTitle: json['contentTitle'], 
            contentTransactionTypeJoin: json['contentTransactionTypeJoin'] != null ? (json['contentTransactionTypeJoin'] as List).map((i) => ContentTransactionTypeJoin.fromJson(i)).toList() : null, 
            contentTypeId: json['contentTypeId'], 
            schoolId: json['schoolId'], 
            schoolName: json['schoolName'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['contentMasterId'] = this.contentMasterId;
        data['contentTitle'] = this.contentTitle;
        data['contentTypeId'] = this.contentTypeId;
        data['schoolId'] = this.schoolId;
        data['schoolName'] = this.schoolName;
        if (this.contentTransactionTypeJoin != null) {
            data['contentTransactionTypeJoin'] = this.contentTransactionTypeJoin.map((v) => v.toJson()).toList();
        }
        return data;
    }
}*/
