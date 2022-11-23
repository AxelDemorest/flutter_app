import 'package:flutter_app/Models/Users/userModel.dart';

import '../horseModel.dart';

class Rider extends User{
  String linkFFE;
  List<Horse> listRiderHorse;

  Rider(super.id, super.name, super.email, super.lastName, super.phone, super.age, this.linkFFE, this.listRiderHorse);

}