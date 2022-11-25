import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String username;
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final int age;
  final DateTime createdAt;

  User(this.id, this.username, this.name, this.lastName, this.email,
      this.password, this.phone, this.age, this.createdAt);

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["_id"],
        json["username"],
        json["username"],
        json["lastName"],
        json["email"],
        json["password"],
        json["phone"],
        json["age"],
        json["createdAt"],
      );
}
