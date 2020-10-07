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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        // toolbarHeight: ,
        title: Text("Jairus Mingua",style: Theme.of(context).textTheme.bodyText2,),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
              ]
            ),
          ),
          SliverAppBar(
            
          ),
          SliverList(delegate: SliverChildListDelegate([
           
          ]))
        ],
      ),
    );
  }
}
