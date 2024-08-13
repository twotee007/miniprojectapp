// To parse this JSON data, do
//
//     final registerPostReq = registerPostReqFromJson(jsonString);

import 'dart:convert';

RegisterPostReq registerPostReqFromJson(String str) =>
    RegisterPostReq.fromJson(json.decode(str));

String registerPostReqToJson(RegisterPostReq data) =>
    json.encode(data.toJson());

class RegisterPostReq {
  String username;
  String password;
  String fullname;
  int wallet;
  String email;
  String img;

  RegisterPostReq({
    required this.username,
    required this.password,
    required this.fullname,
    required this.wallet,
    required this.email,
    required this.img,
  });

  factory RegisterPostReq.fromJson(Map<String, dynamic> json) =>
      RegisterPostReq(
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        wallet: json["wallet"],
        email: json["email"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "fullname": fullname,
        "wallet": wallet,
        "email": email,
        "img": img,
      };
}
