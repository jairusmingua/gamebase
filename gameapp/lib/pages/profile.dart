import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/gameinfo.dart';
import 'package:gameapp/class/review.dart';
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
    
  }

  @override
  Widget build(BuildContext context) {
    // GameList game = new GameList();
    // getToken();
    return FutureBuilder(
      future:fetchUserFavorites(),
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

class ReviewList extends StatefulWidget {
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserReview(),
      builder: (context,AsyncSnapshot<List<Review>>snapshot){
          if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return ReviewCards(review:snapshot.data[index]);
        })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
      },
    );
    // return (ListView.builder(
    //     // padding: const EdgeInsets.all(8),
    //     itemCount: 5,
    //     itemBuilder: (BuildContext context, int index) {
    //       return ReviewCards();
    //     }));
  }
}

class ReviewCards extends StatelessWidget {
  ReviewCards({this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin:EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Gamecard(game:review.game,hasLabels: false,)
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
                    child: Text(review.game.gameTitle),
                  ),
                  Text(review.reviewText,style:Theme.of(context).textTheme.subtitle1,overflow: TextOverflow.clip,),
                  
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
                  children:[ Icon(Icons.star,size: 40,color: Colors.yellow,),Text(review.starRating.toString()+"/5")]),
                            ]),
            )
          )
        ],
      ),
    );
  }
}
