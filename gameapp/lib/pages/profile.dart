import 'dart:math';
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

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController controller;
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
          backgroundColor: Theme.of(context).backgroundColor,
          centerTitle: true,
          // toolbarHeight: ,
          title: Text(
            "Jairus Mingua",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverPersistentHeader(
              delegate: ProfileView(maxExtent: 350, minExtent: 150)),
          SliverFillRemaining(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  
                  title: TabBar(
                    tabs: [
                     
                      Tab(icon: Icon(Icons.favorite)),
                      Tab(icon: Icon(Icons.star)),
                    ],
                  ),
                  
                ),
                // body: TabBarView(
                //   children: [
                //     FavoriteList(),
                //     // Icon(Icons.directions_bike),
                //     Icon(Icons.directions_bike),
           
                //   ],
                // ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TabBarView(
              controller: controller,
                  children: [
                    FavoriteList(),
                    // Icon(Icons.directions_bike),
                    Icon(Icons.directions_bike),
           
                  ],
                ),
          )
          
        ]));
  }
}
class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  GameList game = new GameList();
    return(
      GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        )
    );
  }
}
class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(        
        children: [
          Container(
                  margin: EdgeInsets.only(top:50),
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
                    child: Text("cipherxz",style: Theme.of(context).textTheme.bodyText1,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children:[
                          Text("91"),
                          Text("Favorites",style: Theme.of(context).textTheme.subtitle1,),
                        ]
                      ),
                      Column(
                        children:[
                          Text("10"),
                         Text("Reviews",style: Theme.of(context).textTheme.subtitle1,),
                        ]
                      )
                    ],
                  ),
                )
        ],
    );
  }
}
class ProfileView extends SliverPersistentHeaderDelegate {
  ProfileView({this.minExtent, @required this.maxExtent});
  final double minExtent;
  final double maxExtent;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ProfileHeader(),
        
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
