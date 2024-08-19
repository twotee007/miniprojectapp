// To parse this JSON data, do
//
//     final useruidGetRes = useruidGetResFromJson(jsonString);

import 'dart:convert';

List<UseruidGetRes> useruidGetResFromJson(String str) =>
    List<UseruidGetRes>.from(
        json.decode(str).map((x) => UseruidGetRes.fromJson(x)));

String useruidGetResToJson(List<UseruidGetRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UseruidGetRes {
  int uid;
  String username;
  String password;
  String fullname;
  int wallet;
  String email;
  String type;
  String img;

  UseruidGetRes({
    required this.uid,
    required this.username,
    required this.password,
    required this.fullname,
    required this.wallet,
    required this.email,
    required this.type,
    required this.img,
  });

  factory UseruidGetRes.fromJson(Map<String, dynamic> json) => UseruidGetRes(
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
