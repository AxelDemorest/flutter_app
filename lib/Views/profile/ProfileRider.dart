import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Users/riderModel.dart';
import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:flutter_app/Models/horseModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ProfileRiderPage extends StatefulWidget {
  ProfileRiderPage({Key? key, required this.title, required this.userParam} ) : super(key: key);
  final String title;
  User ?userParam;

  @override
  State<ProfileRiderPage> createState() => _ProfileRiderPageState();
}

class _ProfileRiderPageState extends State<ProfileRiderPage> {

  //Création des variable et des controller
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final linkController = TextEditingController();

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
    User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Container(
            padding: const EdgeInsets.only(left: 30.00, right: 30.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Nom : ${user.name}"),
                    Text("Prénom : ${user.lastName}")
                  ],
                ),
                Text("Pseudo : ${user.username}"),
                Text("Age : ${user.age}"),
                Text("Email : ${user.email}"),
                Text("Lien FFE : FFE"),
                TextButton(
                    onPressed: () {
                      /*Navigator.of(context)
                          .pushNamed('listHorse', arguments: listHorse);*/
                    },
                    child: const Text("Mes chevaux")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: _openModifyDialog,
                        child: const Text("Modifié le Profil"))
                  ],
                )
              ],
            )));
  }
}
