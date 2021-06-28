class ContentTransactionTypeJoin {
    int contentMasterId;
    int contentTransTypeId;
    String contentTransTypeName;
    int contentTransactionId;
    String objectName;
    String objectPath;

    ContentTransactionTypeJoin({required this.contentMasterId, required this.contentTransTypeId, required this.contentTransTypeName, required this.contentTransactionId, required this.objectName, required this.objectPath});

    factory ContentTransactionTypeJoin.fromJson(Map<String, dynamic> json) {
        return ContentTransactionTypeJoin(
            contentMasterId: json['contentMasterId'], 
            contentTransTypeId: json['contentTransTypeId'], 
            contentTransTypeName: json['contentTransTypeName'], 
            contentTransactionId: json['contentTransactionId'], 
            objectName: json['objectName'], 
            objectPath: json['objectPath'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['contentMasterId'] = this.contentMasterId;
        data['contentTransTypeId'] = this.contentTransTypeId;
        data['contentTransTypeName'] = this.contentTransTypeName;
        data['contentTransactionId'] = this.contentTransactionId;
        data['objectName'] = this.objectName;
        data['objectPath'] = this.objectPath;
        return data;
    }
}