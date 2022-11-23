import 'package:mongo_dart/mongo_dart.dart';

import '../Users/riderModel.dart';
import '../Event/eventModel.dart';

class Classes extends Event{
  final Rider rider;

  Classes(super.id, super.name, super.date, super.description, super.address, this.rider);

}