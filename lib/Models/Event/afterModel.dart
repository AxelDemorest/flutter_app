import 'package:flutter_app/Models/Event/eventModel.dart';
import 'package:flutter_app/Models/Users/fetarModel.dart';

class After extends Event{
  final String type;
  final String imagePath;
  List<Fetar> fetars;

  After(super.id, super.name, super.date, super.description, super.address, this.type, this.imagePath, this.fetars);
}