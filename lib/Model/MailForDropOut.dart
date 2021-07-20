class MailForDropOut {
    String messageText;
    String title;

    MailForDropOut({required this.messageText, required this.title});

    factory MailForDropOut.fromJson(Map<String, dynamic> json) {
        return MailForDropOut(
            messageText: json['messageText'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['messageText'] = this.messageText;
        data['title'] = this.title;
        return data;
    }
}