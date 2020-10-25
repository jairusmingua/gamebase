import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';
import 'package:gameapp/class/review.dart';
import 'package:gameapp/widgets/ratingpanel.dart';
import 'package:gameapp/widgets/txtbox.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({this.game});
  final Game game;
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int rating = 0;
  int maxLength = 140;
  int reviewLength = 0;
  String _review;
  void _starChange(int index) {
    setState(() {
      rating = index;
    });
    // print(rating);
  }

  void _reviewChange(String review) {
    setState(() {
      reviewLength = review.length;
      
    });
    setState((){
      _review = review;
    });
  }
  void _postReview()async{
    Map<String, dynamic> r = {
      "ReviewText": _review,
      "StarRating": rating
    };
    postReview(r, widget.game.gameId)
      .then((value) => Navigator.pop(context))
      .catchError((error) {
        print(error.toString());
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        minimum: EdgeInsets.all(30),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          // padding: EdgeInsets.only(top:20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text("How would you like to rate")),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 90,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      widget.game.gameTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ))),
                RatingPanel(
                  onChange: _starChange,
                ),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: MultiLineTextBox(
                      "Write Something",
                      height: 300,
                      maxLength: maxLength,
                      onChanged: _reviewChange,
                    )),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: Text(
                      reviewLength.toString() + "/" + maxLength.toString()),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 300,
                    height: 50,
                    child: RaisedButton(
                        onPressed: (){_postReview();},
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.rate_review,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Post Review",
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        ),
                     )),
              ]),
        ),
      ),
    );
  }
}
