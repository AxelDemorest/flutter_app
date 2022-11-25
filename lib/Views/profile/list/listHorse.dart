import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Models/horseModel.dart';

class ListHorse extends StatefulWidget {
  const ListHorse({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListHorse> createState() => _ListHorseState();
}

//Carte afficher pour les cheveaux dont est Demi-pensionnaire
/*
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
*/

class _ListHorseState extends State<ListHorse> {

  late List<List<Horse>> listHorse;

  @override
  Widget build(BuildContext context) {
    List<Card> ownerList = [];
    listHorse =  ModalRoute.of(context)!.settings.arguments as List<List<Horse>>;

    setState(() {
      for (Horse horse in listHorse[0]){
        ownerList.add(
            Card(
              color: Colors.orangeAccent,
              child: Padding(padding: EdgeInsets.only(left: 30.00, right: 30.00),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.add),
                      Text(horse.name),
                      Text(horse.age.toString()),
                      IconButton(
                          onPressed: (){ Navigator.of(context).pushNamed( 'profilehorse', arguments: horse);}, icon: Icon(Icons.edit)
                      )
                    ],
                  )
              ),
            )
        );
      }
      for (Horse horse in listHorse[1]){
        ownerList.add(
            Card(
              color: Colors.orangeAccent,
              child: Padding(padding: EdgeInsets.only(left: 30.00, right: 30.00),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.add),
                      Text(horse.name),
                      Text(horse.age.toString()),
                      IconButton(
                          onPressed: (){ Navigator.of(context).pushNamed( 'profilehorse', arguments: horse);}, icon: Icon(Icons.book)
                      )
                    ],
                  )
              ),
            )
        );
      }

    });
    print(ownerList);
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste de mes cheveaux"),

      ),
      body: ListView.builder(
              itemCount: ownerList.length,
              itemBuilder: (_, index)
                => ownerList[index]
              )
    );
  }
}

