import 'package:flutter_app/Models/Event/eventModel.dart';
import 'package:flutter_app/Models/Users/fetarModel.dart';

class After extends Event{
  String type;
  String imagePath;
  Fetar fetar;

  After(super.id, super.name, super.date, super.description, super.address, this.type, this.imagePath, this.fetar);
}