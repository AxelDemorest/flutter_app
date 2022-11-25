import 'package:flutter/material.dart';
import 'package:flutter_app/Views/news/news.dart';
import 'package:flutter_app/Views/profile/profileRider.dart';

import '../../Models/Users/userClass.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  List pages = [const NewsPage(title: 'Dernière actualités'),const ProfileRiderPage(title: 'Mon profil'),];

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments;
    print('  off : $user');
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
          onTap: (index){
            setState((){
              _currentIndex = index;
            });
          },
        )

    );
  }
}
