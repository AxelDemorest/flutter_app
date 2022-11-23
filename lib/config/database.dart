import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_app/constants.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(mongoUrl);
    await db.open();
    inspect(db);
  }
}