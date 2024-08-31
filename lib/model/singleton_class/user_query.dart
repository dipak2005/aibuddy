class UserQuery {
  int? user;
  String? text;
  String? datetime;
  String? email;
  bool? isLike;
  bool? isDisLike;
  UserQuery({ this.user, this.text, this.datetime,this.email,this.isLike,this.isDisLike});

  factory UserQuery.fromJson(Map<String, dynamic> json) => UserQuery(

      user: json["user"],
      text: json["text"],
      datetime: json["datetime"],
      email: json["email"],
    isDisLike: json["isDisLike"],
    isLike: json["isLike"]
  );

  Map<String,dynamic> toJson () =>{
    "user":user,
    "text":text,
    "datetime":datetime,
    "email":email,
    "isDisLike":isDisLike,
    "isLike":isLike
  };
}