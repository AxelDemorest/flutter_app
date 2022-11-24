import 'package:flutter_app/Models/Event/eventModel.dart';

class Competition extends Event{
  final String imagePath;
  List<dynamic> riders;

  Competition(super.id, super.name, super.date, super.description, super.address, super.eventType, this.imagePath, this.riders);
}