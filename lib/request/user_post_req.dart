// To parse this JSON data, do
//
//     final userPostReq = userPostReqFromJson(jsonString);

import 'dart:convert';

UserPostReq userPostReqFromJson(String str) =>
    UserPostReq.fromJson(json.decode(str));

String userPostReqToJson(UserPostReq data) => json.encode(data.toJson());

class UserPostReq {
  String username;
  String password;

  UserPostReq({
    required this.username,
    required this.password,
  });

  factory UserPostReq.fromJson(Map<String, dynamic> json) => UserPostReq(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
