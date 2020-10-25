import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/review.dart';
import 'package:gameapp/pages/reviewpage.dart';
import 'package:gameapp/widgets/gamecard.dart';
import 'package:gameapp/widgets/gamepageappbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../class/game.dart';
import '../widgets/favoriteicon.dart';
import '../widgets/gamepageheader.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
             Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReviewPage(game:_game)),
                );
          },
          child: Icon(Icons.create),
          backgroundColor: Colors.red,
        ),
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
                  flexibleSpace: GamePageHeader(game:_game),
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
