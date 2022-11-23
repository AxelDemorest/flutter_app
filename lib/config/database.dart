import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_app/constants.dart';

class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    userCollection = db.collection(collectionName);
  }

  static Future<Object> getUserByEmail(email, password) async {
    try {
      var result = await userCollection.find(where.eq('email', email).and(where.eq('password', password))).toList();
      if(result.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
