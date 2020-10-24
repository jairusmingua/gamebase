import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/widgets/gamecard.dart';
import 'package:gameapp/widgets/gamepageappbar.dart';
import 'package:intl/intl.dart';
import '../class/game.dart';
import '../widgets/favoriteicon.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key, this.game}) : super(key: key);
  final Game game;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Game _game;
  @override
  void initState() {
    super.initState();
    fetchGameById(widget.game.gameId).then((value) => {
      setState((){
        _game=value;

      })

    });
    
  } 
  @override
  Widget build(BuildContext context) {
    if(_game ==null){
      return Center(child:CircularProgressIndicator());
    }else{

    return 
            Scaffold(
          body: Stack(children: [
        CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate: GamePageAppBar(
                game:widget.game,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FavoriteIcon(game: _game,),
                    )
                  ],
                )),
            floating: true,
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  [GamePageHeader(game: widget.game),  Text("Reviews", style: Theme.of(context).textTheme.headline2),])),
          SliverFixedExtentList(delegate: SliverChildBuilderDelegate(
            (context,index)=>ReviewCards()
          ),itemExtent: 200)
        ]),
      ])
    );
    }
  }
}

class ReviewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
       children:[
        Text("Reviews", style: Theme.of(context).textTheme.headline2),
        Text("Reviews", style: Theme.of(context).textTheme.headline2),
        
        
      ],
    );
  }
}

class GamePageHeader extends StatelessWidget {
  GamePageHeader({this.game});
  final Game game;
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = new DateFormat('yMMMMd');
    DateFormat yearFormater = new DateFormat('y');
    String date = formatter.format(DateTime.parse(game.releaseDate));
    String year = yearFormater.format(DateTime.parse(game.releaseDate));
    return Container(
      // height: MediaQuery.of(context).size.height*0.75,
      child: Stack(children: [
        Positioned.fill(
          // width: double.infinity,
          child: Image.network(game.imageUrl, fit: BoxFit.fitWidth),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Colors.black54,
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            // color: Colors.black38,
          ),
        ),
        Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: 123 / 171,
                    child: Image.network(game.imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        year,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Text(
                            "PG",
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(children: [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.yellow,
                        ),
                        Text("4/5")
                      ]),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Text(
                    game.gameTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 100,
                    child: Text(
                      game.synopsis,
                      style: Theme.of(context).textTheme.subtitle1,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(children: [
                      Text(
                        "Release Date: ",
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                    ]),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(children: [
                    Row(children: [
                      Text(
                        "Developer: ",
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        'N/A',
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.fade,
                      ),
                    ]),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
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
      gameTitle: 'Call of Duty: Ghosts',
      imageUrl:
          'https://vignette.wikia.nocookie.net/callofduty/images/9/9b/Call_of_Duty_Ghosts_cover.jpg/revision/latest/top-crop/width/360/height/450?cb=20130501214026',
      synopsis: "Call of Duty: Ghosts is a 2013 first-person shooter",
    );
    return Container(
      height: 150,
      margin: EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Gamecard(
                game: game,
                hasLabels: false,
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text("Call Of Duty: Ghosts"),
                      ),
                      Text(
                        "Call of Duty: Ghosts is a 2013 first-person shooter video game developed by Infinity Ward and published by Activision, it is the tenth major installment",
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.clip,
                      ),
                    ]),
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                // color:Colors.yellow,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Icon(
                          Icons.star,
                          size: 40,
                          color: Colors.yellow,
                        ),
                        Text("4/5")
                      ]),
                    ]),
              ))
        ],
      ),
    );
  }
}
