class DropOutPreventionEmailsModel {
    int id;
    String specialistEmail;
    String specialistName;

    DropOutPreventionEmailsModel({required this.id, required this.specialistEmail, required this.specialistName});

    factory DropOutPreventionEmailsModel.fromJson(Map<String, dynamic> json) {
        return DropOutPreventionEmailsModel(
            id: json['id'], 
            specialistEmail: json['specialistEmail'], 
            specialistName: json['specialistName'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['specialistEmail'] = this.specialistEmail;
        data['specialistName'] = this.specialistName;
        return data;
    }
}