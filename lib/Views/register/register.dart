import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:flutter_app/config/database.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Register extends StatefulWidget {
  const Register({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isOwner = false;
  bool isHalfBoarder = false;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SizedBox(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "Créer un compte",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                            Form(
                              key: formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(top: 30),
                                      child: TextFormField(
                                        controller: lastNameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Entrez votre nom',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez écrire un nom correct';
                                          }
                                        },
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        controller: firstNameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Entrez votre prénom',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez écrire un prénom correct';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        controller: ageController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Entrez votre âge',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Veuillez écrire un âge correct';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        controller: mailController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Entrez votre mail',
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(value)) {
                                            return 'Veuillez écrire un mail correct';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: TextFormField(
                                        controller: phoneController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText:
                                              'Entrez votre numéro de téléphone',
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.isEmpty ||
                                              !RegExp(r"^\+?0[0-9]{9}$")
                                                  .hasMatch(value)) {
                                            return 'Veuillez écrire un numéro de téléphone correct';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex: 6,
                                            child: CheckboxListTile(
                                              title: const Text('Propriétaire'),
                                              value: isOwner,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  isOwner = value!;
                                                });
                                              },
                                            )),
                                        Expanded(
                                          flex: 4,
                                          child: CheckboxListTile(
                                            title: const Text('DP'),
                                            value: isHalfBoarder,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isHalfBoarder = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      width: 250,
                                      height: 50,
                                      child: TextButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11.0),
                                          )),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orangeAccent),
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (!isHalfBoarder && !isOwner) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.red[300],
                                                content: Row(
                                                  children: const [
                                                    Icon(Icons.error),
                                                    Text(
                                                        'Veuillez cocher une des deux cases')
                                                  ],
                                                ),
                                              ));
                                            } else {
                                              User user = User(
                                                  M.ObjectId(),
                                                  firstNameController.text,
                                                  mailController.text,
                                                  lastNameController.text,
                                                  phoneController.text,
                                                  int.parse(
                                                      ageController.text));
                                              var userJson = {
                                                '_id': user.id,
                                                'name': user.name,
                                                'lastName': user.lastName,
                                                'email': user.email,
                                                'phone': user.phone,
                                                'age': user.age
                                              };
                                              await MongoDatabase.insertUser(userJson);
                                            }
                                          }
                                        },
                                        child: const Text(
                                          'S\'inscrire',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          ]),
                    )))));
  }
}
