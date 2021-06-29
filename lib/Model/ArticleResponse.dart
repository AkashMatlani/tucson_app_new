import 'package:tucson_app/Model/ContentTransactionTypeJoin.dart';

class ArticleResponse {
  /*  late int contentMasterId;
    late String contentTitle;
    late List<ContentTransactionTypeJoin> contentTransactionTypeJoin;
    late int contentTypeId;
    late Object contents;
    late int schoolId;
    late String schoolName;

    ArticleResponse({required this.contentMasterId, required this.contentTitle, required this.contentTransactionTypeJoin, required this.contentTypeId, required this.contents, required this.schoolId, required this.schoolName});

    factory ArticleResponse.fromJson(Map<String, dynamic> json) {
        return ArticleResponse(
            contentMasterId: json['contentMasterId'], 
            contentTitle: json['contentTitle'], 
            contentTransactionTypeJoin: (json['contentTransactionTypeJoin'] as List).map((i) => ContentTransactionTypeJoin.fromJson(i)).toList(),
            contentTypeId: json['contentTypeId'], 
            contents:  Object.fromJson(json['contents']),
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
        if (this.contents != null) {
            data['contents'] = this.contents.toJson();
        }
        return data;
    }*/
}