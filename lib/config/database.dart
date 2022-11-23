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

  //Verifie si l'email et le mot passe correspondent à un User dans la BDD
  static Future<Object> getUserLogin(email, password) async {
    try {
      //Recherche dans la BDD un User qui possede l'email et le mot de passe
      //exact qui à été envoyé dans le formulaire
      var result = await userCollection
          .find(where.eq('email', email).and(where.eq('password', password)))
          .toList();
      //Si le resultat n'est pas vide retourne vrai
      if (result.length > 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
