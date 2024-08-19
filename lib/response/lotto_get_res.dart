// To parse this JSON data, do
//
//     final lottoGetRes = lottoGetResFromJson(jsonString);

import 'dart:convert';

List<LottoGetRes> lottoGetResFromJson(String str) => List<LottoGetRes>.from(
    json.decode(str).map((x) => LottoGetRes.fromJson(x)));

String lottoGetResToJson(List<LottoGetRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LottoGetRes {
  int lid;
  int price;
  String number;
  String prize;
  dynamic uid;
  int accepted;

  LottoGetRes({
    required this.lid,
    required this.price,
    required this.number,
    required this.prize,
    required this.uid,
    required this.accepted,
  });

  factory LottoGetRes.fromJson(Map<String, dynamic> json) => LottoGetRes(
        lid: json["lid"],
        price: json["price"],
        number: json["number"],
        prize: json["prize"],
        uid: json["uid"],
        accepted: json["accepted"],
      );

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "price": price,
        "number": number,
        "prize": prize,
        "uid": uid,
        "accepted": accepted,
      };
}
