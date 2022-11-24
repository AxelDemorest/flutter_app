import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Users/riderModel.dart';
import 'package:flutter_app/Models/horseModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ProfileRiderPage extends StatefulWidget {
  const ProfileRiderPage({Key? key}) : super(key: key);

  @override
  State<ProfileRiderPage> createState() => _ProfileRiderPageState();
}

class _ProfileRiderPageState extends State<ProfileRiderPage> {

  late Rider rider;
  List<String> listHorse = ["Hello", "Sa va ?", "aurevoir"];
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final linkController = TextEditingController();

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

  void doModify() {
    setState(() {
      if (passwordController.value.text ==
          confirmPasswordController.value.text) {
        print(" ok");
      }
    });
    Navigator.of(context).pop();
  }

  _goToListHorse(){
      List<List<Horse>> data = [rider.listOwnerHorse, rider.listDPHorse];
      Navigator.pushNamed(context, '/listHorse', arguments: data).then(
              (_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    //rider = ModalRoute.of(context)!.settings.arguments as Rider;
    rider = new Rider(mongo.ObjectId(), "Paul", "email@gmail.com", "lastName", "0695040570", 20, "username", "linkFFE", true, false, [], []);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 30.00, right: 30.00),
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
            TextButton(onPressed: _goToListHorse, child: Text("Mes Cheveaux")),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: _openModifyDialog, child: Text("Modifié le Profil"))
              ],
            )

          ],
        )
      )
    );

  }
}
