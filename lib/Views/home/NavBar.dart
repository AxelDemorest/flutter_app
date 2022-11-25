import 'package:flutter/material.dart';
import 'package:flutter_app/Models/Users/userModel.dart';
import 'package:flutter_app/Views/news/news.dart';
import 'package:flutter_app/Views/profile/profileRider.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //User user = new User(M.ObjectId(), "toto", "test", "lastName", "email", "tt", "tt", 45, DateTime.now());
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {
     User user = ModalRoute.of(context)!.settings.arguments as User;


     List pages = [
       NewsPage(title: 'Dernière actualités'),
       ProfileRiderPage(title: 'Profile', userParam: user),
     ];
    return Scaffold(
        body: Center(
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.orange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_user),
              label: 'Profile',
              backgroundColor: Colors.orange,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
