// To parse this JSON data, do
//
//     final creditCards = creditCardsFromJson(jsonString);

import 'dart:convert';

CreditCards creditCardsFromJson(String str) =>
    CreditCards.fromJson(json.decode(str));

String creditCardsToJson(CreditCards data) => json.encode(data.toJson());

class CreditCards {
  CreditCards({
    required this.status,
    required this.code,
    required this.total,
    required this.data,
  });

  final String status;
  final int code;
  final int total;
  final List<Datum> data;

  factory CreditCards.fromJson(Map<String, dynamic> json) => CreditCards(
        status: json["status"],
        code: json["code"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.type,
    required this.number,
    required this.expiration,
    required this.owner,
  });

  final String type;
  final String number;
  final String expiration;
  final String owner;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        number: json["number"],
        expiration: json["expiration"],
        owner: json["owner"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "number": number,
        "expiration": expiration,
        "owner": owner,
      };
}
