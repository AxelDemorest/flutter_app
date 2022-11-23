import 'package:mongo_dart/mongo_dart.dart';

abstract class Event{
  final ObjectId id;
  final String name;
  final String date;
  final String description;
  final String address;

  Event(this.id, this.name, this.date, this.description, this.address);
}