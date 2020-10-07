import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import '../widgets/gamecard.dart';
import '../class/gamelist.dart';


import 'settings.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _currentTab = 0;
  List<Widget> widgets = [
    Favoritelist(),
    Favoritelist(),
    
  ];
  PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void _changeIndex(int index){
    setState((){
      _currentTab = index;
    });
    print("Change");
  }
  void _changePage(int index){
    setState((){
      _currentTab = index;
      controller.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.ease);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  "cipherxz",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).textTheme.headline1.color)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            'https://avatars3.githubusercontent.com/u/18586619?s=460&u=30a1c6ecfa750c3ea4b86bdbbdfc87556ecdd164&v=4'),
                      )),
                ),
              ),
            ],
          ),
              Profiletab(onchangePage: _changePage,),
              Container(
                height: double.maxFinite,
                width: double.infinity,
                child: PageView(
                  controller: controller,
                  children:widgets,
                  onPageChanged: _changeIndex,
                ),
              )
        ])
        ),
        

      ]),
    );
  }
}
class Favoritelist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GameList game = new GameList();
    return CustomScrollView(
          slivers: [SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:3,
          // mainAxisSpacing: 1,
          // crossAxisSpacing: 5,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Gamecard(game: game.Games[index]);
          },
          childCount: game.Games.length,
        ),
      ),]
    );
  }
}
class Profiletab extends StatelessWidget {
  const Profiletab({
    Key key,
    this.onchangePage
  }) : super(key: key);
 
  final void Function(int) onchangePage;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: StadiumBorder(),
            onPressed: () {
              onchangePage(0);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: Colors.white),
              ),
              child: Text("Favorites",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: StadiumBorder(),
            onPressed: (){
              onchangePage(1);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(width: 3, color: Colors.white),
              ),
              child: Text("Reviews",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ),
        ),
      ],
    ));
  }
}
