import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Event/eventModel.dart';
import 'package:flutter_app/config/database.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Card> card = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.event)),
                Tab(icon: Icon(Icons.account_circle)),
                Tab(icon: Icon(Icons.emoji_events)),
                Tab(icon: Icon(Icons.receipt_rounded)),
                Tab(icon: Icon(Icons.liquor)),
              ]),
              title: Text(widget.title),
            ),
            body: const TabBarView(children: [
              EventList(),
              UsersList(),
              CompetitionList(),
              ClassesList(),
              AftersList()
            ])));
  }
}

class EventList extends StatelessWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getLastEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Spacer(),
                                  ListTile(
                                    title: Text(snapshot.data![index].name,
                                        softWrap: true),
                                    subtitle: Text(
                                        "Type d'événement : ${snapshot.data![index].eventType}"),
                                    leading: const Icon(
                                      Icons.event,
                                      size: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 73),
                                    child:
                                        Text(snapshot.data![index].description),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 73, top: 20),
                                    child: Text(
                                        "adresse : ${snapshot.data![index].address}"),
                                  ),
                                  const Spacer(),
                                ],
                              )),
                        ));
                  });
            }
          }
        });
  }
}

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getLastUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Spacer(),
                                  ListTile(
                                    title: Text(
                                        "${snapshot.data![index].name} ${snapshot.data![index].lastName} (${snapshot.data![index].age} ans)"),
                                    subtitle: Text(snapshot.data![index].email),
                                    leading: const Icon(
                                      Icons.event,
                                      size: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 73),
                                    child: Text(
                                        "Téléphone : ${snapshot.data![index].phone}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 73, top: 20),
                                    child: Text(
                                        "adresse : ${snapshot.data![index].name}"),
                                  ),
                                  const Spacer(),
                                ],
                              )),
                        ));
                  });
            }
          }
        });
  }
}

class CompetitionList extends StatelessWidget {
  const CompetitionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getLastCompetitions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Spacer(),
                                  ListTile(
                                    title: Text(snapshot.data![index].name,
                                        softWrap: true),
                                    subtitle: Text(
                                        "Type d'événement : ${snapshot.data![index].eventType}"),
                                    leading: const Icon(
                                      Icons.event,
                                      size: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 73),
                                    child:
                                        Text(snapshot.data![index].description),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 73, top: 20),
                                    child: Text(
                                        "adresse : ${snapshot.data![index].address}"),
                                  ),
                                  const Spacer(),
                                ],
                              )),
                        ));
                  });
            }
          }
        });
  }
}

class ClassesList extends StatelessWidget {
  const ClassesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getLastClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Spacer(),
                                  ListTile(
                                    title: Text(snapshot.data![index].name,
                                        softWrap: true),
                                    subtitle: Text(
                                        "Type d'événement : ${snapshot.data![index].eventType}"),
                                    leading: const Icon(
                                      Icons.event,
                                      size: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 73),
                                    child:
                                    Text(snapshot.data![index].description),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 73, top: 20),
                                    child: Text(
                                        "adresse : ${snapshot.data![index].address}"),
                                  ),
                                  const Spacer(),
                                ],
                              )),
                        ));
                  });
            }
          }
        });
  }
}

class AftersList extends StatelessWidget {
  const AftersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: MongoDatabase.getLastAfters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.hasError) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Something went wrong, try again.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                              width: 300,
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Spacer(),
                                  ListTile(
                                    title: Text(snapshot.data![index].name,
                                        softWrap: true),
                                    subtitle: Text(
                                        "Type d'événement : ${snapshot.data![index].eventType}"),
                                    leading: const Icon(
                                      Icons.event,
                                      size: 40,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 73),
                                    child:
                                    Text(snapshot.data![index].description),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 73, top: 20),
                                    child: Text(
                                        "adresse : ${snapshot.data![index].address}"),
                                  ),
                                  const Spacer(),
                                ],
                              )),
                        ));
                  });
            }
          }
        });
  }
}