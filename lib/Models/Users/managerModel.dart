import 'package:flutter_app/Models/Users/userModel.dart';

class Manager extends User{
  bool isAdmin;

  Manager(super.id, super.name, super.email, super.password, super.lastName, super.phone, super.age, super.createdAt, super.username, this.isAdmin);
}