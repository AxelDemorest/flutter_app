import 'package:flutter_app/Models/Event/eventModel.dart';
import 'package:flutter_app/Models/Users/participantModel.dart';


class Competition extends Event{
  final String imagePath;
  List<Participant> riders;

  Competition(super.id, super.name, super.date, super.description, super.address, this.imagePath, this.riders);


}