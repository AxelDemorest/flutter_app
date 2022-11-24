import 'package:flutter_app/Models/Users/userModel.dart';

import '../horseModel.dart';

class Rider extends User{
  String linkFFE;
  bool isDp;
  bool isOwner;
  List<Horse> listOwnerHorse;
  List<Horse> listDPHorse;

  Rider(
      super.id,
      super.name,
      super.email,
      super.lastName,
      super.phone,
      super.age,
      super.username,
      this.linkFFE,
      this.isOwner,
      this.isDp,
      this.listOwnerHorse,
      this.listDPHorse
      );

}