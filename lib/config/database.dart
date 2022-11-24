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

  //Verifie si l'email et le mot passe correspondent à un User dans la BDD
  static Future<Object?> getUserLogin(email, password) async {
    var result;
    try {
      //Recherche dans la BDD un User qui possede l'email et le mot de passe
      //exact qui à été envoyé dans le formulaire
      result = await userCollection.findOne(
          where.eq('email', email).and(where.eq('password', password)));
      //Si le resultat n'est pas vide retourne vrai
      if (result.length > 0) {
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<Object?> insertUser(Object user) async {
    try {
      var result = await userCollection.insertOne(user);
      return result;
    } catch (e) {
      e.toString();
    }
    return null;
  }

  static Future<Object?> changePassword(pseudo, email, newPassword) async {
    try {
      //Recherche dans la BDD un User qui possede le pseudo et l'email
      //exact qui à été envoyé dans le formulaire
      var result = await userCollection
          .findOne(where.eq('username', pseudo).and(where.eq('email', email)));
      //Si le resultat n'est pas vide retourne vrai
      if (result.length > 0) {
        //Si le nouveau mot de passe est différent de l'ancien ...
        if (newPassword != result["password"]) {
          //... Modifie le mot de passe de l'adresse mail donné
          var change = await userCollection.update(
              where.eq('email', email), modify.set('password', newPassword));
          return change;
        } else {
          return 'Mot de passe déja utilisé';
        }
      } else {
        return null;
      }
    } catch (e) {
      e.toString();
    }
    return null;
  }
}
