import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Event/classesModel.dart';
import 'package:flutter_app/Models/Users/riderModel.dart';
import 'package:flutter_app/Models/horseModel.dart';
import 'package:flutter_app/config/database.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddCourse> createState() => _AddCourseState();
}

enum TrainingGround { manege, carriere }

enum DuringTime { thirtyMinutes, oneHour }

enum Discipline { dressage, sautObstacle, endurance }

class _AddCourseState extends State<AddCourse> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  TrainingGround? trainingGround;
  DuringTime? duringTime;
  Discipline? discipline;

  @override
  void initState() {
    dateInput.text = "";
    timeInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const Text(
                          "Programmer un cours",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const Text(
                          "Terrain d'entraînement",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: ListTile(
                              title: const Text('Manège'),
                              leading: Radio<TrainingGround>(
                                value: TrainingGround.manege,
                                groupValue: trainingGround,
                                onChanged: (TrainingGround? value) {
                                  setState(() {
                                    trainingGround = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                              title: const Text('Carrière'),
                              leading: Radio<TrainingGround>(
                                value: TrainingGround.carriere,
                                groupValue: trainingGround,
                                onChanged: (TrainingGround? value) {
                                  setState(() {
                                    trainingGround = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: 60,
                          margin: const EdgeInsets.only(top: 20.0),
                          child: TextField(
                            controller: dateInput,
                            //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(),
                                labelText:
                                "Entrez une date" //label text of field
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          )),
                      Container(
                          height: 60,
                          margin: const EdgeInsets.only(top: 20.0),
                          child: TextField(
                            controller: timeInput,
                            //editing controller of this TextField
                            decoration: const InputDecoration(
                                icon: Icon(Icons.access_time_outlined),
                                border: OutlineInputBorder(),
                                labelText:
                                "Entrez une heure" //label text of field
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );

                              if (pickedTime != null) {
                                print(pickedTime
                                    .format(context)); //output 10:51 PM
                                DateTime parsedTime = DateFormat.jm().parse(
                                    pickedTime.format(context).toString());
                                //converting to DateTime so that we can further format on different pattern.
                                print(
                                    parsedTime); //output 1970-01-01 22:53:00.000
                                String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                                print(formattedTime); //output 14:59:00
                                //DateFormat() is from intl package, you can format the time on any pattern you need.

                                setState(() {
                                  timeInput.text =
                                      formattedTime; //set the value of text field.
                                });
                              } else {
                                print("Time is not selected");
                              }
                            },
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const Text(
                          "Durée",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: ListTile(
                              title: const Text('30 minutes'),
                              leading: Radio<DuringTime>(
                                value: DuringTime.thirtyMinutes,
                                groupValue: duringTime,
                                onChanged: (DuringTime? value) {
                                  setState(() {
                                    duringTime = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: ListTile(
                              title: const Text('1 heure'),
                              leading: Radio<DuringTime>(
                                value: DuringTime.oneHour,
                                groupValue: duringTime,
                                onChanged: (DuringTime? value) {
                                  setState(() {
                                    duringTime = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 20),
                        child: const Text(
                          "Discipline",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 17),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: ListTile(
                              title: const Text('Dressage'),
                              leading: Radio<Discipline>(
                                value: Discipline.sautObstacle,
                                groupValue: discipline,
                                onChanged: (Discipline? value) {
                                  setState(() {
                                    discipline = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: ListTile(
                              title: const Text("Saut d'obstacle"),
                              leading: Radio<Discipline>(
                                value: Discipline.endurance,
                                groupValue: discipline,
                                onChanged: (Discipline? value) {
                                  setState(() {
                                    discipline = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: const Text('Endurance'),
                        leading: Radio<Discipline>(
                          value: Discipline.dressage,
                          groupValue: discipline,
                          onChanged: (Discipline? value) {
                            setState(() {
                              discipline = value;
                            });
                          },
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
                                    borderRadius: BorderRadius.circular(11.0),
                                  )),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.orangeAccent),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green[300],
                                  content: Row(
                                    children: const [
                                      Icon(Icons.check),
                                      Text('Programmation réussie')
                                    ],
                                  ),
                                ));

                                Rider rider = Rider(
                                    M.ObjectId(),
                                    'axel',
                                    'axel',
                                    'demorest',
                                    'mail',
                                    'password',
                                    '0892512875',
                                    20,
                                    DateTime.now(),
                                    "linkFFE",
                                    true,
                                    false,
                                    [
                                      Horse(
                                          M.ObjectId(),
                                          "Caramele",
                                          15,
                                          "Blanc",
                                          "Poney",
                                          "Male",
                                          "Complet",
                                          ""),
                                      Horse(
                                          M.ObjectId(),
                                          "Zoro",
                                          17,
                                          "Noir et Blanc",
                                          "Cheval",
                                          "Male",
                                          "Dressage",
                                          "")
                                    ],
                                    [
                                      Horse(
                                          M.ObjectId(),
                                          "Vanille",
                                          12,
                                          "Bronze",
                                          "Cheval",
                                          "Femelle",
                                          "Complet",
                                          "")
                                    ]
                                );

                                Classes course = Classes(
                                  M.ObjectId(),
                                  dateInput.text,
                                  DateTime.now(),
                                  'Description d\'un cours',
                                  'une adresse',
                                  'classes',
                                  rider,
                                  'trop fort'
                                );

                                var courseJson = {
                                  '_id': course.id,
                                  'name': course.name,
                                  'date': course.date,
                                  'description': course.description,
                                  'address': course.address,
                                  'eventType': course.eventType,
                                  'rider': course.rider,
                                  'level': course.level
                                };

                                await MongoDatabase.insertCourse(courseJson);
                              }
                            },
                            child: const Text(
                              'Ajouter',
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                    ],
                  ),
                ))));
  }
}
