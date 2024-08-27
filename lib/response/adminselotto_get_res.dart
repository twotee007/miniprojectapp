// To parse this JSON data, do
//
//     final adminGetLottoRes = adminGetLottoResFromJson(jsonString);

import 'dart:convert';

AdminGetLottoRes adminGetLottoResFromJson(String str) =>
    AdminGetLottoRes.fromJson(json.decode(str));

String adminGetLottoResToJson(AdminGetLottoRes data) =>
    json.encode(data.toJson());

class AdminGetLottoRes {
  int lenuser;
  int lenall;

  AdminGetLottoRes({
    required this.lenuser,
    required this.lenall,
  });

  factory AdminGetLottoRes.fromJson(Map<String, dynamic> json) =>
      AdminGetLottoRes(
        lenuser: json["lenuser"],
        lenall: json["lenall"],
      );

  Map<String, dynamic> toJson() => {
        "lenuser": lenuser,
        "lenall": lenall,
      };
}
