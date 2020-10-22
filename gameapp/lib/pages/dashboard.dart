import 'package:flutter/material.dart';
import 'gamepage.dart';
import 'home.dart';
import 'profile.dart';
import 'settings.dart';
import  'login.dart';
import '../class/gamelist.dart';
class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GameList game = new GameList();
  int _currentIndex = 0;
 
  // PageController controller = PageController(
  //   initialPage: 0,
  //   keepPage: true
  // );
  void _changeIndex(int index){
    setState((){
      _currentIndex = index;
      // controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
  // void _pageControllerChange(int index){
  //   setState((){
  //     _currentIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      Home(),
      // GamePage(game:game.Games[0]),
      Profile(),
      Settings()
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:Center(child: widgets.elementAt(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: "Settings"),
        ],
        currentIndex: _currentIndex,
        onTap: _changeIndex,
      
      )
    );
  }
}

