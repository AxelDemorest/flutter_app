// To parse this JSON data, do
//
//     final horse = horseFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Horse horseFromJson(String str) => Horse.fromJson(json.decode(str));

String horseToJson(Horse data) => json.encode(data.toJson());

class Horse {
  Horse({
    required this.id,
    required this.name,
    required this.age,
    required this.robe,
    required this.race,
    required this.sex,
    required this.speciality,
    required this.imagePath,
  });

  ObjectId id;
  String name;
  int age;
  String robe;
  String race;
  String sex;
  String speciality;
  String imagePath;

  factory Horse.fromJson(Map<String, dynamic> json) => Horse(
    id: json["_id"],
    name: json["name"],
    age: json["age"],
    robe: json["robe"],
    race: json["race"],
    sex: json["sex"],
    speciality: json["speciality"],
    imagePath: json["imagePath"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "age": age,
    "robe": robe,
    "race": race,
    "sex": sex,
    "speciality": speciality,
    "imagePath": imagePath,
  };
}
