import 'package:ai_chatboat/model/export_libreary.dart';

class UserQuery {
  int? user;
  String? text;
  String? datetime;
  String? email;

  UserQuery({
    this.user,
    this.text,
    this.datetime,
    this.email,
  });

  factory UserQuery.fromJson(Map<String, dynamic> json) => UserQuery(
        user: json["user"],
        text: json["text"],
        datetime: json["datetime"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "text": text,
        "datetime": datetime,
        "email": email,
      };
}

class ListItem {
  RxBool isLike = false.obs;
  RxBool isDisLike = false.obs;

  ListItem({required this.isLike, required this.isDisLike});

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      ListItem(isDisLike: json["isDisLike"], isLike: json["isLike"]);

  Map<String, dynamic> toJson() => {"isDisLike": isDisLike, "isLike": isLike};
}
