import 'package:flutter/material.dart';
import 'package:flutter_app/Views/home/NavBar.dart';
import 'package:flutter_app/Views/home/home.dart';
import 'package:flutter_app/Views/news/news.dart';
import 'package:flutter_app/Views/login/login.dart';
import 'package:flutter_app/Views/profile/ProfileRider.dart';
import 'package:flutter_app/Views/profile/list/listHorse.dart';
import 'package:flutter_app/Views/profile/profileHorse.dart';
import 'package:flutter_app/Views/register/register.dart';
import 'package:flutter_app/config/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Views/addCourse/addCourse.dart';
import 'Views/profile/addHorse/addHorse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "home": (context) => const MyHomePage(title: 'HomePage'),
        "loginPage": (context) => const Login(title: 'Connexion'),
        "registerPage": (context) => const Register(title: 'Inscription'),
        "profilepage": (context) => const ProfileRiderPage(title: 'Profile'),
        "listHorse": (context) => const ListHorse(title: 'Liste des chevaux'),
        "profilehorse": (context) => const ProfileHorse(title: 'Profile du cheval'),
        "news": (context) => const NewsPage(title: 'Dernières actualités'),
        "Navigator" : (context) => const Home(),
        "AddCours" : (context) => const AddCourse(title: 'Ajouter un cours'),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const Login(title: 'Se connecter'),
    );
  }
}
