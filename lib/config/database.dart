import 'package:flutter_app/Models/Event/afterModel.dart';
import 'package:flutter_app/Models/Event/classesModel.dart';
import 'package:flutter_app/Models/Event/competitionModel.dart';
import 'package:flutter_app/Models/Users/participantModel.dart';
import 'package:flutter_app/Models/Users/riderModel.dart';
import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:flutter_app/Models/horseModel.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_app/Models/Event/eventModel.dart';
import 'package:flutter_app/constants.dart';

class MongoDatabase {
  static var db;
  static connect() async {
    db = await Db.create(mongoUrl);
    await db.open();
  }

  //Verifie si l'email et le mot passe correspondent à un User dans la BDD
  static Future<Object?> getUserLogin(email, password) async {
    var result;
    try {
      //Recherche dans la BDD un User qui possede l'email et le mot de passe
      //exact qui à été envoyé dans le formulaire
      result = await db.collection(userCollection).findOne(
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
      var result = await db.collection(userCollection).insertOne(user);
      print('Mon r : $result');
      return result;
    } catch (e) {
      print('Mon e: $e');
      e.toString();
    }
  }

  static Future<Object?> insertCourse(Object course) async {
    try {
      var result = await db.collection(eventCollection).insertOne(course);
      return result;
    } catch (e) {
      e.toString();
    }
    return null;
  }

  static Future<Object?> insertHorse(Object horse) async {
    try {
      var result = await db.collection(horseCollection).insertOne(horse);
      print('Mon r : $result');
      return result;
    } catch (e) {
      print('Mon e: $e');
      e.toString();
    }
  }

  static Future<List<Horse>> getLastHorse() async {
    try {
      final horses = await db.collection(horseCollection).find().toList();
      List<Horse> lastHorses = [];
      horses.forEach((item) => lastHorses.add(Horse(id: item['_id'], name: item['_id'], age: item['age'], robe: item['robe'], race: item['race'], sex: item['sex'], speciality: item['speciality'], imagePath: item['imagePath'])));
      return lastHorses;
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }

  static Future<List<Event>> getLastEvents() async {
    try {
      final events = await db.collection(eventCollection).find().toList();
      List<Event> lastEvents = [];
      events.forEach((item) => lastEvents.add(Event(item['_id'], item['name'], item['date'], item['description'], item['address'], item['eventType'])));
      lastEvents.sort((a, b) => b.date.compareTo(a.date));
      return lastEvents;
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }

  static Future<List<User>> getLastUsers() async {
    try {
      final users = await db.collection(userCollection).find().toList();
      List<User> lastUsers = [];
      users.forEach((item) => lastUsers.add(User(item['_id'], item['username'], item['name'], item['lastName'], item['email'], item['password'], item['phone'], item['age'], item['createdAt'])));
      lastUsers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return lastUsers;
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }

  static Future<List<Competition>> getLastCompetitions() async {
    try {
      final competitions = await db.collection(eventCollection).find(where.eq('eventType', 'competition')).toList();
      List<Competition> lastCompetitions = [];
      competitions.forEach((item) {
        lastCompetitions.add(Competition(item['_id'], item['name'], item['date'], item['description'], item['address'], item['eventType'], item['imagePath'], item['riders']));
      });
      lastCompetitions.sort((a, b) => b.date.compareTo(a.date));
      return lastCompetitions;
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }

  static Future<List<Classes>> getLastClasses() async {
    try {
      final classes = await db.collection(eventCollection).find(where.eq('eventType', 'classes')).toList();
      List<Classes> lastClasses = [];
      classes.forEach((item) {
        lastClasses.add(Classes(item['_id'], item['name'], item['date'], item['description'], item['address'], item['eventType'], item['rider'], item['level']));
      });
      lastClasses.sort((a, b) => b.date.compareTo(a.date));
      return lastClasses;
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }

  static Future<List<After>> getLastAfters() async {
    try {
      final afters = await db.collection(eventCollection).find(where.eq('eventType', 'after')).toList();
      List<After> lastAfters = [];
      afters.forEach((item) {
        lastAfters.add(After(item['_id'], item['name'], item['date'], item['description'], item['address'], item['eventType'], item['type'], item['imagePath'], item['fetars']));
      });
      lastAfters.sort((a, b) => b.date.compareTo(a.date));
      return lastAfters;
    } catch (e) {
      print(e);
      return Future.value([]);
    }
  }

  static Future<Object?> changePassword(pseudo, email, newPassword) async {
    try {
      //Recherche dans la BDD un User qui possede le pseudo et l'email
      //exact qui à été envoyé dans le formulaire
      var result = await db.collection(userCollection)
          .findOne(where.eq('username', pseudo).and(where.eq('email', email)));
      //Si le resultat n'est pas vide retourne vrai
      if (result.length > 0) {
        //Si le nouveau mot de passe est différent de l'ancien ...
        if (newPassword != result["password"]) {
          //... Modifie le mot de passe de l'adresse mail donné
          var change = await db.collection(userCollection).update(
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