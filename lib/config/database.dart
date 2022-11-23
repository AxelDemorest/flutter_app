import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:flutter_app/constants.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
    userCollection = db.collection(collectionName);
  }

  static Future<Object?> insertUser(Object user) async {
    try {
      var result = await userCollection.insertOne(user);
      return result;
    } catch(e) {
      e.toString();
    }
    return null;
  }

}