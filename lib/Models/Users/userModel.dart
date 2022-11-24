
import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId id;
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final int age;
  final DateTime createdAt;

  User(this.id, this.name, this.email, this.lastName, this.phone, this.age, this.createdAt);
}
