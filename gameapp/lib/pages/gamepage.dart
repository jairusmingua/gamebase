import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/review.dart';
import 'package:gameapp/widgets/gamecard.dart';
import 'package:gameapp/widgets/gamepageappbar.dart';
import 'package:google_fonts/google_fonts.dart';
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
          setState(() {
            _game = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_game == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return [
                SliverPersistentHeader(
                    // floating: true,
                    pinned: true,
                    delegate: GamePageAppBar(
                      game: _game,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        centerTitle: true,
                        actions: [
                          FavoriteIcon(game: _game),
                        ],
                      ),
                    )),
                SliverAppBar(
                  collapsedHeight: 700,
                  expandedHeight: 700,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).backgroundColor,
                  flexibleSpace: GamePageHeader(game: _game),
                ),
                // SliverPersistentHeader(
                //     floating: true,
                //     pinned: true,
                //     delegate: GamePageAppBar(
                //       game: _game,
                //       appBar: AppBar(
                //         backgroundColor: Colors.transparent,
                //         centerTitle: true,
                        
                //       ),
                // )),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Reviews",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .color)),
                      ),
                    ),
                  ]),
                ),
              ];
            },

            // body: Container(height:40,child: Text("hello"))
            // ),
            body: ReviewBody(
              game: _game,
            )),
      );
    }
  }
}

class ReviewBody extends StatefulWidget {
  ReviewBody({this.game});
  final Game game;
  @override
  _ReviewBodyState createState() => _ReviewBodyState();
}

class _ReviewBodyState extends State<ReviewBody> {
  List<Review> _review;

  @override
  void initState() {
    super.initState();

    fetchReviewById(widget.game.gameId).then((value) => {
          setState(() {
            _review = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if(_review==null){
      return Center(child: CircularProgressIndicator());
    }else{
      if(_review.length>0){
        return ListView.builder(
            // padding: const EdgeInsets.all(8),
            itemCount: _review.length,
            itemBuilder: (BuildContext context, int index) {
              return ReviewCards(review: _review[index]);
            });
      }else{
        return Center(child:Text("No Reviews"));
      }
    }
    // return _review != null
    //     ? (ListView.builder(
    //         // padding: const EdgeInsets.all(8),
    //         itemCount: _review.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return ReviewCards(review: _review[index]);
    //         }))
    //     : Center(child: CircularProgressIndicator());
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
      child: Stack(children: [
        Positioned.fill(
          // width: double.infinity,
          child: Image.network(game.imageUrl, fit: BoxFit.fitWidth),
        ),
        Positioned(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: double.infinity,
                color: Colors.black54,
              ),
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
                            game.matureRating,
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
                        game.developer,
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
  ReviewCards({this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          // Flexible(
          //     fit: FlexFit.tight,
          //     flex: 1,
          //     child: Gamecard(
          //       game: review.game,
          //       hasLabels: false,
          //     )),
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(review.username),
                      ),
                      Text(
                        review.reviewText,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.clip,
                      ),
                    ]),
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right:20),
                child: Column(
                  // color:Colors.yellow,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Column(
                      
                      children: [
                        Column(children: [
                          Icon(
                            Icons.star,
                            size: 40,
                            color: Colors.yellow,
                          ),
                          Text(review.starRating.toString() + "/5")
                        ]),
                      ]),]
                ),
              ))
        ],
      ),
    );
  }
}
