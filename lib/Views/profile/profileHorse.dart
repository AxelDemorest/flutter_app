import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../Models/horseModel.dart';

class ProfileHorse extends StatefulWidget {
  const ProfileHorse({super.key, required this.title});

  final String title;

  @override
  State<ProfileHorse> createState() => _ProfileHorseState();
}

class _ProfileHorseState extends State<ProfileHorse> {

  static const List<String> listSpe = <String>['Dressage', 'Saut d\'obstacle', 'Endurance', 'Complet'];
  String dropdownValue = listSpe.first;
  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    var age = TextEditingController();
    var robe = TextEditingController();
    var race = TextEditingController();
    var sex = TextEditingController();

    Horse horse = Horse(mongo.ObjectId(), 'Le nom du cheval 111', 12, 'robe',
        'race', 'sex', '1', 'assets/imgHorse/cheval1.jpeg');
    setState(
      () {
        name.text = horse.name;
        age.text = '${horse.age}';
        robe.text = horse.robe;
        race.text = horse.race;
        sex.text = horse.sex;
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 8,
                  color: Colors.white70,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image(
                              image: AssetImage(horse.image),
                              width: 200,
                              fit: BoxFit.contain,
                            ),
                          )),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            TextFormField(
                                controller: name,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue
                                      )
                                  ),
                                  hintText: 'La taille',

                                )
                            ),
                            TextFormField(
                                controller: age,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue
                                      )
                                  ),
                                  hintText: 'Son age',
                                )
                            ),
                            TextFormField(
                                controller: robe,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue
                                      )
                                  ),
                                  hintText: 'Sa robe',
                                )
                            ),
                            TextFormField(
                                controller: race,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue
                                      )
                                  ),
                                  hintText: 'La race',
                                )
                            ),
                            TextFormField(
                                controller: sex,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue
                                      )
                                  ),
                                  hintText: 'Le sexe',
                                )
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              underline: Container(
                                color: Colors.blue,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              items: listSpe.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ]),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: const Text('Editer mon cheval'),
                            onPressed: () {
                              final snackBar = SnackBar(
                                content: const Text('Cheval modifié'),
                                action: SnackBarAction(
                                  label: 'Fermer',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ))
    );
  }
}
