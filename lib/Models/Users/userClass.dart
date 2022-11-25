// To parse this JSON data, do
//final rider = riderFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Rider riderFromJson(String str) => Rider.fromJson(json.decode(str));

String riderToJson(Rider data) => json.encode(data.toJson());

class Rider {
  Rider({
    required this.id,
    required this.username,
    required this.name,
    required this.lastname,
    required this.email,
    required this.password,
    required this.phone,
    required this.age,
    required this.createdAt,
    required this.linkFee,
    required this.isDp,
    required this.isOwner,
    required this.admin,
    required this.listOwnerHorse,
    required this.listDpHorse,
  });

  ObjectId id;
  String username;
  String name;
  String lastname;
  String email;
  String password;
  int phone;
  int age;
  DateTime createdAt;
  String linkFee;
  bool isDp;
  bool isOwner;
  bool admin;
  List<dynamic> listOwnerHorse;
  List<dynamic> listDpHorse;

  factory Rider.fromJson(Map<String, dynamic> json) => Rider(
    id: json["_id"],
    username: json["username"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    age: json["age"],
    createdAt: DateTime.parse(json["createdAt"]),
    linkFee: json["linkFEE"],
    isDp: json["isDp"],
    isOwner: json["isOwner"],
    admin: json["admin"],
    listOwnerHorse: List<dynamic>.from(json["listOwnerHorse"].map((x) => x)),
    listDpHorse: List<dynamic>.from(json["listDpHorse"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "name": name,
    "lastname": lastname,
    "email": email,
    "password": password,
    "phone": phone,
    "age": age,
    "createdAt": createdAt.toIso8601String(),
    "linkFEE": linkFee,
    "isDp": isDp,
    "isOwner": isOwner,
    "admin": admin,
    "listOwnerHorse": List<dynamic>.from(listOwnerHorse.map((x) => x)),
    "listDpHorse": List<dynamic>.from(listDpHorse.map((x) => x)),
  };
}
