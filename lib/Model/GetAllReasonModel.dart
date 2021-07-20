class GetAllReasonModel {
    int id;
    String reason;

    GetAllReasonModel({required this.id, required this.reason});

    factory GetAllReasonModel.fromJson(Map<String, dynamic> json) {
        return GetAllReasonModel(
            id: json['id'], 
            reason: json['reason'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['reason'] = this.reason;
        return data;
    }
}