import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/horseModel.dart';

class ListHorse extends StatefulWidget {
  const ListHorse({Key? key}) : super(key: key);



  @override
  State<ListHorse> createState() => _ListHorseState();
}

//Carte afficher pour les cheveaux dont est propriétaire
class OwnerHorseCard extends StatelessWidget{
  Horse horse;
  OwnerHorseCard(this.horse,{super.key});

  void _openHorse(){

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orangeAccent,
      child: Padding(padding: EdgeInsets.only(left: 30.00, right: 30.00),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(Icons.add),
          Text(horse.name),
          Text(horse.age.toString()),
          IconButton(onPressed: _openHorse, icon: Icon(Icons.edit))
        ],
      )),
    );
  }
}

//Carte afficher pour les cheveaux dont est Demi-pensionnaire
class DPHorseCard extends StatelessWidget{
  Horse horse;
  DPHorseCard(this.horse,{super.key});

  void _openHorse(){

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Padding(padding: EdgeInsets.only(left: 30.00, right: 30.00),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(Icons.add),
              Text(horse.name),
              Text(horse.age.toString()),
              IconButton(onPressed: _openHorse, icon: Icon(Icons.book))
            ],
          )),
    );
  }
}

class _ListHorseState extends State<ListHorse> {

  late List<List<Horse>> listHorse = [];

  @override
  Widget build(BuildContext context) {
    listHorse =  ModalRoute.of(context)!.settings.arguments as List<List<Horse>>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste de mes cheveaux"),

      ),
      body: Container(
        child: Column(
          children: [
            ListView.builder(
              itemCount: listHorse[0].length,
              itemBuilder: (BuildContext context, int index){
                return OwnerHorseCard(listHorse[0][index]);
              }
          ),
            ListView.builder(
                itemCount: listHorse[1].length,
                itemBuilder: (BuildContext context, int index){
                  return DPHorseCard(listHorse[1][index]);
                }
            ),
          ],
        )
      ),
    );
  }
}

