import 'package:flutter_app/Models/Users/participantModel.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Competition {
  final ObjectId id;
  final String name;
  final String address;
  final String image;
  final String date;
  List<Participant> riders;

  Competition(this.id, this.name, this.address, this.image, this.date, this.riders);
}