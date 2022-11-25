import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../Models/horseModel.dart';

class ProfileHorse extends StatefulWidget {
  const ProfileHorse({super.key, required this.title});

  final String title;

  @override
  State<ProfileHorse> createState() => _ProfileHorseState();
}

class _ProfileHorseState extends State<ProfileHorse> {

  File? _image;
  static const List<String> listSpe = <String>['Dressage', 'Saut d\'obstacle', 'Endurance', 'Complet'];
  static const List<String> listSex = <String>['Male', 'Female'];
  String dropdownValueSpe = listSpe.first;
  String dropdownValueSex = listSex.first;
  var name = TextEditingController();
  var age = TextEditingController();
  var robe = TextEditingController();
  var race = TextEditingController();
  var sex = TextEditingController();
  var imageLink = TextEditingController();

  late Horse horse;

  @override
  Widget build(BuildContext context) {
    horse =  ModalRoute.of(context)!.settings.arguments as Horse;

    setState(
      () {
        name.text = horse.name;
        age.text = '${horse.age}';
        robe.text = horse.robe;
        race.text = horse.race;
        imageLink.text = horse.image;
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
                            child: _image != null ? Image.file(_image!, width: 200, fit: BoxFit.contain,) :
                            const Image(
                              image: AssetImage('assets/imgHorse/cheval1.jpeg'),
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
                                          color: Colors.orange
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
                                          color: Colors.orange
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
                                          color: Colors.orange
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
                                          color: Colors.orange
                                      )
                                  ),
                                  hintText: 'La race',
                                )
                            ),
                            DropdownButton<String>(
                              value: dropdownValueSex,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              underline: Container(
                                color: Colors.orange,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValueSex = value!;
                                });
                              },
                              items: listSex.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            DropdownButton<String>(
                              value: dropdownValueSpe,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              underline: Container(
                                color: Colors.orange,
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValueSpe = value!;
                                });
                              },
                              items: listSpe.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: imageLink,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Entrez une image',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez écrire une image correct';
                                    } else {
                                      return null;
                                    }
                                  },
                                )
                            ),
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
