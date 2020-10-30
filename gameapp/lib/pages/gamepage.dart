import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameapp/class/avatars.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/review.dart';
import 'package:gameapp/pages/reviewpage.dart';
import 'package:gameapp/widgets/gamecard.dart';
import 'package:gameapp/widgets/gamepageappbar.dart';
import 'package:gameapp/widgets/guestprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../class/game.dart';
import '../widgets/favoriteicon.dart';
import '../widgets/gamepageheader.dart';

class GamePage extends StatefulWidget {
  GamePage({Key key,this.gameId}) : super(key: key);
  final String gameId;
  static const routeName = "/game";
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Game _game;
  final GlobalKey<_ReviewBodyState> _reviewBodyState =
      GlobalKey<_ReviewBodyState>();
  @override
  void initState() {
    super.initState();
    fetchGameById(widget.gameId).then((value) => {
          setState(() {
            _game = value;
          })
        });
  }

  void _refreshList() async {
    _reviewBodyState.currentState.refreshReviews();
  }

  @override
  Widget build(BuildContext context) {
  
    if (_game == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReviewPage(game: _game, onFinish: _refreshList)),
            ).then((value) {
              _refreshList();
            });
          },
          child: Icon(Icons.create),
          backgroundColor: Colors.red,
        ),
        body: Container(
          child: NestedScrollView(
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
                          elevation: 0,
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
                key: _reviewBodyState,
                game: _game,
              )),
        ),
      );
    }
  }
}

class ReviewBody extends StatefulWidget {
  ReviewBody({Key key, this.game}) : super(key: key);
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

  void refreshReviews() {
    fetchReviewById(widget.game.gameId).then((value) => {
          setState(() {
            _review = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_review == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (_review.length > 0) {
        return ListView.builder(
            // padding: const EdgeInsets.all(8),
            itemCount: _review.length,
            itemBuilder: (BuildContext context, int index) {
              return ReviewCards(review: _review[index]);
            });
      } else {
        return Center(child: Text("No Reviews"));
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
      // decoration: BoxDecoration(
      //   boxShadow:[
      //     BoxShadow(
      //     color: Colors.black,
      //   // spreadRadius: 5,
      //   // blurRadius: 7,
      //   // offset: Offset(0, 10), // changes position of shadow
      // ),
      //   ]
      // ),
      margin: EdgeInsets.symmetric(vertical:1,horizontal: 0),
      padding: EdgeInsets.symmetric(vertical:20,horizontal: 15),
      color: Colors.black,
      child: Row(
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                             
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: new NetworkImage(
                                    convertAvatarToUrl(review.avatar)),
                              )),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GuestProfile(userId: review.userId)));
                            },
                            child: Text(review.username,style:Theme.of(context).textTheme.bodyText2)),
                      ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10,0, 0),
                        child: Text(
                          review.reviewText,
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ]),
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                    // color:Colors.yellow,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(children: [
                        Column(children: [
                          Icon(
                            Icons.star,
                            size: 40,
                            color: Colors.yellow,
                          ),
                          Text(review.starRating.toString() + "/5")
                        ]),
                      ]),
                    ]),
              ))
        ],
      ),
    );
  }
}
