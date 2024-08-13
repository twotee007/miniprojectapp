// To parse this JSON data, do
//
//     final userPostRes = userPostResFromJson(jsonString);

import 'dart:convert';

List<UserPostRes> userPostResFromJson(String str) => List<UserPostRes>.from(
    json.decode(str).map((x) => UserPostRes.fromJson(x)));

String userPostResToJson(List<UserPostRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserPostRes {
  int uid;
  String username;
  String password;
  String fullname;
  int wallet;
  String email;
  String type;
  String img;

  UserPostRes({
    required this.uid,
    required this.username,
    required this.password,
    required this.fullname,
    required this.wallet,
    required this.email,
    required this.type,
    required this.img,
  });

  factory UserPostRes.fromJson(Map<String, dynamic> json) => UserPostRes(
        uid: json["uid"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        wallet: json["wallet"],
        email: json["email"],
        type: json["type"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "password": password,
        "fullname": fullname,
        "wallet": wallet,
        "email": email,
        "type": type,
        "img": img,
      };
}
