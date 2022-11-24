import 'package:flutter_app/Models/Event/eventModel.dart';

class After extends Event{
  final String type;
  final String imagePath;
  List<dynamic> fetars;

  After(super.id, super.name, super.date, super.description, super.address, super.eventType, this.type, this.imagePath, this.fetars);
}