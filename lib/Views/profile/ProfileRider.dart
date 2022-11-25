import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/horseModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../Models/Users/riderModel.dart';

class ProfileRiderPage extends StatefulWidget {
  const ProfileRiderPage({Key? key, required this.title} ) : super(key: key);
  final String title;

  @override
  State<ProfileRiderPage> createState() => _ProfileRiderPageState();
}

class _ProfileRiderPageState extends State<ProfileRiderPage> {

  //Création des variable et des controller
  late Rider rider;
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final linkController = TextEditingController();

  // effectue la modification en base de donnée
  void doModify() {
    setState(() {
      if (passwordController.value.text ==
          confirmPasswordController.value.text) {
        print(" ok");
      }
    });
    Navigator.of(context).pop();
  }

  //Ouvre la page list des cheveaux de l'utilisateur
  @override
  Widget build(BuildContext context) {
    //rider = ModalRoute.of(context)!.settings.arguments as Rider;
    rider = Rider(
        mongo.ObjectId(),
        "username",
        "Paul",
        "lastName",
        "email@gmail.com",
        "EEA3E2pa",
        "0695040570",
        20,
        DateTime.now(),
        "linkFFE",
        true,
        false, [
      Horse(mongo.ObjectId(), "Caramele", 15, "Blanc", "Poney", "0",
          "3", ""),
      Horse(mongo.ObjectId(), "Zoro", 17, "Noir et Blanc", "Cheval", "0",
          "0", "")
    ], [
      Horse(mongo.ObjectId(), "Vanille", 12, "Bronze", "Cheval", "1",
          "3", "")
    ]);
    List<List<Horse>> listHorse = [rider.listOwnerHorse, rider.listDPHorse];
    return Scaffold(
        appBar: AppBar(
          title: Text("Bienvenue ${rider.username} sur votre profil"),
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 30.00, right: 30.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Nom : ${rider.name}"),
                    Text("Prénom : ${rider.lastName}")
                  ],
                ),
                Text("Pseudo : ${rider.username}"),
                Text("Age : ${rider.age}"),
                Text("Email : ${rider.email}"),
                Text("Lien FFE :  ${rider.linkFFE}"),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('listHorse', arguments: listHorse);
                    },
                    child: const Text("Mes Cheveaux")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        onPressed: _openModifyDialog,
                        child: const Text("Modifié le Profil"))
                  ],
                )
              ],
            )
        )
    );
  }
  //Ouvre la dialog avec le formulair de modification de compte ( pseudo, mot de passe, et lien FFE)
  void _openModifyDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Modification du profil"),
              actions: <Widget>[
                TextField(
                  controller: pseudoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
                TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mot de passe',
                    )),
                TextField(
                    controller: confirmPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirmation mot de passe',
                    )),
                TextField(
                    controller: linkController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'lien FFE',
                    )),
                TextButton(onPressed: doModify, child: Text("Modifié"))
              ],
            );
          });
        });
  }
}
