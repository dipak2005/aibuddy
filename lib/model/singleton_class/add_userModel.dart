

import 'dart:convert';

AddUser addUserFromJson(String str) =>
    AddUser.fromJson(json.decode(str));

String adduserToJson(AddUser data) => json.encode(data.toJson());

class AddUser {
  String? email;

  DateTime? dateTime;

  AddUser({this.email, this.dateTime});

  factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
    email: json["email"],

    dateTime: json["datetime"],
  );

  Map<String, dynamic> toJson() =>
      {"email": email,  "datetime": dateTime};
}