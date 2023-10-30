class DocumentModel {
  final String? token;
  DocumentModel({required this.token});

  factory DocumentModel.fromMap(Map<String, dynamic> json) {
    return DocumentModel(token: json["push_notification_token"]);
  }

  Map<String, dynamic> toMap() => {
        "push_notification_token": token,
      };
}
