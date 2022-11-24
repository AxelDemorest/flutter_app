import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../horseModel.dart';

class Rider extends User {
  String linkFFE;
  bool isDp;
  bool isOwner;
  List<Horse> listOwnerHorse;
  List<Horse> listDPHorse;

  Rider(
      ObjectId id,
      String username,
      String name,
      String lastName,
      String password,
      String email,
      String phone,
      int age,
      DateTime createdAt,
      this.linkFFE,
      this.isOwner,
      this.isDp,
      this.listOwnerHorse,
      this.listDPHorse)
      : super(id, username, name, lastName, password, email, phone, age, createdAt);
}
