import '../Event/eventModel.dart';

class Classes extends Event{
  final Object rider;
  final String level;

  Classes(super.id, super.name, super.date, super.description, super.address, super.eventType, this.rider, this.level);

}