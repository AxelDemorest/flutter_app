import 'package:flutter_app/Models/Event/eventModel.dart';
import 'package:flutter_app/Models/Users/participantModel.dart';


class Competition extends Event{
  final String image;
  List<Participant> riders;

  Competition(super.id, super.name, super.date, super.description, super.address, this.image, this.riders);


}