import 'package:mongo_dart/mongo_dart.dart';

abstract class User {
  final ObjectId id;
  String name;
  String lastName;
  String email;
  String phone;
  int age;
  String username;

  User(this.id, this.name, this.email, this.lastName, this.phone, this.age, this.username);
}
