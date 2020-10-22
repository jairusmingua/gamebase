import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/gameinfo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import '../widgets/gamecard.dart';
import '../class/gamelist.dart';

import 'settings.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController controller;
  // FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();

    controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          // toolbarHeight: ,
          title: Text(
            "Jairus Mingua",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool isScrolled) {
                return [
                  SliverAppBar(
                    collapsedHeight: 300,
                    expandedHeight: 300,
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).backgroundColor,
                    flexibleSpace: ProfileHeader(),
                  ),
                  SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: TabDelegate(
                          tabBar: TabBar(
                        tabs: [
                          Tab(
                            text: "Favorites",
                          ),
                          Tab(
                            text: "Reviews",
                          )
                        ],
                        indicatorColor: Colors.red,
                      ))),
                ];
              },
              body: TabBarView(
                children: [FavoriteList(), ReviewList()],
              )),
        ));
  }
}



class FavoriteList extends StatefulWidget {
  
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  FlutterSecureStorage _storage;
  @override
  void initState(){
    super.initState();
    _storage = FlutterSecureStorage();
  }
  Future<List<Game>>fetchFavorites()async{
    var token = await _storage.read(key: "token");
    Map<String, String> allValues = await _storage.readAll();
    var data = fetchUserFavorites(token);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    // GameList game = new GameList();
    // getToken();
    return FutureBuilder(
      future:fetchFavorites(),
      builder: (context,snapshot){
         if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 271/377
                      ), 
                      itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return Gamecard(game:snapshot.data[index]);
                        })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
      }
    );
  }
}
class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: new NetworkImage(
                    'https://avatars3.githubusercontent.com/u/18586619?s=460&u=30a1c6ecfa750c3ea4b86bdbbdfc87556ecdd164&v=4'),
              )),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "cipherxz",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(children: [
                Text("91"),
                Text(
                  "Favorites",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ]),
              Column(children: [
                Text("10"),
                Text(
                  "Reviews",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ])
            ],
          ),
        )
      ],
    );
  }
}

class TabDelegate extends SliverPersistentHeaderDelegate {
  TabDelegate({this.tabBar});
  final TabBar tabBar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.black, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;
}

class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (ListView.builder(
        // padding: const EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ReviewCards();
        }));
  }
}

class ReviewCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Game game = new Game(
      gameTitle:'Call of Duty: Ghosts',
      imageUrl:'https://vignette.wikia.nocookie.net/callofduty/images/9/9b/Call_of_Duty_Ghosts_cover.jpg/revision/latest/top-crop/width/360/height/450?cb=20130501214026',
      synopsis: "Call of Duty: Ghosts is a 2013 first-person shooter",

    );
    return Container(
      height: 150,
      margin:EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Gamecard(game:game,hasLabels: false,)
          ),
          Flexible(
            fit:FlexFit.tight,
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Padding(
                    padding: const EdgeInsets.only(bottom:20),
                    child: Text("Call Of Duty: Ghosts"),
                  ),
                  Text("Call of Duty: Ghosts is a 2013 first-person shooter video game developed by Infinity Ward and published by Activision, it is the tenth major installment",style:Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.clip,),
                  
                ]
              ),
            )
          ),
          Flexible(
            fit:FlexFit.tight,
            flex: 1,
            child: Container(
              // color:Colors.yellow,
              child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                            children: [Column(
                  children:[ Icon(Icons.star,size: 40,color: Colors.yellow,),Text("4/5")]),
                            ]),
            )
          )
        ],
      ),
    );
  }
}
