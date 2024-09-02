import 'package:ai_chatboat/model/export_libreary.dart';

class UserQuery {
  int? user;
  String? text;
  String? datetime;
  String? email;
  bool like = false;
  bool disLike = false;

  UserQuery({
    this.user,
    this.text,
    this.datetime,
    this.email,
    required this.like, required this.disLike
  });

  factory UserQuery.fromJson(Map<String, dynamic> json) =>
      UserQuery(
          user: json["user"],
          text: json["text"],
          datetime: json["datetime"],
          email: json["email"],
          disLike: json["isDisLike"],
          like: json["isLike"]
      );

  Map<String, dynamic> toJson() =>
      {
        "user": user,
        "text": text,
        "datetime": datetime,
        "email": email,
        "isDisLike": disLike, "isLike": like
      };
}

