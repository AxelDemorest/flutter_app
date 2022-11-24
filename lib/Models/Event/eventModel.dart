import 'package:mongo_dart/mongo_dart.dart';

class Event{
  final ObjectId id;
  final String name;
  final DateTime date;
  final String description;
  final String address;
  final String eventType;

  const Event(this.id, this.name, this.date, this.description, this.address, this.eventType);

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'date': date,
      'description': description,
      'address': address,
      'eventType': eventType,
    };
  }

  Event.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        name = map['name'],
        date = map['date'],
        description = map['description'],
        address = map['address'],
        eventType = map['eventType'];
}