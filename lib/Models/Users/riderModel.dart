import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Rider extends User{
  String linkFFE;
  List<Horse> listRiderHorse;

  Rider(this.linkFFE, this.listRiderHorse): super(new ObjectId(),"","","","",0, false);
}